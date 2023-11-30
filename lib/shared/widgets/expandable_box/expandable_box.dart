import 'package:flutter/material.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/theme/app_typography.dart';

class ExpandableBox extends StatefulWidget {
  /// [title] a required Widget that will be displayed at the top of the [ExpandableBox]
  final Widget title;

  /// [subtitle] a Widget that will be displayed below the title
  final Widget? subtitle;

  /// [children] a [List] of [Widget] that will fill the [ExpandableBox] when expanded
  final List<Widget> children;

  /// [initiallyExpanded] is used to set an initial value to the [ExpandableBox]
  final bool? initiallyExpanded;

  /// [ExpandableBox] is a widget that contains an arrow and hides or displays the [children] according to the state
  const ExpandableBox({
    Key? key,
    required this.title,
    this.subtitle,
    required this.children,
    this.initiallyExpanded,
  }) : super(key: key);

  @override
  State<ExpandableBox> createState() => _ExpandableBoxState();
}

class _ExpandableBoxState extends State<ExpandableBox> {
  late bool isExpanded;

  @override
  void initState() {
    isExpanded = widget.initiallyExpanded ?? false;
    super.initState();
  }

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
        onExpansionChanged: (val) => setState(() => isExpanded = val),
        controlAffinity: ListTileControlAffinity.trailing,
        childrenPadding: const EdgeInsets.all(8),
        initiallyExpanded: widget.initiallyExpanded ?? false,
        title: DefaultTextStyle(
          style: typography.regular.medium,
          child: widget.title,
        ),
        subtitle: widget.subtitle != null
            ? DefaultTextStyle(
                style: typography.regular.small,
                child: widget.subtitle!,
              )
            : null,
        trailing: Icon(
          isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
          color: AppColors.black,
          size: 30,
        ),
        children: widget.children,
      ),
    );
  }
}
