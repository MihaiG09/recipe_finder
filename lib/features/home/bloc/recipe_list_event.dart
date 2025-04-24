part of 'recipe_list_bloc.dart';

sealed class RecipeEvent extends Equatable {
  const RecipeEvent();

  @override
  List<Object?> get props => [];
}

final class FetchFavorites extends RecipeEvent {
  const FetchFavorites();
}

final class SearchRecipes extends RecipeEvent {
  final String query;

  const SearchRecipes(this.query);

  @override
  List<Object?> get props => [query];
}

final class AddFavorite extends RecipeEvent {
  final Recipe recipe;

  const AddFavorite(this.recipe);

  @override
  List<Object?> get props => [recipe];
}

final class RemoveFavorite extends RecipeEvent {
  final Recipe recipe;

  const RemoveFavorite(this.recipe);

  @override
  List<Object?> get props => [recipe];
}
