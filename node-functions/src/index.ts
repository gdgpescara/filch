import {initializeApp} from "firebase-admin/app";
import {searchForQuest} from "./features/quests/search-for-quest";
import {actorQueueSentinel} from "./features/quests/actor-quest-queue-manager";
import {removeActiveQuest} from "./features/quests/remove-active-quest";
import {onUserCreateSentinel, onUserDeleteSentinel} from "./features/user/user_manager";
import {activeQuestsCleanerSchedule} from "./features/quests/quest-schedule";
import {removedQuestSchedule} from "./features/quests/removed-quest-schedule";

initializeApp();

exports.onUserDeleteSentinel = onUserDeleteSentinel;
exports.onUserCreateSentinel = onUserCreateSentinel;

exports.actorQueueSentinel = actorQueueSentinel;
exports.searchForQuest = searchForQuest;
exports.removeActiveQuest = removeActiveQuest;

// Cron jobs [Start]
exports.questQueueCleanerSchedule = activeQuestsCleanerSchedule;
exports.removedQuestSchedule = removedQuestSchedule;
// Cron jobs [End]