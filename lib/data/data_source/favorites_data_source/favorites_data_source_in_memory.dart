import 'dart:async';

import 'package:recipe_finder/data/models/recipe.dart';

import 'favorites_data_source.dart';

class FavoritesDataSourceInMemory implements FavoritesDataSource {
  // TODO: implement db storage
  final List<Recipe> _favorites = List.of([
    Recipe(
      id: "1",
      name: "Recipe Name #1",
      preparationTime: Duration(minutes: 50),
      isFavorite: true,
    ),
    Recipe(
      id: "2",
      name:
          "Recipe Name #2Recipe Name #2Recipe Name #2Recipe Name #2Recipe Name #2",
      preparationTime: Duration(minutes: 20),
      isFavorite: true,
      imagePath: "assets/food0.jpg",
    ),
  ]);

  @override
  FutureOr<void> addFavorite(Recipe recipe) {
    _favorites.add(recipe.copyWith(isFavorite: true));
  }

  @override
  FutureOr<void> removeFavorite(Recipe recipe) {
    _favorites.removeWhere((elem) => elem.id == recipe.id);
  }

  @override
  FutureOr<List<Recipe>> getRecipes() {
    return List.of(_favorites);
  }
}
