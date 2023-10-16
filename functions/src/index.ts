import {
  sortingCeremony, updateHouseMembers,
} from "./features/sorting-ceremony/sorting-ceremony";
import {initializeApp} from "firebase-admin/app";

initializeApp();

exports.sortingCeremony = sortingCeremony;
exports.updateHouseMembers = updateHouseMembers;
