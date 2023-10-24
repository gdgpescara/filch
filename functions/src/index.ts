import {sortingCeremony} from "./features/sorting-ceremony/sorting-ceremony";
import {initializeApp} from "firebase-admin/app";
import {searchForQuest} from "./features/quests/search-for-quest";
import {updateHouseMembers} from "./features/sorting-ceremony/house-manager";
import {actorQueueSentinel} from "./features/quests/actor-quest-queue-manager";
// import {
//   expiredActiveQuestCleaner,
//   questQueueCleaner,
// } from "./features/quests/quest-cron";

initializeApp();

exports.sortingCeremony = sortingCeremony;
exports.updateHouseMembers = updateHouseMembers;

exports.searchForQuest = searchForQuest;
exports.actorQueueSentinel = actorQueueSentinel;
// exports.expiredActiveQuestCleaner = expiredActiveQuestCleaner;
// exports.questQueueCleaner = questQueueCleaner;
