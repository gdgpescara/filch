import {onCall} from "firebase-functions/v2/https";
import {getSignedInUser} from "../../shared/get_signed_in_user";
import {Quest} from "./types/quest";
import {getFirestore, Timestamp} from "firebase-admin/firestore";
import {Points} from "../points/types/points";

export const submitAnswer = onCall(
  {region: "europe-west3"},
  async (request) => {
    const loggedUser = await getSignedInUser(request);
    const quest = request.data.quest as Quest;
    const answers = request.data.answers as number[];
    const correctAnswers = quest.answers
      ?.filter((answer) => answer.isCorrect)
      .map((answer) => answer.id);

    if (!correctAnswers) {
      throw new Error("Quest has no correct answers");
    }

    const isCorrect = correctAnswers.every((e) => answers.includes(e));
    const house = loggedUser.customClaims?.["house"];

    const archivedPoints = <Points>{
      quest: quest,
      points: isCorrect ? quest.points : -quest.malus,
      assignedAt: Timestamp.now(),
    };

    const batch = getFirestore().batch();
    batch.set(
      getFirestore()
        .collection("users")
        .doc(loggedUser.uid)
        .collection("points")
        .doc(quest.id),
      archivedPoints,
    );
    batch.set(
      getFirestore()
        .collection("houses")
        .doc(house)
        .collection("members")
        .doc(loggedUser.uid)
        .collection("points")
        .doc(quest.id),
      archivedPoints,
    );
    batch.update(
      getFirestore().collection("users").doc(loggedUser.uid),
      {
        activeQuest: null,
      },
    );

    await batch.commit();

    return isCorrect;
  });
