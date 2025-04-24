import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:recipe_finder/common/utils/logger.dart';
import 'package:recipe_finder/data/models/recipe.dart';
import 'package:recipe_finder/data/repository/recipe_repository.dart';
import 'package:recipe_finder/data/exceptions/recipe_exceptions.dart';
import 'package:recipe_finder/features/home/bloc/recipe_list_bloc.dart';

import 'recipe_list_test.mocks.dart';

@GenerateMocks([RecipeRepository])
void main() {
  late MockRecipeRepository mockRepository;
  late RecipeListBloc bloc;

  final mockRecipes = [
    Recipe(id: '1', name: 'Pizza', preparationTime: Duration(minutes: 20)),
    Recipe(id: '2', name: 'Pasta', preparationTime: Duration(minutes: 15)),
  ];

  final mockFavorites = [
    Recipe(
      id: '3',
      name: 'Fish',
      preparationTime: Duration(minutes: 50),
      isFavorite: true,
    ),
    Recipe(
      id: '4',
      name: 'Cheese',
      preparationTime: Duration(minutes: 30),
      isFavorite: true,
    ),
  ];

  setUp(() {
    Logger.init(logLevel: LogLevel.error);
    mockRepository = MockRecipeRepository();
    bloc = RecipeListBloc(mockRepository);
  });

  tearDown(() => bloc.close());

  test('test successful SearchRecipes', () async {
    when(
      mockRepository.searchRecipes(
        any,
        excludedRecipes: anyNamed('excludedRecipes'),
      ),
    ).thenAnswer((_) async => mockRecipes);

    bloc.add(SearchRecipes('Pizza'));

    await expectLater(
      bloc.stream,
      emitsInOrder([
        isA<RecipeListLoading>(),
        predicate<RecipeSearchLoaded>(
          (state) =>
              state.recipes.length == 2 && state.recipes.first.name == 'Pizza',
        ),
      ]),
    );
  });

  test('test SearchRecipes with throws RecipeExceptions', () async {
    when(
      mockRepository.searchRecipes(
        any,
        excludedRecipes: anyNamed('excludedRecipes'),
      ),
    ).thenThrow(
      RecipeExceptions(type: RecipeExceptionsType.emptyResult, message: ''),
    );

    bloc.add(SearchRecipes('test'));

    await expectLater(
      bloc.stream,
      emitsInOrder([
        isA<RecipeListLoading>(),
        isA<RecipeListError>().having(
          (e) => e.type,
          'type',
          RecipeExceptionsType.emptyResult,
        ),
      ]),
    );
  });

  test('test successful FetchFavorites', () async {
    when(mockRepository.getFavorites()).thenAnswer((_) async => mockFavorites);

    bloc.add(FetchFavorites());

    await expectLater(
      bloc.stream,
      emitsInOrder([
        isA<RecipeListLoading>(),
        predicate<RecipeFavoritesLoaded>(
          (state) =>
              state.recipes.length == 2 && state.recipes.first.name == 'Fish',
        ),
      ]),
    );
  });

  test('test FetchFavorites with throws RecipeExceptions', () async {
    when(mockRepository.getFavorites()).thenThrow(
      RecipeExceptions(type: RecipeExceptionsType.emptyResult, message: ''),
    );

    bloc.add(FetchFavorites());

    await expectLater(
      bloc.stream,
      emitsInOrder([
        isA<RecipeListLoading>(),
        isA<RecipeListError>().having(
          (e) => e.type,
          'type',
          RecipeExceptionsType.emptyResult,
        ),
      ]),
    );
  });

  test('test Favorites with empty list', () async {
    when(mockRepository.getFavorites()).thenAnswer((_) async => []);

    bloc.add(FetchFavorites());

    await expectLater(
      bloc.stream,
      emitsInOrder([
        isA<RecipeListLoading>(),
        predicate<RecipeFavoritesLoaded>((state) => state.recipes.isEmpty),
      ]),
    );
  });

  test('test add favorite', () async {
    when(
      mockRepository.searchRecipes(
        any,
        excludedRecipes: anyNamed('excludedRecipes'),
      ),
    ).thenAnswer((_) async => mockRecipes);

    when(
      mockRepository.addFavorite(any),
    ).thenAnswer((_) async => Future.value());

    bloc.add(SearchRecipes('test'));

    await expectLater(
      bloc.stream,
      emitsInOrder([
        isA<RecipeListLoading>(),
        predicate<RecipeSearchLoaded>(
          (state) =>
              state.recipes.length == 2 &&
              state.recipes[1].name == 'Pasta' &&
              !state.recipes.first.isFavorite,
        ),
      ]),
    );

    bloc.add(AddFavorite(mockRecipes.first));

    await expectLater(
      bloc.stream,
      emitsInOrder([
        predicate<RecipeSearchLoaded>(
          (state) =>
              state.recipes.length == 2 &&
              state.recipes[1].name == 'Pasta' &&
              state.recipes.first.isFavorite,
        ),
      ]),
    );
  });

  test('test remove favorite', () async {
    when(mockRepository.getFavorites()).thenAnswer((_) async => mockFavorites);
    when(
      mockRepository.removeFavorite(any),
    ).thenAnswer((_) async => Future.value());

    bloc.add(FetchFavorites());

    await expectLater(
      bloc.stream,
      emitsInOrder([
        isA<RecipeListLoading>(),
        predicate<RecipeFavoritesLoaded>(
          (state) =>
              state.recipes.length == 2 &&
              state.recipes[1].name == 'Cheese' &&
              state.recipes.first.isFavorite,
        ),
      ]),
    );

    bloc.add(RemoveFavorite(mockFavorites.first));

    await expectLater(
      bloc.stream,
      emitsInOrder([
        predicate<RecipeFavoritesLoaded>(
          (state) =>
              state.recipes.length == 2 &&
              state.recipes[1].name == 'Cheese' &&
              !state.recipes.first.isFavorite,
        ),
      ]),
    );
  });
}
