import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'core/network/api_client.dart';
import 'core/theme/app_theme.dart';
import 'data/datasources/vocabulary_remote_datasource.dart';
import 'data/datasources/words_remote_datasource.dart';
import 'data/repositories/vocabulary_repository_impl.dart';
import 'data/repositories/words_repository_impl.dart';
import 'presentation/providers/vocabulary_provider.dart';
import 'presentation/screens/my_vocabulary_screen.dart';

void main() {
  runApp(const LingoBreezeApp());
}

class LingoBreezeApp extends StatelessWidget {
  const LingoBreezeApp({super.key});

  @override
  Widget build(BuildContext context) {
    final httpClient = http.Client();
    final apiClient = ApiClient(httpClient);

    final wordsRemoteDataSource = WordsRemoteDataSource(apiClient);
    final vocabularyRemoteDataSource = VocabularyRemoteDataSource(apiClient);

    final wordsRepository = WordsRepositoryImpl(wordsRemoteDataSource);
    final vocabularyRepository = VocabularyRepositoryImpl(vocabularyRemoteDataSource);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => VocabularyProvider(vocabularyRepository, wordsRepository),
        ),
      ],
      child: MaterialApp(
        title: 'LingoBreeze',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: const MyVocabularyScreen(),
      ),
    );
  }
}
