import '../entities/word.dart';

abstract class WordsRepository {
  Future<List<Word>> getWords();
}
