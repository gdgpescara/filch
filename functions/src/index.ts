import {sortingCeremony} from "./features/sorting-ceremony/sorting-ceremony";
import {initializeApp} from "firebase-admin/app";
import {searchForQuest} from "./features/quests/search-for-quest";
import {updateHouseMembers} from "./features/sorting-ceremony/house-manager";
import {actorQueueSentinel} from "./features/quests/actor-quest-queue-manager";
import {submitAnswer} from "./features/quests/submit-answer";
import {
  expiredActiveQuestCleaner,
  questQueueCleaner,
} from "./features/quests/quest-cron";
import {
  memberPointsSentinel,
  userPointsSentinel,
} from "./features/points/points-manager";
import {assignPoints} from "./features/points/assign-points";
import {
  onUserCreateSentinel,
  onUserDeleteSentinel,
} from "./features/user/user_manager";
import {scanHouseMate} from "./features/quests/social_qr_code_quest";
import {removeActiveQuest} from "./features/quests/remove-active-quest";

initializeApp();

exports.onUserDeleteSentinel = onUserDeleteSentinel;
exports.onUserCreateSentinel = onUserCreateSentinel;

exports.sortingCeremony = sortingCeremony;
exports.updateHouseMembers = updateHouseMembers;

exports.searchForQuest = searchForQuest;
exports.actorQueueSentinel = actorQueueSentinel;
exports.submitAnswer = submitAnswer;
exports.scanHouseMate = scanHouseMate;
exports.removeActiveQuest = removeActiveQuest;

// Cron jobs [Start]
exports.expiredActiveQuestCleaner = expiredActiveQuestCleaner;
exports.questQueueCleaner = questQueueCleaner;
// Cron jobs [End]

exports.assignPoints = assignPoints;
exports.userPointsSentinel = userPointsSentinel;
exports.memberPointsSentinel = memberPointsSentinel;
