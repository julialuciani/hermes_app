import 'package:flutter/material.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';

mixin InputMixin {
  Color getInputFillColor(bool enabled) {
    if (enabled) return AppColors.lightGrey;
    return AppColors.grey;
  }

  BorderSide getBorderSideByErrorText(String? errorText) {
    if (errorText == null) return BorderSide.none;
    return BorderSide(
      color: AppColors.red,
    );
  }
}
