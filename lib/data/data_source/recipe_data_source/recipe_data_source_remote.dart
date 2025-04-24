import 'dart:async';

import 'package:recipe_finder/data/data_source/recipe_data_source/recipe_data_source.dart';
import 'package:recipe_finder/data/models/recipe.dart';
import 'package:recipe_finder/data/service/remote/recipe_service.dart';

class RecipeDataSourceRemote implements RecipeDataSource {
  final RecipeService recipeService;
  RecipeDataSourceRemote(this.recipeService);

  @override
  FutureOr<List<Recipe>> searchRecipes(String query) {
    return recipeService.searchRecipes(query);
  }
}
