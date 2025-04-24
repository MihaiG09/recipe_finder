import 'dart:convert';

import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:recipe_finder/common/utils/logger.dart';
import 'package:recipe_finder/data/exceptions/recipe_exceptions.dart';
import 'package:recipe_finder/data/models/recipe.dart';

import 'gemini_context_prompt.dart';

class RecipeService {
  // TODO: use rest API instead
  Future<List<Recipe>> searchRecipes(String query) async {
    try {
      Candidates? candidates = await Gemini.instance.prompt(
        parts: [Part.text(geminiPrompt(query))],
      );

      String? output = candidates?.output;

      if (output != null) {
        var json = jsonDecode(stripToBraces(output));
        return Recipe.listFromJson(json["recipes"]);
      }

      Logger.w(
        // tag: runtimeType.toString(),
        message: "searchRecipes prompt output is null",
      );

      return [];
    } on GeminiException catch (e) {
      if (e.statusCode == 403) {
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
