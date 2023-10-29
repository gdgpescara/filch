import {auth, firestore} from "firebase-admin";
import {PointsTypeEnum} from "./points-type-enum";
import Timestamp = firestore.Timestamp;
import UserRecord = auth.UserRecord;

export type Points = {
  assignedBy: UserRecord | null;
  type: PointsTypeEnum;
  points: number;
  assignedAt: Timestamp;
}
