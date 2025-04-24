import 'package:recipe_finder/data/data_source/recipe_data_source/recipe_data_source.dart';
import 'package:recipe_finder/data/models/recipe.dart';
import 'package:recipe_finder/data/service/remote/recipe_service.dart';

class RecipeDataSourceApi extends RecipeDataSource {
  RecipeService recipeService;
  RecipeDataSourceApi(this.recipeService);

  @override
  Future<List<Recipe>> searchRecipes(
    String query, {
    List<String>? excludedRecipes,
  }) {
    return recipeService.queryRecipes(query, excludedRecipes ?? []);
  }
}
