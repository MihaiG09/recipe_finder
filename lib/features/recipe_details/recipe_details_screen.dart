import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_finder/common/widgets/favorite_button.dart';
import 'package:recipe_finder/common/widgets/recipe_title.dart';
import 'package:recipe_finder/data/models/recipe.dart';
import 'package:recipe_finder/features/home/bloc/recipe_list_bloc.dart';

class RecipeDetailsScreen extends StatelessWidget {
  final String recipeId;

  const RecipeDetailsScreen({super.key, required this.recipeId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeListBloc, RecipeListState>(
      builder: (context, state) {
        if (state is RecipeListLoaded) {
          Recipe recipe = state.recipes.firstWhere(
            (recipe) => recipe.id == recipeId,
          );
          return Scaffold(
            body: Stack(
              children: [
                SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: SafeArea(
                    top: false,
                    minimum: EdgeInsets.only(bottom: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(recipe.imagePath),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              _buildTitle(context, recipe),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: _buildIngredientsList(context, recipe),
                              ),
                              _buildInstructionsList(context, recipe),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _buildBackButton(context),
              ],
            ),
          );
        }
        // This should never happen
        return Container();
      },
    );
  }

  Widget _buildIngredientsList(BuildContext context, Recipe recipe) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Ingredients:", style: Theme.of(context).textTheme.labelSmall),
          ...recipe.ingredients.map(
            (ingredient) => Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                "\u2022 ${ingredient}",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionsList(BuildContext context, Recipe recipe) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Instructions:", style: Theme.of(context).textTheme.labelSmall),
          ...recipe.instructions.asMap().entries.map(
            (entry) => Padding(
              padding: EdgeInsets.only(left: 8),
              child: _buildInstructionEntry(
                context,
                index: entry.key,
                instruction: entry.value,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context, Recipe recipe) {
    return Row(
      children: [
        Expanded(
          child: RecipeTitle(
            recipe: recipe,
            titleStyle: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        FavoriteButton(recipe: recipe),
      ],
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return SafeArea(
      child: IconButton(
        onPressed: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
        icon: SvgPicture.asset("assets/back_icon.svg"),
      ),
    );
  }

  Widget _buildInstructionEntry(
    BuildContext context, {
    required int index,
    required String instruction,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$index. ", style: Theme.of(context).textTheme.bodySmall),
        Expanded(
          child: Text(
            instruction,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}
