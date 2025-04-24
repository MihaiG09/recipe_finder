import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_finder/data/models/recipe.dart';
import 'package:recipe_finder/features/home/bloc/recipe_list_bloc.dart';

class FavoriteButton extends StatelessWidget {
  final Recipe recipe;

  const FavoriteButton({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        BlocProvider.of<RecipeListBloc>(
          context,
        ).add(recipe.isFavorite ? RemoveFavorite(recipe) : AddFavorite(recipe));
      },
      icon:
          recipe.isFavorite
              ? SvgPicture.asset("assets/heart_filled.svg")
              : SvgPicture.asset("assets/heart_empty.svg"),
    );
  }
}
