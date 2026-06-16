import '../../domain/entities/word.dart';

class WordModel extends Word {
  const WordModel({
    required super.id,
    required super.word,
    required super.meaning,
    required super.translation,
  });

  factory WordModel.fromJson(Map<String, dynamic> json) {
    return WordModel(
      id: json['id'] as String,
      word: json['word'] as String,
      meaning: json['meaning'] as String,
      translation: json['translation'] as String,
    );
  }
}
