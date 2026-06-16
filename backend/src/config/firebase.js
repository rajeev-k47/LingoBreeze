const admin = require('firebase-admin');
const path = require('path');
const fs = require('fs');

let db = null;

function initializeFirebase() {
  if (admin.apps.length) return admin.app();

  const credentialsPath = process.env.GOOGLE_APPLICATION_CREDENTIALS;
  const projectId = process.env.FIREBASE_PROJECT_ID;

  if (credentialsPath) {
    const resolved = path.resolve(credentialsPath);
    if (fs.existsSync(resolved)) {
      admin.initializeApp({
        credential: admin.credential.applicationDefault(),
      });
      console.log('Firebase initialized via GOOGLE_APPLICATION_CREDENTIALS.');
    } else {
      console.warn(`Credentials file not found at ${resolved}. Using in-memory store.`);
      return null;
    }
  } else if (projectId && projectId !== 'lingobreeze-demo') {
    const clientEmail = process.env.FIREBASE_CLIENT_EMAIL;
    const privateKey = process.env.FIREBASE_PRIVATE_KEY;

    if (!clientEmail || !privateKey) {
      console.warn('Firebase env vars incomplete. Using in-memory store.');
      return null;
    }

    admin.initializeApp({
      credential: admin.credential.cert({
        projectId,
        clientEmail,
        privateKey: privateKey.replace(/\\n/g, '\n'),
      }),
    });
    console.log('Firebase initialized via environment variables.');
  } else {
    console.warn('Firebase not configured. Using in-memory store.');
    return null;
  }

  db = admin.firestore();
  return admin.app();
}

function getDb() {
  return db;
}

function isFirebaseConfigured() {
  return db !== null;
}

module.exports = { initializeFirebase, getDb, isFirebaseConfigured };
