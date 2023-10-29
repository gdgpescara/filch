import {auth, firestore} from "firebase-admin";
import {Quest} from "../../quests/types/quest";
import Timestamp = firestore.Timestamp;
import UserRecord = auth.UserRecord;

export type Points = {
  assignedBy: UserRecord | null;
  quest: Quest | null;
  points: number;
  assignedAt: Timestamp;
}
