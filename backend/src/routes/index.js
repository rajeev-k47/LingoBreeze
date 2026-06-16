const { Router } = require('express');
const wordsRouter = require('./words');
const vocabularyRouter = require('./vocabulary');

const router = Router();

router.use('/words', wordsRouter);
router.use('/vocabulary', vocabularyRouter);

module.exports = router;
