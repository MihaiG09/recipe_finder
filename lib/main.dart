import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:recipe_finder/common/theme/theme_builder.dart';
import 'package:recipe_finder/features/home/bloc/recipe_list_bloc.dart';
import 'package:recipe_finder/features/home/home_screen.dart';

import 'data/data_source/favorites_data_source/favorite_data_source_local_db.dart';
import 'data/data_source/recipe_data_source/recipe_data_source_api.dart';
import 'data/repository/recipe_repository_impl.dart';
import 'data/service/remote/recipe_service.dart';
import 'l10n/app_localizations.dart';

//TODO: write readme.md
void main() {
  Gemini.init(apiKey: const String.fromEnvironment("geminiApiKey"));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) => RecipeListBloc(
            RecipeRepositoryImpl(
              RecipeDataSourceApi(
                RecipeService(
                  Dio(),
                  apiKey: const String.fromEnvironment("geminiApiKey"),
                ),
              ),
              FavoriteDataSourceLocalDB(),
            ),
          )..add(const FetchFavorites()),
      child: MaterialApp(
        theme: ThemeBuilder.getThemeData(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const HomeScreen(),
      ),
    );
  }
}
