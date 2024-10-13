import {HttpsError, onCall} from "firebase-functions/v2/https";
import {getSignedInUser} from "../../shared/get_signed_in_user";
import {Quest} from "./types/quest";
import {getFirestore, Timestamp} from "firebase-admin/firestore";
import {Points} from "../points/types/points";
import {PointsTypeEnum} from "../points/types/points-type-enum";
import {logger} from "firebase-functions/v2";

export const submitAnswer = onCall(
  {region: "europe-west3"},
  async (request) => {
    const loggedUser = await getSignedInUser(request);
    const questId = request.data.quest as string;
    const answers = request.data.answers as number[];
    const questSnap = await getFirestore()
      .collection("quests")
      .doc(questId)
      .get();
    if (!questSnap.data()) {
      throw new HttpsError("not-found", "Quest not found");
    }
    const quest = <Quest>{...questSnap.data(), id: questSnap.id};

    logger.info("Quest answers: " + quest.id);

    const correctAnswers = quest.answers
      ?.filter((answer) => answer.isCorrect)
      .map((answer) => answer.id);

    if (!correctAnswers) {
      throw new HttpsError("not-found", "Quest has no correct answers");
    }

    logger.info("Correct answers: " + correctAnswers);

    const isCorrect = correctAnswers.every((e) => answers.includes(e));

    logger.info("Is correct: " + isCorrect);

    const archivedPoints = <Points>{
      type: PointsTypeEnum.quest,
      points: quest.points,
      assignedAt: Timestamp.now(),
    };

    const batch = getFirestore().batch();
    if (isCorrect) {
      batch.set(
        getFirestore()
          .collection("users")
          .doc(loggedUser.uid)
          .collection("points")
          .doc(quest.id),
        archivedPoints,
      );
    }

    batch.update(
      getFirestore().collection("users").doc(loggedUser.uid),
      {
        activeQuest: null,
      },
    );

    await batch.commit();

    return isCorrect;
  });
