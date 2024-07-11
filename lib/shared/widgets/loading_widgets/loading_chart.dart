import 'package:flutter/material.dart';
import 'package:hermes_app/shared/utils/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class LoadingChart extends StatelessWidget {
  const LoadingChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.lightGrey,
      highlightColor: AppColors.white,
      child: Container(
        width: context.screenWidth * 0.4,
        height: context.screenWidth * 0.4,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.lightGrey,
            width: 20,
          ),
        ),
      ),
    );
  }
}
