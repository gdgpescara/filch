import {initializeApp} from "firebase-admin/app";
import {searchForQuest} from "./features/quests/search-for-quest";
import {actorQueueSentinel} from "./features/quests/actor-quest-queue-manager";
import {userPointsSentinel} from "./features/points/points-manager";
import {assignPoints} from "./features/points/assign-points";
import {
  onUserCreateSentinel,
  onUserDeleteSentinel,
} from "./features/user/user_manager";
import {removeActiveQuest} from "./features/quests/remove-active-quest";
import {tShirtPuckUp} from "./features/user/t-shirt-pick-up";
import {scanOtherAttendee} from "./features/points/scan-other-attendee";
import {submitAnswer} from "./features/points/submit-answer";

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
