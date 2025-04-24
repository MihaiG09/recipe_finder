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
  final RecipeExceptionsType type;

  const RecipeListError(this.type);

  @override
  List<Object> get props => [type];
}
