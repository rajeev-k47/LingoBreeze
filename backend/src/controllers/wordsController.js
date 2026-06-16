const { getDb, isFirebaseConfigured } = require('../config/firebase');
const { words } = require('../data/memoryStore');

async function getWords(req, res, next) {
  try {
    if (isFirebaseConfigured()) {
      const db = getDb();
      const snapshot = await db.collection('words').get();
      const result = [];
      snapshot.forEach(doc => result.push({ id: doc.id, ...doc.data() }));
      return res.json({ words: result });
    }

    res.json({ words });
  } catch (err) {
    next(err);
  }
}

module.exports = { getWords };
