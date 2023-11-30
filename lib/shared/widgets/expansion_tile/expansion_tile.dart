import 'package:flutter/material.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/theme/app_typography.dart';

class ExpandableBox extends StatelessWidget {
  final Widget title;
  final List<Widget> children;
  const ExpandableBox({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final typography = AppTypography.typography;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.black,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: ExpansionTile(
        title: DefaultTextStyle(
          style: typography.regular.medium,
          child: title,
        ),
        children: children,
      ),
    );
  }
}
