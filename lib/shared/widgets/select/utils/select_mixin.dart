import 'package:flutter/material.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';

mixin SelectMixin {
  Color getTextColor(bool isSelected) {
    return isSelected ? AppColors.white : AppColors.black;
  }

  Color getBackgroundColor(bool isSelected) {
    return isSelected ? AppColors.black : AppColors.white;
  }
}
