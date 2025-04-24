import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_finder/common/theme/app_colors.dart';
import 'package:recipe_finder/common/utils/loc.dart';
import 'package:recipe_finder/features/home/bloc/recipe_list_bloc.dart';

class RecipeSearchField extends StatefulWidget {
  const RecipeSearchField({super.key});

  @override
  State<RecipeSearchField> createState() => _RecipeSearchFieldState();
}

class _RecipeSearchFieldState extends State<RecipeSearchField> {
  final TextEditingController _controller = TextEditingController();
  final MenuController _menuController = MenuController();
  final FocusNode _textFieldFocus = FocusNode();

  final List<String> _suggestions = [];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder:
          (context, constraints) => MenuAnchor(
            controller: _menuController,
            alignmentOffset: Offset(0, 8.0),
            style: _menuStyle,
            menuChildren: [
              SizedBox(
                width: constraints.maxWidth,
                height: _suggestions.length * 49,
                child: ListView.separated(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  primary: false,
                  itemCount: _suggestions.length,
                  separatorBuilder: (context, index) => _buildDivider(),
                  itemBuilder: (context, index) {
                    return _SuggestionTile(
                      value: _suggestions[index],
                      onTap: () {
                        _controller.text = _suggestions[index];
                        BlocProvider.of<RecipeListBloc>(
                          context,
                        ).add(SearchRecipes(_suggestions[index]));
                        _menuController.close();
                      },
                      onDelete: () {
                        setState(() {
                          _suggestions.removeAt(index);
                        });
                      },
                    );
                  },
                ),
              ),
            ],
            child: TextField(
              focusNode: _textFieldFocus,
              controller: _controller,
              decoration: _inputDecoration,
              onSubmitted: _onSubmitted,
              onTap: () {
                _menuController.open();
              },
              onTapOutside: (_) {
                _textFieldFocus.unfocus();
              },
            ),
          ),
    );
  }

  void _onSubmitted(String value) {
    BlocProvider.of<RecipeListBloc>(context).add(SearchRecipes(value));
    _menuController.close();
    if (!_suggestions.contains(value) && value.isNotEmpty) {
      setState(() {
        _suggestions.insert(0, value);
        if (_suggestions.length > 3) {
          _suggestions.removeLast();
        }
      });
    }
  }

  Widget _buildDivider() {
    return const Divider(
      color: AppColors.border,
      indent: 8,
      endIndent: 8,
      height: 1,
    );
  }

  InputDecoration get _inputDecoration => InputDecoration(
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
  );

  MenuStyle get _menuStyle => MenuStyle(
    elevation: WidgetStatePropertyAll(0),
    backgroundColor: WidgetStatePropertyAll(Colors.white),
    padding: WidgetStatePropertyAll(EdgeInsets.zero),
    side: WidgetStatePropertyAll(BorderSide(color: AppColors.primary)),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}

class _SuggestionTile extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final String value;

  const _SuggestionTile({
    required this.onTap,
    required this.value,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(value, style: Theme.of(context).textTheme.bodyMedium),
            ),
          ),
          IconButton(
            onPressed: onDelete,
            padding: EdgeInsets.zero, // Remove default padding
            icon: Icon(Icons.close, color: AppColors.tertiary),
          ),
        ],
      ),
    );
  }
}
