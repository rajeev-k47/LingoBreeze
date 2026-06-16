import '../../domain/entities/word.dart';
import '../../domain/repositories/words_repository.dart';
import '../datasources/words_remote_datasource.dart';

class WordsRepositoryImpl implements WordsRepository {
  final WordsRemoteDataSource _remoteDataSource;

  WordsRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<Word>> getWords() async {
    return await _remoteDataSource.getWords();
  }
}
