import {QuestTypeEnum} from "./quest-type-enum";
import {Answer} from "./answer";
import {QuestSubTypeEnum} from "./quest-sub-type-enum";

export type Quest = {
  id: string;
  description: { [key: string]: string };
  points: number;
  validityStart: Date;
  validityEnd: Date;
  executionTime: number;
  type: QuestTypeEnum;

  // Actor quest section
  queueTime: number | null;
  actor: string | null;
  maxQueue: number | null;
  groupSize: number | null;
  requestAccepted: boolean | null;

  // Quiz quest section
  parentQuest: string | null;
  qrCode: string | null;
  question: { [key: string]: string } | null;
  answers: Answer[] | null;

  // Social quest section
  subType: QuestSubTypeEnum | null;
  verificationFunction: string | null;
}
