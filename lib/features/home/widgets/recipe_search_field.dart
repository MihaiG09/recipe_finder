import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_finder/common/theme/app_colors.dart';
import 'package:searchfield/searchfield.dart';

class RecipeSearchField extends StatelessWidget {
  const RecipeSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return SearchField(
      suggestions: [],
      controller: TextEditingController(),
      searchInputDecoration: SearchInputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(9999)),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(9999)),
          borderSide: BorderSide(color: AppColors.primary),
        ),
        hintText: "What do you feel like eating?",
        hintStyle: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(height: 1, color: AppColors.tertiary),
        contentPadding: EdgeInsets.only(left: 16, right: 16),
        suffixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SvgPicture.asset("assets/search.svg"),
        ),
      ),
    );
  }
}
