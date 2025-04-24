import 'package:flutter/material.dart';
import 'package:recipe_finder/common/theme/app_colors.dart';

class RecipeTileContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  const RecipeTileContainer({
    super.key,
    required this.child,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: _boxShadow,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      height: height ?? 88,
      width: width,
      child: child,
    );
  }

  List<BoxShadow> get _boxShadow => [
    BoxShadow(
      color: AppColors.gray.withValues(alpha: 0.9),
      offset: Offset(4, 4),
      blurRadius: 10,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: AppColors.white.withValues(alpha: 0.9),
      offset: Offset(-4, -4),
      blurRadius: 8,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: AppColors.gray.withValues(alpha: 0.2),
      offset: Offset(4, -4),
      blurRadius: 8,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: AppColors.gray.withValues(alpha: 0.2),
      offset: Offset(-4, 4),
      blurRadius: 8,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: AppColors.gray.withValues(alpha: 0.5),
      offset: Offset(-1, -1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: AppColors.white.withValues(alpha: 0.3),
      offset: Offset(1, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
  ];
}
