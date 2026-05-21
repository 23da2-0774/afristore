import 'package:afristore/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const CategoryChip({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onTap?.call(),
      selectedColor: AppColors.primary,
      backgroundColor: AppColors.cardColor,
      labelStyle: TextStyle(
        color: isSelected ? AppColors.cardColor : AppColors.textDark,
      ),
    );
  }
}
