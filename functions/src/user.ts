import * as firebaseAdmin from "firebase-admin";
import * as functions from "firebase-functions";

const fucRegion = functions.region("asia-northeast1");
const db = firebaseAdmin.firestore();

// user
export const createUserAccount = fucRegion.auth.user().onCreate((user) => {
  const uid = user.uid;
  const email = user.email;
  const displayName = user.displayName;
  const photoUrl = user.photoURL;
  const newUserRef = db.doc(`/users/${uid}`);
  return newUserRef.set({
    photoUrl: photoUrl,
    email: email,
    displayName: displayName,
  });
});

export const cleanupUserData = fucRegion.auth.user().onDelete((event) => {
  const uid = event.uid;
  const userRef = db.doc(`/users/${uid}`);
  return userRef.update({ isActive: false });
});
