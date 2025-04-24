import 'dart:convert';

import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:recipe_finder/common/utils/logger.dart';
import 'package:recipe_finder/data/exceptions/recipe_exceptions.dart';
import 'package:recipe_finder/data/models/recipe.dart';

import 'gemini_context_prompt.dart';

class RecipeService {
  // TODO: use rest API instead
  Future<List<Recipe>> searchRecipes(
    String query, {
    List<String> excludedRecipes = const [],
  }) async {
    try {
      // if too many recipes are excluded the AI may return empty results
      Logger.d(
        tag: runtimeType.toString(),
        message: "searchRecipes query $query excludedRecipes: $excludedRecipes",
      );

      Candidates? candidates = await Gemini.instance.prompt(
        parts: [Part.text(geminiPrompt(query, exclude: excludedRecipes))],
      );

      List<Recipe> result = [];

      Logger.d(
        tag: runtimeType.toString(),
        message: "searchRecipes response length ${candidates?.output?.length}",
      );

      if (candidates?.output != null) {
        var json = jsonDecode(stripToBraces(candidates!.output!));
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
      Logger.e(message: "searchRecipes received unhandled GeminiException: $e");
      rethrow;
    } catch (e) {
      Logger.e(message: "searchRecipes received unhandled Exception type: $e");
      rethrow;
    }
  }
}

String stripToBraces(String input) {
  int start = input.indexOf('{');
  int end = input.lastIndexOf('}');

  if (start != -1 && end != -1 && end > start) {
    return input.substring(start, end + 1);
  }

  return ''; // return empty string if braces are not properly found
}
