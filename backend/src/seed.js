require('dotenv').config();
const { initializeFirebase, getDb, isFirebaseConfigured } = require('./config/firebase');

const seedWords = [
  { word: 'Apple', meaning: 'A fruit', translation: 'Manzana' },
  { word: 'Beautiful', meaning: 'Pleasing to look at', translation: 'Hermosa' },
  { word: 'Sun', meaning: 'The star around which Earth orbits', translation: 'Sol' },
  { word: 'Water', meaning: 'A clear liquid essential for life', translation: 'Agua' },
  { word: 'Book', meaning: 'A set of written pages bound together', translation: 'Libro' },
  { word: 'House', meaning: 'A building for human habitation', translation: 'Casa' },
  { word: 'Friend', meaning: 'A person with whom one has a bond', translation: 'Amigo' },
  { word: 'Music', meaning: 'Vocal or instrumental sounds', translation: 'Música' },
  { word: 'Happy', meaning: 'Feeling pleasure or contentment', translation: 'Feliz' },
  { word: 'Moon', meaning: "Earth's natural satellite", translation: 'Luna' },
];

async function seed() {
  initializeFirebase();

  if (!isFirebaseConfigured()) {
    console.log('Firebase not configured. Using in-memory store — no seed needed.');
    return;
  }

  const db = getDb();

  const existing = await db.collection('words').get();
  const deleteBatch = db.batch();
  existing.forEach(doc => deleteBatch.delete(doc.ref));
  await deleteBatch.commit();

  const batch = db.batch();
  for (const word of seedWords) {
    const ref = db.collection('words').doc();
    batch.set(ref, word);
  }
  await batch.commit();

  console.log(`Seeded ${seedWords.length} words to Firebase.`);
}

seed().catch(console.error);
