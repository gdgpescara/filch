import * as fs from "fs";
import { getAuth } from "firebase-admin/auth";
import { getFirestore } from "firebase-admin/firestore";

export const createAccounts = async () => {
  try {
    const data = fs.readFileSync(`data/staff_users.json`);
    const userToCreate = JSON.parse(data);
    for (const user of userToCreate) {
      let fetchedUser;
      try {
        fetchedUser = await getAuth().getUserByEmail(user.email);
      } catch (error) {
        console.info("‼️ User not present");
      }
      if (!fetchedUser) {
        const createdUser = await getAuth().createUser({
          email: user.email,
          displayName: user.displayName,
          password: user.password,
          emailVerified: true,
        });
        console.info(
          `✅  Successfully created user ${createdUser.uid} with email ${createdUser.email}`
        );
      } else {
        await getFirestore().collection("users").doc(fetchedUser.uid).update({
          isStaff: true,
        });
        console.warn(
          `⏩  User ${fetchedUser.uid} - ${fetchedUser.email} already exists`
        );
      }
    }
  } catch (parseError) {
    console.error("‼️ Error parsing the JSON data:", parseError);
  }
};
