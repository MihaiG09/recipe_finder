import 'dart:async';

import 'package:recipe_finder/data/models/recipe.dart';

import 'favorites_data_source.dart';

class FavoritesDataSourceInMemory implements FavoritesDataSource {
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
  Future<void> addFavorite(Recipe recipe) async {
    _favorites.add(recipe.copyWith(isFavorite: true));
  }

  @override
  Future<void> removeFavorite(Recipe recipe) async {
    _favorites.removeWhere((elem) => elem.id == recipe.id);
  }

  @override
  Future<List<Recipe>> getRecipes() async {
    return List.of(_favorites);
  }
}
