import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:recipe_finder/common/theme/theme_builder.dart';
import 'package:recipe_finder/data/data_source/recipe_data_source/recipe_data_source_remote.dart';
import 'package:recipe_finder/data/service/remote/recipe_service.dart';
import 'package:recipe_finder/features/home/bloc/recipe_list_bloc.dart';
import 'package:recipe_finder/features/home/home_screen.dart';

import 'data/data_source/favorites_data_source/favorites_data_source_in_memory.dart';
import 'data/repository/recipe_repository_impl.dart';

void main() {
  Gemini.init(apiKey: "");

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
              RecipeDataSourceRemote(RecipeService()),
              FavoritesDataSourceInMemory(),
            ),
          )..add(const FetchFavorites()),
      child: MaterialApp(
        theme: ThemeBuilder.getThemeData(),
        home: const HomeScreen(),
      ),
    );
  }
}
