import {logger} from "firebase-functions/v2";
import {CallableRequest, HttpsError} from "firebase-functions/v2/https";
import {getAuth} from "firebase-admin/auth";

export const getSignedInUser = async (request: CallableRequest) => {
  const uid = request.auth?.uid;

  if (!uid) {
    logger.error("User is not logged in");
    throw new HttpsError("unauthenticated", "User is not logged in");
  }

  return await getAuth().getUser(uid);
};
