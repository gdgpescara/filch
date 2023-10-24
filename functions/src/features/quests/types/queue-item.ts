import {auth, firestore} from "firebase-admin";
import Timestamp = firestore.Timestamp;
import UserRecord = auth.UserRecord;

export type QueueItem = {
  user: UserRecord;
  queuedAt: Timestamp;
}
