import 'package:flutter/material.dart';
import 'package:recipe_finder/data/models/recipe.dart';
import 'package:recipe_finder/features/home/widgets/recipe_list_tile.dart';
import 'package:recipe_finder/features/home/widgets/recipe_search_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.only(top: 32),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TODO: check top padding on android / devices without safe area
              RecipeSearchField(),
              Padding(
                padding: EdgeInsets.only(bottom: 16, top: 32),
                child: Text(
                  "Favorites",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              RecipeListTile(
                recipe: Recipe(
                  id: "1",
                  name: "Recipe Name #1",
                  preparationTime: Duration(minutes: 50),
                ),
              ),
              SizedBox(height: 16),
              RecipeListTile(
                recipe: Recipe(
                  id: "2",
                  name:
                      "Recipe Name #2Recipe Name #2Recipe Name #2Recipe Name #2Recipe Name #2",
                  preparationTime: Duration(minutes: 20),
                  isFavorite: true,
                  imagePath: "assets/food2.jpg",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
