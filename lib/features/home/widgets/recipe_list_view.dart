import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/common/theme/app_colors.dart';
import 'package:recipe_finder/features/home/bloc/recipe_list_bloc.dart';
import 'package:recipe_finder/features/home/widgets/recipe_list_tile.dart';
import 'package:recipe_finder/features/home/widgets/recipe_tile_container.dart';
import 'package:shimmer/shimmer.dart';

class RecipeListView extends StatelessWidget {
  const RecipeListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeListBloc, RecipeListState>(
      builder: (context, state) {
        if (state is RecipeListError) {
          // TODO: implement Error UI
          return Text("This is an error");
        }
        if (state is RecipeListLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 16, left: 16, right: 16),
                child: _buildListTitle(context, state),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: state.recipes.length,
                  itemBuilder:
                      (context, index) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: RecipeListTile(recipe: state.recipes[index]),
                      ),
                ),
              ),
            ],
          );
        }

        return _LoadingShimmer();
      },
    );
  }

  Widget _buildListTitle(BuildContext context, RecipeListLoaded state) {
    return Text(
      state is RecipeSearchLoaded ? "Suggested Recipes" : "Favorites",
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}

class _LoadingShimmer extends StatelessWidget {
  static final Color _baseColor = AppColors.white;
  static final Color _highlightColor = AppColors.gray.withValues(alpha: 0.5);

  const _LoadingShimmer();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: _buildTitleShimmer(context),
          ),
          for (int i = 0; i < 4; i++)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: _buildListTileShimmer(context),
            ),
        ],
      ),
    );
  }

  Widget _buildTitleShimmer(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      child: Shimmer.fromColors(
        baseColor: _baseColor,
        highlightColor: _highlightColor,
        child: Material(child: SizedBox(width: 274, height: 38)),
      ),
    );
  }

  Widget _buildListTileShimmer(BuildContext context) => RecipeTileContainer(
    width: double.infinity,
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      child: Shimmer.fromColors(
        baseColor: _baseColor,
        highlightColor: _highlightColor,
        child: Material(),
      ),
    ),
  );
}
