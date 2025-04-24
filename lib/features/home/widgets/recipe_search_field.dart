import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_finder/common/theme/app_colors.dart';
import 'package:recipe_finder/common/utils/loc.dart';
import 'package:recipe_finder/features/home/bloc/recipe_list_bloc.dart';
import 'package:searchfield/searchfield.dart';

class RecipeSearchField extends StatefulWidget {
  const RecipeSearchField({super.key});

  @override
  State<RecipeSearchField> createState() => _RecipeSearchFieldState();
}

class _RecipeSearchFieldState extends State<RecipeSearchField> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _suggestions = [];

  @override
  Widget build(BuildContext context) {
    return SearchField<String>(
      suggestions:
          _suggestions.reversed
              .map((value) => SearchFieldListItem<String>(value))
              .toList(),
      controller: _controller,
      suggestionStyle: Theme.of(context).textTheme.bodyMedium,
      suggestionsDecoration: SuggestionDecoration(
        elevation: 1,
        padding: EdgeInsets.symmetric(horizontal: 8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary, width: 1),
        selectionColor: Colors.transparent,
      ),
      offset: Offset(0, 48),
      onSuggestionTap: (suggestion) {
        BlocProvider.of<RecipeListBloc>(
          context,
        ).add(SearchRecipes(suggestion.searchKey));
      },
      onSubmit: (value) {
        BlocProvider.of<RecipeListBloc>(context).add(SearchRecipes(value));
        setState(() {
          if (!_suggestions.contains(value)) {
            _suggestions.add(value);
            if (_suggestions.length > 3) {
              _suggestions.removeAt(0);
            }
          }
        });
      },
      searchInputDecoration: SearchInputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(9999)),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(9999)),
          borderSide: BorderSide(color: AppColors.primary),
        ),
        hintText: context.loc.searchFieldHint,
        hintStyle: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(height: 1, color: AppColors.tertiary),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        constraints: BoxConstraints(maxHeight: 40),
        suffixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SvgPicture.asset("assets/search.svg"),
        ),
      ),
    );
  }
}
