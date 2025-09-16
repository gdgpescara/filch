import { initializeApp } from "firebase-admin/app";
import { searchForQuest } from "./features/quests/search-for-quest";
import { actorQueueSentinel } from "./features/quests/actor-quest-queue-manager";
import { removeActiveQuest } from "./features/quests/remove-active-quest";
import { submitAnswer } from "./features/points/submit-answer";
import { onUserCreateSentinel, onUserDeleteSentinel } from "./features/user/user_manager";

initializeApp();

exports.onUserDeleteSentinel = onUserDeleteSentinel;
exports.onUserCreateSentinel = onUserCreateSentinel;
// exports.tShirtPickUp = tShirtPuckUp;

exports.actorQueueSentinel = actorQueueSentinel;
exports.searchForQuest = searchForQuest;
exports.submitAnswer = submitAnswer;
// exports.scanOtherAttendee = scanOtherAttendee;
exports.removeActiveQuest = removeActiveQuest;

// Cron jobs [Start]
// exports.questQueueCleanerSchedule = activeQuestsCleanerSchedule;
// exports.removedQuestSchedule = removedQuestSchedule;
// exports.tShirtNotificationSchedule = tShirtNotificationSchedule;
// Cron jobs [End]

// exports.assignPoints = assignPoints;
// exports.userPointsSentinel = userPointsSentinel;

// exports.cutPeople = cutPeople;
// exports.detectEmotions = detectEmotions;
// Cron jobs [Start]
// exports.fadeFromTime = fadeFromTime;
// Cron jobs [End]
// exports.getFadeFromTime = getFadeFromTime;
// exports.getFadeFromTimeTimestamp = getFadeFromTimeTimestamp;
