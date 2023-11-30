import 'package:flutter/material.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';

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
        textColor: AppColors.black,
        collapsedTextColor: AppColors.black,
        title: DefaultTextStyle(
          style: TextStyle(
            color: AppColors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          child: title,
        ),
        children: children,
      ),
    );
  }
}
