import 'dart:async';

import 'package:recipe_finder/data/models/recipe.dart';

abstract class FavoritesDataSource {
  FutureOr<List<Recipe>> getRecipes();

  FutureOr<void> addFavorite(Recipe recipe);

  FutureOr<void> removeFavorite(Recipe recipe);
}
