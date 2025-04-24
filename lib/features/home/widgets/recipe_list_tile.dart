import 'package:flutter/material.dart';
import 'package:recipe_finder/common/widgets/favorite_button.dart';
import 'package:recipe_finder/common/widgets/recipe_title.dart';
import 'package:recipe_finder/data/models/recipe.dart';
import 'package:recipe_finder/features/home/widgets/recipe_tile_container.dart';
import 'package:recipe_finder/features/recipe_details/recipe_details_screen.dart';

class RecipeListTile extends StatelessWidget {
  final Recipe recipe;
  const RecipeListTile({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => RecipeDetailsScreen(recipeId: recipe.id),
            ),
          ),
      child: RecipeTileContainer(
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: Image.asset(recipe.imagePath),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: RecipeTitle(recipe: recipe),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 8, left: 8),
              child: FavoriteButton(recipe: recipe),
            ),
          ],
        ),
      ),
    );
  }
}
