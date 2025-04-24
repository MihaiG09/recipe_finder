import 'dart:async';

import 'package:recipe_finder/data/models/recipe.dart';

abstract class RecipeRepository {
  FutureOr<List<Recipe>> getFavorites();

  FutureOr<List<Recipe>> searchRecipes(
    String query, {
    List<Recipe>? excludedRecipes,
  });

  FutureOr<void> addFavorite(Recipe recipe);

  FutureOr<void> removeFavorite(Recipe recipe);
}
