import {HttpsError, onCall} from "firebase-functions/v2/https";
import {getSignedInUser} from "../../shared/get_signed_in_user";
import {Quest} from "./types/quest";
import {getFirestore, Timestamp} from "firebase-admin/firestore";
import {Points} from "../points/types/points";
import {PointsTypeEnum} from "../points/types/points-type-enum";

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
    const quest = questSnap.data() as Quest | null;
    if (!quest) {
      throw new HttpsError("not-found", "Quest not found");
    }
    const correctAnswers = quest.answers
      ?.filter((answer) => answer.isCorrect)
      .map((answer) => answer.id);

    if (!correctAnswers) {
      throw new HttpsError("not-found", "Quest has no correct answers");
    }

    const isCorrect = correctAnswers.every((e) => answers.includes(e));
    const house = loggedUser.customClaims?.["house"];

    const archivedPoints = <Points>{
      type: PointsTypeEnum.quest,
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
