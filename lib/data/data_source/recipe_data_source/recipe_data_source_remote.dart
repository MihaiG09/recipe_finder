import 'dart:async';

import 'package:recipe_finder/data/data_source/recipe_data_source/recipe_data_source.dart';
import 'package:recipe_finder/data/models/recipe.dart';
import 'package:recipe_finder/data/service/remote/recipe_service_package.dart';

class RecipeDataSourceRemote implements RecipeDataSource {
  final RecipeServicePackage recipeService;
  RecipeDataSourceRemote(this.recipeService);

  @override
  Future<List<Recipe>> searchRecipes(
    String query, {
    List<String>? excludedRecipes,
  }) {
    return recipeService.searchRecipes(
      query,
      excludedRecipes: excludedRecipes ?? [],
    );
  }
}
