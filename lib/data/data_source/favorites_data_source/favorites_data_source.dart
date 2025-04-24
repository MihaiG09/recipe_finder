import 'dart:async';

import 'package:recipe_finder/data/models/recipe.dart';

abstract class FavoritesDataSource {
  Future<List<Recipe>> getRecipes();

  Future<void> addFavorite(Recipe recipe);

  Future<void> removeFavorite(Recipe recipe);
}
