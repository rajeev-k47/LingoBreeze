import '../../core/network/api_client.dart';
import '../../core/constants/api_constants.dart';
import '../models/word_model.dart';

class WordsRemoteDataSource {
  final ApiClient _client;

  WordsRemoteDataSource(this._client);

  Future<List<WordModel>> getWords() async {
    final response = await _client.get(ApiConstants.words);
    final list = (response['words'] as List).cast<Map<String, dynamic>>();
    return list.map(WordModel.fromJson).toList();
  }
}
