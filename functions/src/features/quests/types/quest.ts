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
  subType: QuestSubTypeEnum | null;

  // Actor & community quest section
  queueTime: number | null;
  actor: string | null;
  maxQueue: number | null;
  groupSize: number | null;
  requestAccepted: boolean | null;
  promptFunction: string | null;

  // Quiz quest section
  parentQuests: string[] | null;
  qrCode: string | null;
  question: { [key: string]: string } | null;
  answers: Answer[] | null;

  // Social quest section
  verificationFunction: string | null;
}
