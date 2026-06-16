const { v4: uuidv4 } = require('uuid');

const words = [
  { id: 'w1', word: 'Apple', meaning: 'A fruit', translation: 'Manzana' },
  { id: 'w2', word: 'Beautiful', meaning: 'Pleasing to look at', translation: 'Hermosa' },
  { id: 'w3', word: 'Sun', meaning: 'The star around which Earth orbits', translation: 'Sol' },
  { id: 'w4', word: 'Water', meaning: 'A clear liquid essential for life', translation: 'Agua' },
  { id: 'w5', word: 'Book', meaning: 'A set of written pages bound together', translation: 'Libro' },
  { id: 'w6', word: 'House', meaning: 'A building for human habitation', translation: 'Casa' },
  { id: 'w7', word: 'Friend', meaning: 'A person with whom one has a bond', translation: 'Amigo' },
  { id: 'w8', word: 'Music', meaning: 'Vocal or instrumental sounds', translation: 'Música' },
  { id: 'w9', word: 'Happy', meaning: 'Feeling pleasure or contentment', translation: 'Feliz' },
  { id: 'w10', word: 'Moon', meaning: 'Earth\'s natural satellite', translation: 'Luna' },
];

const vocabulary = [];

module.exports = { words, vocabulary };
