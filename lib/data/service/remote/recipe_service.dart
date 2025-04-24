import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:recipe_finder/common/utils/api_helper.dart';
import 'package:recipe_finder/common/utils/gemini_context_prompt.dart';
import 'package:recipe_finder/common/utils/logger.dart';
import 'package:recipe_finder/data/exceptions/recipe_exceptions.dart';
import 'package:recipe_finder/data/models/recipe.dart';
import 'package:recipe_finder/data/service/remote/api_service.dart';

class RecipeService extends ApiService {
  static const baseUrl = "https://generativelanguage.googleapis.com/";
  static const version = "v1beta";
  static const model = "models/gemini-2.0-flash";

  final String apiKey;

  RecipeService(super.dio, {required this.apiKey});

  Future<List<Recipe>> queryRecipes(
    String query,
    List<String> excludedRecipes,
  ) async {
    try {
      final response = await dio.post(
        "$baseUrl$version/$model:generateContent",
        data: _createRequestBody(geminiPrompt(query, exclude: excludedRecipes)),
        queryParameters: {'key': apiKey},
      );

      final extractedJson = _decodeAndExtractRecipesJson(response);

      final recipesList = jsonDecode(extractedJson)['recipes'];

      List<Recipe> result = Recipe.listFromJson(recipesList);

      if (result.isEmpty) {
        throw RecipeExceptions(
          type: RecipeExceptionsType.emptyResult,
          message: "No recipes found",
        );
      }
      return result;
    } on DioException catch (e) {
      Logger.e(
        tag: runtimeType.toString(),
        message: "queryRecipes received DioException:",
        error: e,
      );
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw RecipeExceptions(
          type: RecipeExceptionsType.timeOut,
          message: e.message ?? "",
        );
      }
      if (e.error is SocketException) {
        throw RecipeExceptions(
          type: RecipeExceptionsType.timeOut,
          message: e.message ?? "",
        );
      }
      if (e.response == null) {
        throw RecipeExceptions(
          type: RecipeExceptionsType.unknown,
          message: e.message ?? "",
        );
      }
      var statusCode = e.response!.statusCode;
      switch (statusCode) {
        case 400:
        case 404:
          throw RecipeExceptions(
            type: RecipeExceptionsType.invalidRequest,
            message: e.message ?? "",
          );
        case 401:
        case 403:
          throw RecipeExceptions(
            type: RecipeExceptionsType.unauthorizedRequest,
            message: e.message ?? "",
          );
        default:
          throw RecipeExceptions(
            type: RecipeExceptionsType.unknown,
            message: e.message ?? "",
          );
      }
    } catch (e) {
      if (e is! RecipeExceptions) {
        Logger.e(
          tag: runtimeType.toString(),
          message: "queryRecipes received unhandled Exception type:",
          error: e,
        );
      }
      rethrow;
    }
  }

  String _createRequestBody(String prompt) => jsonEncode({
    'contents': [
      {
        'parts': [
          {'text': prompt},
        ],
      },
    ],
  });

  String _decodeAndExtractRecipesJson(Response response) {
    try {
      final rawText =
          response.data?['candidates']?[0]?['content']?['parts']?[0]?['text'];

      if (rawText == null) throw Exception("Missing text in response");

      final jsonChunk = ApiHelper.extractJson(rawText);
      if (jsonChunk.isEmpty) throw Exception("No valid JSON found");

      return jsonChunk;
    } catch (e) {
      Logger.e(
        tag: runtimeType.toString(),
        message: "Failed to parse Gemini response",
        error: e,
      );
      throw RecipeExceptions(
        message: "Failed to parse Gemini response: $e",
        type: RecipeExceptionsType.emptyResult,
      );
    }
  }
}
