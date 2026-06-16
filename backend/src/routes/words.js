const { Router } = require('express');
const { getWords } = require('../controllers/wordsController');

const router = Router();

router.get('/', getWords);

module.exports = router;
