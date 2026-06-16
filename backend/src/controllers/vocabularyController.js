const { getDb, isFirebaseConfigured } = require('../config/firebase');
const { vocabulary } = require('../data/memoryStore');
const { v4: uuidv4 } = require('uuid');

async function getVocabulary(req, res, next) {
  try {
    if (isFirebaseConfigured()) {
      const db = getDb();
      const snapshot = await db.collection('vocabulary').get();
      const result = [];
      snapshot.forEach(doc => result.push({ id: doc.id, ...doc.data() }));
      return res.json({ vocabulary: result });
    }

    res.json({ vocabulary });
  } catch (err) {
    next(err);
  }
}

async function addWord(req, res, next) {
  try {
    const { word, meaning, translation } = req.body;

    if (!word || !meaning || !translation) {
      return res.status(400).json({ error: 'Word, meaning, and translation are required' });
    }

    if (isFirebaseConfigured()) {
      const db = getDb();
      const docRef = await db.collection('vocabulary').add({
        word,
        meaning,
        translation,
        createdAt: new Date().toISOString(),
      });
      const doc = await docRef.get();
      return res.status(201).json({ id: docRef.id, ...doc.data() });
    }

    const entry = {
      id: uuidv4(),
      word,
      meaning,
      translation,
      createdAt: new Date().toISOString(),
    };
    vocabulary.push(entry);
    res.status(201).json(entry);
  } catch (err) {
    next(err);
  }
}

async function deleteWord(req, res, next) {
  try {
    const { id } = req.params;

    if (isFirebaseConfigured()) {
      const db = getDb();
      await db.collection('vocabulary').doc(id).delete();
      return res.json({ message: 'Deleted successfully' });
    }

    const index = vocabulary.findIndex(e => e.id === id);
    if (index === -1) {
      return res.status(404).json({ error: 'Word not found' });
    }
    vocabulary.splice(index, 1);
    res.json({ message: 'Deleted successfully' });
  } catch (err) {
    next(err);
  }
}

module.exports = { getVocabulary, addWord, deleteWord };
