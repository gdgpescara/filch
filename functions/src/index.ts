import {initializeApp} from "firebase-admin/app";
import {searchForQuest} from "./features/quests/search-for-quest";
import {actorQueueSentinel} from "./features/quests/actor-quest-queue-manager";
import {submitAnswer} from "./features/quests/submit-answer";
import {userPointsSentinel} from "./features/points/points-manager";
import {assignPoints} from "./features/points/assign-points";
import {
  onUserCreateSentinel,
  onUserDeleteSentinel,
} from "./features/user/user_manager";
import {scanOtherAttendee} from "./features/quests/social_qr_code_quest";
import {removeActiveQuest} from "./features/quests/remove-active-quest";
import {tShirtPuckUp} from "./features/user/t-shirt-pick-up";

initializeApp();

exports.onUserDeleteSentinel = onUserDeleteSentinel;
exports.onUserCreateSentinel = onUserCreateSentinel;
exports.tShirtPickUp = tShirtPuckUp;

exports.actorQueueSentinel = actorQueueSentinel;
exports.searchForQuest = searchForQuest;
exports.submitAnswer = submitAnswer;
exports.scanOtherAttendee = scanOtherAttendee;
exports.removeActiveQuest = removeActiveQuest;

// Cron jobs [Start]
// exports.questQueueCleaner = activeQuestsCleaner;
// exports.removedQuestCron = removedQuestCron;
// Cron jobs [End]

exports.assignPoints = assignPoints;
exports.userPointsSentinel = userPointsSentinel;
