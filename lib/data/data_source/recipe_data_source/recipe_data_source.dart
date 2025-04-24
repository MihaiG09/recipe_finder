import 'dart:async';

import 'package:recipe_finder/data/models/recipe.dart';

abstract class RecipeDataSource {
  FutureOr<List<Recipe>> searchRecipes(
    String query, {
    List<String>? excludedRecipes,
  });
}
