import 'dart:async';
import 'dart:convert';

import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:recipe_finder/common/utils/api_helper.dart';
import 'package:recipe_finder/common/utils/logger.dart';
import 'package:recipe_finder/data/data_source/recipe_data_source/recipe_data_source.dart';
import 'package:recipe_finder/data/exceptions/recipe_exceptions.dart';
import 'package:recipe_finder/data/models/recipe.dart';
import 'package:recipe_finder/common/utils/gemini_context_prompt.dart';

class RecipeDataSourcePackage implements RecipeDataSource {
  final Gemini _gemini;
  RecipeDataSourcePackage(this._gemini);

  @override
  Future<List<Recipe>> searchRecipes(
    String query, {
    List<String>? excludedRecipes,
  }) async {
    try {
      // if too many recipes are excluded the AI may return empty results
      Logger.d(
        tag: runtimeType.toString(),
        message: "searchRecipes query $query excludedRecipes: $excludedRecipes",
      );

      Candidates? candidates = await _gemini.prompt(
        parts: [Part.text(geminiPrompt(query, exclude: excludedRecipes ?? []))],
      );

      List<Recipe> result = [];

      Logger.d(
        tag: runtimeType.toString(),
        message: "searchRecipes response length ${candidates?.output?.length}",
      );

      if (candidates?.output != null) {
        var json = jsonDecode(ApiHelper.extractJson(candidates!.output!));
        result = Recipe.listFromJson(json["recipes"]);
      }

      if (result.isEmpty) {
        Logger.e(
          tag: runtimeType.toString(),
          message: "searchRecipes result is empty",
        );

        throw RecipeExceptions(
          message: "search result is empty",
          type: RecipeExceptionsType.emptyResult,
        );
      }

      return result;
    } on GeminiException catch (e) {
      if (e.message.toString().contains("403")) {
        throw RecipeExceptions(
          message: e.message.toString(),
          type: RecipeExceptionsType.unauthorizedRequest,
        );
      }
      if (e.message.toString().contains("400")) {
        throw RecipeExceptions(
          message: e.message.toString(),
          type: RecipeExceptionsType.unauthorizedRequest,
        );
      }
      Logger.e(
        tag: runtimeType.toString(),
        message: "searchRecipes received unhandled GeminiException:",
        error: e,
      );
      rethrow;
    } catch (e) {
      Logger.e(
        tag: runtimeType.toString(),
        message: "searchRecipes received unhandled Exception type:",
        error: e,
      );
      rethrow;
    }
  }
}
