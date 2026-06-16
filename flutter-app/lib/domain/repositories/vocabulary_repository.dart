import '../entities/vocabulary_entry.dart';

abstract class VocabularyRepository {
  Future<List<VocabularyEntry>> getVocabulary();
  Future<VocabularyEntry> saveWord(String word, String meaning, String translation);
  Future<void> deleteWord(String id);
}
