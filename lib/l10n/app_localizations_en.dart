// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get searchFieldHint => 'What do you feel like eating?';

  @override
  String get recipeListFavoritesTitle => 'Favorites';

  @override
  String get recipeListSearchTitle => 'Suggested Recipes';

  @override
  String get recipeListRetryButtonTitle => 'I don\'t like these';

  @override
  String get recipeListEmptyResult => 'There is nothing here. Use the search bar to find some tasty recipes!';

  @override
  String get recipeListUnauthorizedRequest => 'Unauthorized request, make sure that the app uses a valid API KEY';

  @override
  String get recipeListEmptyResultError => 'Cannot produce any result for your request, please try another query';

  @override
  String get recipeListUnknownError => 'Unknown error, please try again later';

  @override
  String get recipeListTimeOutError => 'Request timed out, please check your internet connection and try again';

  @override
  String get recipeBackToFavorites => 'Back to favorites';

  @override
  String get recipeDetailsInstructionsLabel => 'Instructions';

  @override
  String get recipeDetailsIngredientsLabel => 'Ingredients';
}
