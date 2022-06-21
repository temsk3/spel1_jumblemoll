import * as firebaseAdmin from 'firebase-admin';
import * as functions from 'firebase-functions';
import * as stripe from './stripe';

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
// Firebaseプロジェクトの初期化
firebaseAdmin.initializeApp(functions.config().firebase);

export {
    stripe,
};
