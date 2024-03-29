import 'package:flutter/material.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/widgets/content_box/content_box.dart';

class ColorSelectorBox extends StatelessWidget {
  final Color? currentColor;
  final void Function(Color? color) onChange;
  const ColorSelectorBox({
    super.key,
    this.currentColor,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return ContentBox(
      outsideLabel: 'Cor *',
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        runSpacing: 8,
        spacing: 4,
        children: AppColors.colorsToHighlight.map(
          (color) {
            return Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: currentColor == color ? AppColors.grey : null,
              ),
              child: GestureDetector(
                key: ValueKey(color),
                onTap: () {
                  if (currentColor == color) {
                    onChange(null);
                  } else {
                    onChange(color);
                  }
                },
                child: CircleAvatar(
                  backgroundColor: color,
                  radius: 32,
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
