import 'package:flutter/material.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/widgets/content_box/utils/content_box_mixin.dart';

class ContentBox extends StatelessWidget with ContentBoxMixin {
  /// [padding] the internal spacing that will exist within the component, if null, will apply the default, of 16
  final EdgeInsets? padding;

  /// [child] the content that will be inside the component, which can be anything
  final Widget child;

  /// [onTap] function that will be called when clicking on the box, if it is null, nothing will happen when clicking
  final VoidCallback? onTap;

  /// [borderColor] allows customization of the component's border color, the default is [AppColors.black]
  final Color? borderColor;

  final String? outsideLabel;

  /// [ContentBox] is a widget that must be used to group information that is related
  const ContentBox({
    super.key,
    this.outsideLabel,
    this.padding,
    required this.child,
    this.onTap,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (outsideLabel != null) ...[
          Text(
            outsideLabel!,
            style: typography.regular.medium,
          ),
          const SizedBox(height: 6),
        ],
        GestureDetector(
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
        ),
      ],
    );
  }
}
