import '../../domain/entities/vocabulary_entry.dart';
import '../../domain/repositories/vocabulary_repository.dart';
import '../datasources/vocabulary_remote_datasource.dart';

class VocabularyRepositoryImpl implements VocabularyRepository {
  final VocabularyRemoteDataSource _remoteDataSource;

  VocabularyRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<VocabularyEntry>> getVocabulary() async {
    return await _remoteDataSource.getVocabulary();
  }

  @override
  Future<VocabularyEntry> saveWord(String word, String meaning, String translation) async {
    return await _remoteDataSource.saveWord(word, meaning, translation);
  }

  @override
  Future<void> deleteWord(String id) async {
    await _remoteDataSource.deleteWord(id);
  }
}
