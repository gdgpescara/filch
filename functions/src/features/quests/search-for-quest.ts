import {HttpsError, onCall} from "firebase-functions/v2/https";
import {getFirestore, Timestamp} from "firebase-admin/firestore";
import {getSignedInUser} from "../../shared/get_signed_in_user";
import {QuestTypeEnum} from "./types/quest-type-enum";
import {Quest} from "./types/quest";
import {ActiveQuest} from "./types/active-quest";
import {logger} from "firebase-functions/v2";
import {randomIntFromInterval} from "../../shared/utils";

export const searchForQuest = onCall(
  {region: "europe-west3"},
  async (request) => {
    const loggedUser = await getSignedInUser(request);

    // Search for a quest
    let questFound: ActiveQuest | undefined = undefined;

    // 1. Search if actor quest is available
    logger.info("Searching for actor quest");
    const actorQuestsSnapshot = await getFirestore()
      .collection("quests")
      .where("type", "==", QuestTypeEnum.actor)
      .where("requestAccepted", "==", true)
      .get();

    const actorQuests = actorQuestsSnapshot.docs.filter((doc) => {
      return doc.data().validityStart <= Timestamp.now() &&
        doc.data().validityEnd > Timestamp.now();
    });

    if (actorQuests.length > 0) {
      logger.info("Actor quest found");
      const randomIndex = randomIntFromInterval(0, actorQuests.length - 1);
      questFound = <ActiveQuest>{
        quest: <Quest>{
          ...actorQuests[randomIndex].data(),
          id: actorQuests[randomIndex].id,
        },
        activatedAt: Timestamp.now(),
      };
    }

    // 2. Search if quiz quest if actor quest is not available
    if (!questFound) {
      logger.info("Searching for quiz quest");
      const quizQuestsSnapshot = await getFirestore()
        .collection("quests")
        .where("type", "==", QuestTypeEnum.quiz)
        .get();

      const quizQuests = quizQuestsSnapshot.docs.filter((doc) => {
        return doc.data().validityStart <= Timestamp.now() &&
          doc.data().validityEnd > Timestamp.now();
      });

      if (quizQuests.length > 0) {
        logger.info("Quiz quest found");
        const randomIndex = randomIntFromInterval(0, quizQuests.length - 1);
        questFound = <ActiveQuest>{
          quest: <Quest>{
            ...quizQuests[randomIndex].data(),
            id: quizQuests[randomIndex].id,
          },
          activatedAt: Timestamp.now(),
        };
      }
    }

    // 3. Search if social quest if actor quest and quiz quest are not available
    if (!questFound) {
      logger.info("Searching for social quest");
      const socialQuestsSnapshot = await getFirestore()
        .collection("quests")
        .where("type", "==", QuestTypeEnum.social)
        .get();

      const socialQuests = socialQuestsSnapshot.docs.filter((doc) => {
        return doc.data().validityStart <= Timestamp.now() &&
          doc.data().validityEnd > Timestamp.now();
      });

      if (socialQuests.length > 0) {
        logger.info("Social quest found");
        const randomIndex = randomIntFromInterval(0, socialQuests.length - 1);
        questFound = <ActiveQuest>{
          quest: <Quest>{
            ...socialQuests[randomIndex].data(),
            id: socialQuests[randomIndex].id,
          },
          activatedAt: Timestamp.now(),
        };
      }
    }

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
        .collection("queue").add({
          userId: loggedUser.uid,
          queuedAt: Timestamp.now(),
        });
    }

    logger.info(`Finish, quest found is: ${JSON.stringify(questFound)}`);
  });
