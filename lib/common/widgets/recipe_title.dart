import 'package:flutter/material.dart';
import 'package:recipe_finder/data/models/recipe.dart';

class RecipeTitle extends StatelessWidget {
  final Recipe recipe;
  final TextStyle? titleStyle;

  const RecipeTitle({super.key, required this.recipe, this.titleStyle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            recipe.name,
            style: titleStyle ?? Theme.of(context).textTheme.labelLarge,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          "${recipe.preparationTime.inMinutes} Min.",
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
