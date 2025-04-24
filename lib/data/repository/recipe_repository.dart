import 'dart:async';

import 'package:recipe_finder/data/models/recipe.dart';

abstract class RecipeRepository {
  Future<List<Recipe>> getFavorites();

  Future<List<Recipe>> searchRecipes(
    String query, {
    List<Recipe>? excludedRecipes,
  });

  Future<void> addFavorite(Recipe recipe);

  Future<void> removeFavorite(Recipe recipe);
}
