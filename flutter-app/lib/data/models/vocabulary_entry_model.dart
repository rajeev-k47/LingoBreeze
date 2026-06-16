import '../../domain/entities/vocabulary_entry.dart';

class VocabularyEntryModel extends VocabularyEntry {
  const VocabularyEntryModel({
    required super.id,
    required super.word,
    required super.meaning,
    required super.translation,
    required super.createdAt,
  });

  factory VocabularyEntryModel.fromJson(Map<String, dynamic> json) {
    return VocabularyEntryModel(
      id: json['id'] as String,
      word: json['word'] as String,
      meaning: json['meaning'] as String,
      translation: json['translation'] as String,
      createdAt: json['createdAt'] as String? ?? DateTime.now().toIso8601String(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'word': word,
      'meaning': meaning,
      'translation': translation,
    };
  }
}
