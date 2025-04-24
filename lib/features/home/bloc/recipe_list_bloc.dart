import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe_finder/common/utils/logger.dart';
import 'package:recipe_finder/data/exceptions/recipe_exceptions.dart';
import 'package:recipe_finder/data/models/recipe.dart';
import 'package:recipe_finder/data/repository/recipe_repository.dart';

part 'recipe_list_event.dart';
part 'recipe_list_state.dart';

class RecipeListBloc extends Bloc<RecipeEvent, RecipeListState> {
  final RecipeRepository recipeRepository;

  String? _lastQuery;

  final List<Recipe> _excludedRecipes = [];

  RecipeListBloc(this.recipeRepository) : super(RecipeListInitial()) {
    on<SearchRecipes>(_onSearchRecipes);
    on<FetchFavorites>(_onFetchFavorites);
    on<AddFavorite>(_onAddFavorite);
    on<RemoveFavorite>(_onRemoveFavorite);
    on<RetryLastQuery>(_onRetryLastQuery);
  }

  FutureOr<void> _onSearchRecipes(
    SearchRecipes event,
    Emitter<RecipeListState> emit,
  ) async {
    if (event.query.isEmpty) {
      Logger.d(tag: runtimeType.toString(), message: "Query is empty");
      add(FetchFavorites());
      return;
    }

    emit(RecipeListLoading());

    try {
      List<Recipe> recipes = await recipeRepository.searchRecipes(
        event.query,
        excludedRecipes: _excludedRecipes,
      );

      _lastQuery = event.query;

      emit(RecipeSearchLoaded(recipes));
    } on RecipeExceptions catch (e) {
      Logger.d(
        tag: runtimeType.toString(),
        message: "_onSearchRecipes error while fetching favorites",
        error: e,
      );

      emit(RecipeListError(e.type));
    } catch (e) {
      Logger.d(
        tag: runtimeType.toString(),
        message: "_onSearchRecipes error while fetching favorites",
        error: e,
      );

      emit(RecipeListError(RecipeExceptionsType.unknown));
    }
  }

  FutureOr<void> _onFetchFavorites(
    FetchFavorites event,
    Emitter<RecipeListState> emit,
  ) async {
    emit(RecipeListLoading());

    try {
      List<Recipe> recipes = await recipeRepository.getFavorites();

      emit(RecipeFavoritesLoaded(recipes));
    } on RecipeExceptions catch (e) {
      Logger.d(
        tag: runtimeType.toString(),
        message: "_onFetchFavorites error while fetching favorites",
        error: e,
      );

      emit(RecipeListError(e.type));
    } catch (e) {
      Logger.d(
        tag: runtimeType.toString(),
        message: "_onFetchFavorites error while fetching favorites",
        error: e,
      );

      emit(RecipeListError(RecipeExceptionsType.unknown));
    }
  }

  FutureOr<void> _onAddFavorite(
    AddFavorite event,
    Emitter<RecipeListState> emit,
  ) async {
    try {
      await recipeRepository.addFavorite(event.recipe);

      var state = this.state;

      if (state is RecipeListLoaded) {
        emit(
          state.copyWith(
            state.recipes
                .map(
                  (elem) =>
                      elem.id == event.recipe.id
                          ? elem.copyWith(isFavorite: true)
                          : elem,
                )
                .toList(),
          ),
        );
      }
    } on RecipeExceptions catch (e) {
      Logger.d(
        tag: runtimeType.toString(),
        message: "_onAddFavorite error while fetching favorites",
        error: e,
      );

      emit(RecipeListError(e.type));
    } catch (e) {
      Logger.d(
        tag: runtimeType.toString(),
        message: "_onAddFavorite error while fetching favorites",
        error: e,
      );

      emit(RecipeListError(RecipeExceptionsType.unknown));
    }
  }

  FutureOr<void> _onRemoveFavorite(
    RemoveFavorite event,
    Emitter<RecipeListState> emit,
  ) async {
    try {
      await recipeRepository.removeFavorite(event.recipe);

      var state = this.state;

      if (state is RecipeListLoaded) {
        emit(
          state.copyWith(
            state.recipes
                .map(
                  (elem) =>
                      elem.id == event.recipe.id
                          ? elem.copyWith(isFavorite: false)
                          : elem,
                )
                .toList(),
          ),
        );
      }
    } on RecipeExceptions catch (e) {
      Logger.d(
        tag: runtimeType.toString(),
        message: "_onRemoveFavorite error while fetching favorites",
        error: e,
      );

      emit(RecipeListError(e.type));
    } catch (e) {
      Logger.d(
        tag: runtimeType.toString(),
        message: "_onRemoveFavorite error while fetching favorites",
        error: e,
      );

      emit(RecipeListError(RecipeExceptionsType.unknown));
    }
  }

  FutureOr<void> _onRetryLastQuery(
    RetryLastQuery event,
    Emitter<RecipeListState> emit,
  ) {
    if (_lastQuery != null) {
      var state = this.state;
      if (state is RecipeSearchLoaded) {
        _excludedRecipes.addAll(state.recipes);
      }
      add(SearchRecipes(_lastQuery!));
    }
  }
}
