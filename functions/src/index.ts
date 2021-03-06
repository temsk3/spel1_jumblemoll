import * as firebaseAdmin from "firebase-admin";
import * as functions from "firebase-functions";

import * as stripe from "./stripe";
import * as user from "./user";

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info('Hello logs!', {structuredData: true});
//   response.send('Hello from Firebase!');
// });

firebaseAdmin.initializeApp(functions.config().firebase);

export { stripe, user };
