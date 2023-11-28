import 'package:flutter/material.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';

class ContentBox extends StatelessWidget {
  final EdgeInsets padding;
  final Widget child;
  final VoidCallback? onTap;
  final Color? borderColor;
  const ContentBox({
    super.key,
    this.padding = const EdgeInsets.all(16),
    required this.child,
    this.onTap,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        width: context.screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: borderColor ?? AppColors.black,
            width: 0.5,
          ),
        ),
        child: UnconstrainedBox(child: child),
      ),
    );
  }
}
