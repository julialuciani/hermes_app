import 'package:flutter/material.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/widgets/content_box/utils/content_box_mixin.dart';

class ContentBox extends StatelessWidget with ContentBoxMixin {
  final EdgeInsets? padding;
  final Widget child;
  final VoidCallback? onTap;
  final Color? borderColor;
  const ContentBox({
    super.key,
    this.padding,
    required this.child,
    this.onTap,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: getPadding(padding),
        width: context.screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: getBorderColor(borderColor),
            width: 0.5,
          ),
        ),
        child: UnconstrainedBox(child: child),
      ),
    );
  }
}
