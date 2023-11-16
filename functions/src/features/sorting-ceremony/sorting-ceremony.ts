import {getAuth} from "firebase-admin/auth";
import {logger} from "firebase-functions/v2";
import {getFirestore, QueryDocumentSnapshot} from "firebase-admin/firestore";
import {sortingHatAlgorithm} from "./sorting-hat-algorithm";
import {HttpsError, onCall} from "firebase-functions/v2/https";
import {getSignedInUser} from "../../shared/get_signed_in_user";

export type Member = {
  displayName?: string;
  email?: string;
  photoURL?: string;
  points: number;
};

export const sortingCeremony = onCall(
  {region: "europe-west3"},
  async (request) => {
    const loggedUser = await getSignedInUser(request);

    if (loggedUser.customClaims?.house) {
      logger.error("User already has a house");
      throw new HttpsError("already-exists", "User already has a house");
    }

    const housesSnapshot = await getFirestore()
      .collection("houses")
      .get();

    const speakerSnap = await getFirestore()
      .collection("speakers")
      .doc(loggedUser.email ?? loggedUser.uid)
      .get();

    let house: QueryDocumentSnapshot | undefined;
    if (speakerSnap.exists) {
      logger.info("User is a speaker");
      house = housesSnapshot.docs.find(
        (doc) => doc.id === speakerSnap.data()?.house,
      );
    }

    if (!house) {
      house = sortingHatAlgorithm(housesSnapshot.docs);
    }

    let member: Member = {
      points: 0,
    };

    if (loggedUser.displayName) {
      member = {
        ...member,
        displayName: loggedUser.displayName,
      };
    }

    if (loggedUser.email) {
      member = {
        ...member,
        email: loggedUser.email,
      };
    }

    if (loggedUser.photoURL) {
      member = {
        ...member,
        photoURL: loggedUser.photoURL,
      };
    }
    await getFirestore()
      .collection("houses")
      .doc(house.id)
      .collection("members")
      .doc(loggedUser.uid)
      .set(member);

    await getAuth().setCustomUserClaims(loggedUser.uid, {
      house: house.id,
      ...loggedUser.customClaims,
    });

    logger.info("Assigned house", house.id, "to user", loggedUser.email);

    return house.id;
  });
