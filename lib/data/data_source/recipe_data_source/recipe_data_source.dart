import 'dart:async';

import 'package:recipe_finder/data/models/recipe.dart';

abstract class RecipeDataSource {
  Future<List<Recipe>> searchRecipes(
    String query, {
    List<String>? excludedRecipes,
  });
}
