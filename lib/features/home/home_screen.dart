import 'package:flutter/material.dart';
import 'package:recipe_finder/common/utils/dimens.dart';
import 'package:recipe_finder/features/home/widgets/recipe_list_view.dart';
import 'package:recipe_finder/features/home/widgets/recipe_search_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.only(top: Dimens.space600),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimens.space400),
              child: RecipeSearchField(),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: Dimens.space600),
                child: RecipeListView(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
