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
import {cutPeople} from "./features/communities/cut-people";
import {detectEmotions} from "./features/communities/detect-emotions";
import {getFadeFromTime} from "./features/communities/get-fade-from-time";
import {
  getFadeFromTimeTimestamp,
} from "./features/communities/get-fade-from-time-timestamp";

initializeApp();

// exports.onUserDeleteSentinel = onUserDeleteSentinel;
// exports.onUserCreateSentinel = onUserCreateSentinel;
// exports.tShirtPickUp = tShirtPuckUp;

exports.actorQueueSentinel = actorQueueSentinel;
exports.searchForQuest = searchForQuest;
exports.submitAnswer = submitAnswer;
exports.scanOtherAttendee = scanOtherAttendee;
exports.removeActiveQuest = removeActiveQuest;

// Cron jobs [Start]
// exports.questQueueCleanerSchedule = activeQuestsCleanerSchedule;
// exports.removedQuestSchedule = removedQuestSchedule;
// exports.tShirtNotificationSchedule = tShirtNotificationSchedule;
// Cron jobs [End]

exports.assignPoints = assignPoints;
exports.userPointsSentinel = userPointsSentinel;

exports.cutPeople = cutPeople;
exports.detectEmotions = detectEmotions;
// Cron jobs [Start]
// exports.fadeFromTime = fadeFromTime;
// Cron jobs [End]
exports.getFadeFromTime = getFadeFromTime;
exports.getFadeFromTimeTimestamp = getFadeFromTimeTimestamp;
