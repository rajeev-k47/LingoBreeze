class VocabularyEntry {
  final String id;
  final String word;
  final String meaning;
  final String translation;
  final String createdAt;

  const VocabularyEntry({
    required this.id,
    required this.word,
    required this.meaning,
    required this.translation,
    required this.createdAt,
  });
}
