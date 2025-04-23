import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_finder/common/theme/app_colors.dart';
import 'package:recipe_finder/data/models/recipe.dart';

class RecipeListTile extends StatelessWidget {
  final Recipe recipe;
  const RecipeListTile({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: _boxShadow,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      height: 88,
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
              child: _buildTitle(context),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8, left: 8),
            child: _buildFavoriteButton(context),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteButton(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon:
          recipe.isFavorite
              ? SvgPicture.asset("assets/heart_filled.svg")
              : SvgPicture.asset("assets/heart_empty.svg"),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            recipe.name,
            style: Theme.of(context).textTheme.labelLarge,
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

  List<BoxShadow> get _boxShadow => [
    BoxShadow(
      color: AppColors.gray.withOpacity(0.9),
      offset: Offset(4, 4),
      blurRadius: 10,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: AppColors.white.withOpacity(0.9),
      offset: Offset(-4, -4),
      blurRadius: 8,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: AppColors.gray.withOpacity(0.2),
      offset: Offset(4, -4),
      blurRadius: 8,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: AppColors.gray.withOpacity(0.2),
      offset: Offset(-4, 4),
      blurRadius: 8,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: AppColors.gray.withOpacity(0.5),
      offset: Offset(-1, -1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: AppColors.white.withOpacity(0.3),
      offset: Offset(1, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
  ];
}
