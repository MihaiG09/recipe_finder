part of 'recipe_list_bloc.dart';

sealed class RecipeListState extends Equatable {
  const RecipeListState();

  @override
  List<Object> get props => [];
}

final class RecipeListInitial extends RecipeListState {}

final class RecipeListLoading extends RecipeListState {}

abstract class RecipeListLoaded extends RecipeListState {
  final List<Recipe> recipes;

  const RecipeListLoaded(this.recipes);

  @override
  List<Object> get props => [recipes];

  RecipeListLoaded copyWith(List<Recipe> recipes);
}

final class RecipeSearchLoaded extends RecipeListLoaded {
  const RecipeSearchLoaded(super.recipes);

  @override
  RecipeListLoaded copyWith(List<Recipe> recipes) =>
      RecipeSearchLoaded(recipes);
}

final class RecipeFavoritesLoaded extends RecipeListLoaded {
  const RecipeFavoritesLoaded(super.recipes);

  @override
  RecipeListLoaded copyWith(List<Recipe> recipes) =>
      RecipeFavoritesLoaded(recipes);
}

final class RecipeListError extends RecipeListState {
  final RecipeListErrorType type;

  const RecipeListError(this.type);

  @override
  List<Object> get props => [type];
}

enum RecipeListErrorType {
  unknown,
  timeout,
  empty,
  unauthorized;

  static fromRecipeExceptionType(RecipeExceptionsType type) {
    switch (type) {
      case RecipeExceptionsType.unauthorizedRequest:
        return unauthorized;
      case RecipeExceptionsType.emptyResult:
        return empty;
      case RecipeExceptionsType.timeOut:
        return timeout;
      case RecipeExceptionsType.invalidRequest:
      case RecipeExceptionsType.unknown:
        return unknown;
    }
  }

  String getTitle(AppLocalizations loc) {
    switch (this) {
      case RecipeListErrorType.timeout:
        return loc.recipeListTimeOutError;
      case RecipeListErrorType.empty:
        return loc.recipeListEmptyResultError;
      case RecipeListErrorType.unauthorized:
        return loc.recipeListUnauthorizedRequest;
      case RecipeListErrorType.unknown:
        return loc.recipeListUnknownError;
    }
  }

  String getButtonTitle(AppLocalizations loc) {
    return loc.recipeBackToFavorites;
  }
}
