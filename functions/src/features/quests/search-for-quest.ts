import {HttpsError, onCall} from "firebase-functions/v2/https";
import {Filter, getFirestore, Timestamp} from "firebase-admin/firestore";
import {getSignedInUser} from "../../shared/get_signed_in_user";
import {QuestTypeEnum} from "./types/quest-type-enum";
import {ActiveQuest} from "./types/active-quest";
import {logger} from "firebase-functions/v2";
import {randomIntFromInterval} from "../../shared/utils";
import {Quest} from "./types/quest";
import {Points} from "../points/types/points";
import {PointsTypeEnum} from "../points/types/points-type-enum";
import {auth} from "firebase-admin";
import {QuestSubTypeEnum} from "./types/quest-sub-type-enum";
import {promptFunctionsList} from "./prompt-functions";
import {LocalizedField} from "./types/localized-field";
import UserRecord = auth.UserRecord;

export const searchForQuest = onCall(
  {region: "europe-west3"},
  async (request) => {
    const loggedUser = await getSignedInUser(request);

    // Get configurations
    const config = await getFirestore()
      .collection("configurations")
      .doc("feature_flags")
      .get();

    const questsOrder = [
      QuestTypeEnum.actor,
      QuestTypeEnum.quiz,
      QuestTypeEnum.community,
      QuestTypeEnum.social,
    ];
    const actorQuestEnabled = config.data()?.actorQuestEnabled ?? false;
    const quizQuestEnabled = config.data()?.quizQuestEnabled ?? false;
    const communityQuestEnabled = config.data()?.communityQuestEnabled ?? false;
    const socialQuestEnabled = config.data()?.socialQuestEnabled ?? false;

    logger.info("Quests order: " + JSON.stringify(questsOrder));
    logger.info("Can search for actor quest: " + actorQuestEnabled);
    logger.info("Can search for quiz quest: " + quizQuestEnabled);
    logger.info("Can search for community quest: " + communityQuestEnabled);
    logger.info("Can search for social quest: " + socialQuestEnabled);

    const userPointsSnap = await getFirestore()
      .collection("users")
      .doc(loggedUser.uid)
      .collection("points")
      .get();
    const userQuestPoints = userPointsSnap.docs
      .map((doc) => {
        return <Points>{...doc.data()};
      })
      .filter((value) => value.type == PointsTypeEnum.quest && value.quest)
      .map((value) => value.quest);
    logger.debug("User quest points: " + JSON.stringify(userQuestPoints));

    const removedQuestsSnap = await getFirestore()
      .collection("users")
      .doc(loggedUser.uid)
      .collection("removedQuests")
      .get();
    const removedQuests = removedQuestsSnap.docs.map((doc) => doc.id);
    logger.debug("Removed quests: " + JSON.stringify(removedQuests));

    // Search for a quest
    let questFound: ActiveQuest | undefined = undefined;

    for (const questType of questsOrder) {
      if (questFound) {
        break;
      }
      switch (questType) {
      case QuestTypeEnum.actor:
        if (!questFound && actorQuestEnabled) {
          questFound = await searchForActorQuest(
            loggedUser,
            userQuestPoints,
            removedQuests
          );
        }
        break;
      case QuestTypeEnum.quiz:
        if (!questFound && quizQuestEnabled) {
          questFound = await searchForQuizQuest(
            loggedUser,
            userQuestPoints,
            removedQuests
          );
        }
        break;
      case QuestTypeEnum.community:
        if (!questFound && communityQuestEnabled) {
          questFound = await searchForCommunityQuest(
            loggedUser,
            userQuestPoints,
            removedQuests
          );
        }
        break;
      case QuestTypeEnum.social:
        if (!questFound && socialQuestEnabled) {
          questFound = await searchForSocialQuest(
            loggedUser,
            userQuestPoints,
            removedQuests
          );
        }
        break;
      }
    }

    // 3. Search if social quest if actor quest and quiz quest are not available
    if (!questFound) {
      throw new HttpsError("not-found", "No quest found");
    }

    // Set quest to user
    logger.info("Setting quest to user");
    await getFirestore().collection("users").doc(loggedUser.uid).update({
      activeQuest: questFound,
    });

    // If actor quest, add user to queue
    if (questFound.quest.type == QuestTypeEnum.actor) {
      logger.info("Adding user to queue");
      await getFirestore()
        .collection("quests")
        .doc(questFound.quest.id)
        .collection("queue")
        .doc(loggedUser.uid).set({
          userId: loggedUser.uid,
          queuedAt: Timestamp.now(),
        });
      // Update queue count
      const queueCount = await getFirestore()
        .collection("quests")
        .doc(questFound.quest.id)
        .collection("queue")
        .count()
        .get();
      await getFirestore()
        .collection("quests")
        .doc(questFound.quest.id)
        .update({
          queueCount: queueCount.data().count,
        });
    }

    logger.info(`Finish, quest found is: ${JSON.stringify(questFound)}`);
  });


