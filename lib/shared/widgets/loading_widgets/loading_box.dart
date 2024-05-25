import 'package:flutter/material.dart';
import 'package:hermes_app/shared/utils/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class LoadingBox extends StatelessWidget {
  final double height;
  final double borderRadius;

  const LoadingBox({
    Key? key,
    this.height = 60,
    this.borderRadius = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: context.screenWidth,
      child: Shimmer.fromColors(
        baseColor: AppColors.lightGrey,
        highlightColor: AppColors.white,
        child: Container(
          width: context.screenWidth,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: AppColors.lightGrey,
          ),
        ),
      ),
    );
  }
}
