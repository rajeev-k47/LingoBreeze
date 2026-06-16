import '../../core/network/api_client.dart';
import '../../core/constants/api_constants.dart';
import '../models/vocabulary_entry_model.dart';

class VocabularyRemoteDataSource {
  final ApiClient _client;

  VocabularyRemoteDataSource(this._client);

  Future<List<VocabularyEntryModel>> getVocabulary() async {
    final response = await _client.get(ApiConstants.vocabulary);
    final list = (response['vocabulary'] as List).cast<Map<String, dynamic>>();
    return list.map(VocabularyEntryModel.fromJson).toList();
  }

  Future<VocabularyEntryModel> saveWord(
    String word,
    String meaning,
    String translation,
  ) async {
    final response = await _client.post(ApiConstants.vocabulary, {
      'word': word,
      'meaning': meaning,
      'translation': translation,
    });
    return VocabularyEntryModel.fromJson(response as Map<String, dynamic>);
  }

  Future<void> deleteWord(String id) async {
    await _client.delete('${ApiConstants.vocabulary}/$id');
  }
}
