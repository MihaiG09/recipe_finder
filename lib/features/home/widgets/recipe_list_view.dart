import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/common/theme/app_colors.dart';
import 'package:recipe_finder/common/utils/dimens.dart';
import 'package:recipe_finder/common/utils/loc.dart';
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
          return _ErrorUI(state.type);
        }
        if (state is RecipeListLoaded) {
          if (state.recipes.isEmpty) {
            return _EmptyResult();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.space400),
                child: _buildListTitle(context, state),
              ),
              Flexible(
                child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.all(Dimens.space400),
                  itemCount: state.recipes.length,
                  itemBuilder:
                      (context, index) => Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: Dimens.space200,
                        ),
                        child: RecipeListTile(recipe: state.recipes[index]),
                      ),
                ),
              ),
              if (state is RecipeSearchLoaded)
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimens.space200),
                    child: _buildRetryButton(context),
                  ),
                ),
            ],
          );
        }

        return _LoadingShimmer();
      },
    );
  }

  Widget _buildRetryButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        BlocProvider.of<RecipeListBloc>(context).add(RetryLastQuery());
      },
      child: Text(
        context.loc.recipeListRetryButtonTitle,
        style: Theme.of(
          context,
        ).textTheme.labelMedium?.copyWith(color: AppColors.white),
      ),
    );
  }

  Widget _buildListTitle(BuildContext context, RecipeListLoaded state) {
    return Text(
      state is RecipeSearchLoaded
          ? context.loc.recipeListSearchTitle
          : context.loc.recipeListFavoritesTitle,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}

class _EmptyResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimens.space400),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            child: Image.asset("assets/app_icon.jpeg", height: 150),
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: Dimens.space400),
            child: Text(
              context.loc.recipeListEmptyResult,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingShimmer extends StatelessWidget {
  static final Color _baseColor = AppColors.white;
  static final Color _highlightColor = AppColors.gray.withValues(alpha: 0.5);

  const _LoadingShimmer();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: Dimens.space400),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: Dimens.space200),
            child: _buildTitleShimmer(context),
          ),
          for (int i = 0; i < 4; i++)
            Padding(
              padding: EdgeInsets.symmetric(vertical: Dimens.space200),
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

class _ErrorUI extends StatelessWidget {
  final RecipeListErrorType errorType;
  const _ErrorUI(this.errorType);
  @override
  Widget build(BuildContext context) {
    return _buildUi(
      context,
      errorText: errorType.getTitle(context.loc),
      buttonText: errorType.getButtonTitle(context.loc),
      onButtonPress: () {
        BlocProvider.of<RecipeListBloc>(context).add(FetchFavorites());
      },
    );
  }

  Widget _buildUi(
    BuildContext context, {
    required String errorText,
    required String buttonText,
    required VoidCallback onButtonPress,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimens.space400),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: AppColors.primary, size: 88),
          Padding(
            padding: EdgeInsets.symmetric(vertical: Dimens.space400),
            child: Text(
              errorText,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
          ElevatedButton(
            onPressed: onButtonPress,
            child: Text(
              buttonText,
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
