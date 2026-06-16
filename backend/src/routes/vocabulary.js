const { Router } = require('express');
const { getVocabulary, addWord, deleteWord } = require('../controllers/vocabularyController');

const router = Router();

router.get('/', getVocabulary);
router.post('/', addWord);
router.delete('/:id', deleteWord);

module.exports = router;