const searchForActorQuest = async (
  loggedUser: UserRecord,
  userQuestPoints: (string | null)[],
  removedQuests: string[]
): Promise<ActiveQuest | undefined> => {
  logger.info("Searching for actor quest");
  const actorQuestsSnapshot = await getFirestore()
    .collection("quests")
    .where("type", "==", QuestTypeEnum.actor)
    .where("requestAccepted", "==", true)
    .get();

  const actorQuests = actorQuestsSnapshot.docs.filter((doc) => {
    return doc.data().validityStart <= Timestamp.now() &&
      doc.data().validityEnd > Timestamp.now() &&
      (!doc.data().queueCount ||
        doc.data().queueCount < doc.data().maxQueue) &&
      !userQuestPoints.includes(doc.id) && !removedQuests.includes(doc.id);
  });

  logger.info(`Found ${actorQuests.length} actor quests`);

  if (actorQuests.length > 0) {
    logger.info("Search for actor quest");
    // const randomIndex = randomIntFromInterval(0, actorQuests.length - 1);
    const questSnap = actorQuests
      .reduce((prev, current) => {
        return prev.data().queueCount > current.data().queueCount ?
          prev :
          current;
      });
    const quest = <Quest>{
      ...questSnap.data(),
      id: questSnap.id,
    };


    let prompt: LocalizedField | undefined = undefined;

    if (quest.subType === QuestSubTypeEnum.prompted && quest.promptFunction) {
      logger.info("Found prompted actor quest, " +
        "try to get prompt from:" + quest.promptFunction);
      prompt = await promptFunctionsList[quest.promptFunction]();
    }

    let activeQuest = <ActiveQuest>{
      quest: quest,
      activatedAt: Timestamp.now(),
    };

    if (prompt) {
      activeQuest = <ActiveQuest>{
        ...activeQuest,
        prompt: prompt,
      };
    }

    return activeQuest;
  }
  return undefined;
};

const searchForQuizQuest = async (
  loggedUser: UserRecord,
  userQuestPoints: (string | null)[],
  removedQuests: string[]
): Promise<ActiveQuest | undefined> => {
  logger.info("Searching for quiz quest");
  const quizQuestsSnapshot = await getFirestore()
    .collection("quests")
    .where("type", "==", QuestTypeEnum.quiz)
    .where(
      userQuestPoints && userQuestPoints.length > 0 ?
        Filter.or(
          Filter.where(
            "parentQuests",
            "array-contains-any",
            userQuestPoints
          ),
          Filter.where("parentQuests", "==", null)
        ) :
        Filter.where("parentQuests", "==", null)
    )
    .get();

  const quizQuests = quizQuestsSnapshot.docs.filter((doc) => {
    const valid = doc.data().validityStart <= Timestamp.now() &&
      doc.data().validityEnd > Timestamp.now() &&
      !userQuestPoints.includes(doc.id) && !removedQuests.includes(doc.id);
    const parentQuests = doc.data().parentQuests;
    if (!parentQuests) {
      return valid;
    }
    return parentQuests.every((value: string) => {
      return userQuestPoints.includes(value);
    }) && valid;
  });

  logger.info(`Found ${quizQuests.length} quiz quests`);

  if (quizQuests.length > 0) {
    const randomIndex = randomIntFromInterval(0, quizQuests.length - 1);
    return <ActiveQuest>{
      quest: <Quest>{
        ...quizQuests[randomIndex].data(),
        id: quizQuests[randomIndex].id,
      },
      activatedAt: Timestamp.now(),
    };
  }
  return undefined;
};

const searchForCommunityQuest = async (
  loggedUser: UserRecord,
  userQuestPoints: (string | null)[],
  removedQuests: string[]
): Promise<ActiveQuest | undefined> => {
  logger.info("Searching for community quest");
  const communityQuestsSnapshot = await getFirestore()
    .collection("quests")
    .where("type", "==", QuestTypeEnum.community)
    .get();

  const communityQuests = communityQuestsSnapshot.docs.filter((doc) => {
    return doc.data().validityStart <= Timestamp.now() &&
      doc.data().validityEnd > Timestamp.now() &&
      !userQuestPoints.includes(doc.id) && !removedQuests.includes(doc.id);
  });

  logger.info(`Found ${communityQuests.length} community quests`);

  if (communityQuests.length > 0) {
    const randomIndex = randomIntFromInterval(0, communityQuests.length - 1);
    return <ActiveQuest>{
      quest: <Quest>{
        ...communityQuests[randomIndex].data(),
        id: communityQuests[randomIndex].id,
      },
      activatedAt: Timestamp.now(),
    };
  }
  return undefined;
};

const searchForSocialQuest = async (
  loggedUser: UserRecord,
  userQuestPoints: (string | null)[],
  removedQuests: string[]
): Promise<ActiveQuest | undefined> => {
  logger.info("Searching for social quest");
  const socialQuestsSnapshot = await getFirestore()
    .collection("quests")
    .where("type", "==", QuestTypeEnum.social)
    .get();

  const socialQuests = socialQuestsSnapshot.docs.filter((doc) => {
    return doc.data().validityStart <= Timestamp.now() &&
      doc.data().validityEnd > Timestamp.now() &&
      !removedQuests.includes(doc.id);
  });

  logger.info(`Found ${socialQuests.length} social quests`);

  if (socialQuests.length > 0) {
    logger.info("Social quest found");
    const randomIndex = randomIntFromInterval(0, socialQuests.length - 1);
    return <ActiveQuest>{
      quest: <Quest>{
        ...socialQuests[randomIndex].data(),
        id: socialQuests[randomIndex].id,
      },
      activatedAt: Timestamp.now(),
    };
  }
  return undefined;
};
