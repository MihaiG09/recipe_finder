import 'dart:async';

import 'package:recipe_finder/data/data_source/favorites_data_source/favorites_data_source.dart';
import 'package:recipe_finder/data/data_source/recipe_data_source/recipe_data_source.dart';
import 'package:recipe_finder/data/models/recipe.dart';
import 'package:recipe_finder/data/repository/recipe_repository.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  RecipeDataSource recipeDataSource;
  FavoritesDataSource favoritesDataSource;

  RecipeRepositoryImpl(this.recipeDataSource, this.favoritesDataSource);

  @override
  Future<void> addFavorite(Recipe recipe) {
    return favoritesDataSource.addFavorite(recipe);
  }

  @override
  Future<List<Recipe>> getFavorites() {
    return favoritesDataSource.getRecipes();
  }

  @override
  Future<void> removeFavorite(Recipe recipe) {
    return favoritesDataSource.removeFavorite(recipe);
  }

  @override
  Future<List<Recipe>> searchRecipes(
    String query, {
    List<Recipe>? excludedRecipes,
  }) {
    return recipeDataSource.searchRecipes(
      query,
      excludedRecipes: excludedRecipes?.map((recipe) => recipe.name).toList(),
    );
  }
}
