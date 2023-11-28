import 'package:flutter/material.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';

mixin ContentBoxMixin {
  EdgeInsets getPadding(EdgeInsets? padding) {
    return padding ?? const EdgeInsets.all(16);
  }

  Color getBorderColor(Color? borderColor) {
    return borderColor ?? AppColors.black;
  }
}
