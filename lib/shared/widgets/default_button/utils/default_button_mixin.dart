
import 'package:flutter/material.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';

mixin DefaultButtonMixin {
  MaterialStateProperty<Color> getBackgroundColor(bool enabled) {
    return MaterialStateProperty.resolveWith(
      (states) {
        if (!enabled) return AppColors.grey;
        if (states.contains(MaterialState.pressed)) {
          return AppColors.mediumRed;
        }
        return AppColors.red;
      },
    );
  }
}
