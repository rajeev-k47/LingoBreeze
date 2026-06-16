import 'package:flutter/foundation.dart';
import '../../domain/entities/vocabulary_entry.dart';
import '../../domain/entities/word.dart';
import '../../domain/repositories/vocabulary_repository.dart';
import '../../domain/repositories/words_repository.dart';

enum VocabularyState { initial, loading, loaded, error }

class VocabularyProvider extends ChangeNotifier {
  final VocabularyRepository _vocabularyRepository;
  final WordsRepository _wordsRepository;

  VocabularyProvider(this._vocabularyRepository, this._wordsRepository);

  VocabularyState _state = VocabularyState.initial;
  VocabularyState get state => _state;

  List<VocabularyEntry> _vocabulary = [];
  List<VocabularyEntry> get vocabulary => _vocabulary;

  List<Word> _availableWords = [];
  List<Word> get availableWords => _availableWords;

  bool _wordsLoading = false;
  bool get wordsLoading => _wordsLoading;

  bool _wordsLoaded = false;
  bool get wordsLoaded => _wordsLoaded;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> loadVocabulary() async {
    _state = VocabularyState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _vocabulary = await _vocabularyRepository.getVocabulary();
      _state = VocabularyState.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _state = VocabularyState.error;
    }
    notifyListeners();
  }

  Future<void> loadAvailableWords() async {
    if (_wordsLoading) return;
    _wordsLoading = true;
    _wordsLoaded = false;
    _errorMessage = null;
    _availableWords = [];
    notifyListeners();

    try {
      _availableWords = await _wordsRepository.getWords();
      _wordsLoaded = true;
    } catch (e) {
      _errorMessage = e.toString();
    }
    _wordsLoading = false;
    notifyListeners();
  }

  Future<bool> saveWord(String word, String meaning, String translation) async {
    try {
      await _vocabularyRepository.saveWord(word, meaning, translation);
      await loadVocabulary();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> saveWordFromAvailable(Word word) async {
    return saveWord(word.word, word.meaning, word.translation);
  }

  Future<void> deleteWord(String id) async {
    try {
      await _vocabularyRepository.deleteWord(id);
      await loadVocabulary();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
