import 'package:flutter/material.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/theme/app_icons.dart';
import 'package:hermes_app/shared/widgets/content_box/content_box.dart';

class IconSelectorBox extends StatelessWidget {
  final Color? selectedColor;
  final IconData? selectedIcon;
  final void Function(IconData icon) onChange;
  final VoidCallback onTapOthers;
  const IconSelectorBox({
    super.key,
    this.selectedColor,
    this.selectedIcon,
    required this.onChange,
    required this.onTapOthers,
  });

  @override
  Widget build(BuildContext context) {
    return ContentBox(
      outsideLabel: 'Ícone *',
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        runSpacing: 8,
        spacing: 4,
        children: [
          ...AppIcons.highlightIcons.map((IconData icon) {
            return IconAvatar(
              onChange: onChange,
              selectedIcon: selectedIcon,
              selectedColor: selectedColor,
              icon: icon,
            );
          }),
          GestureDetector(
            onTap: onTapOthers,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: CircleAvatar(
                radius: 32,
                backgroundColor: AppColors.red,
                child: Icon(
                  Icons.add,
                  color: AppColors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class IconAvatar extends StatelessWidget {
  final void Function(IconData icon) onChange;
  final IconData? selectedIcon;
  final Color? selectedColor;
  final IconData icon;

  const IconAvatar({
    super.key,
    required this.onChange,
    required this.selectedIcon,
    required this.selectedColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: ValueKey(icon),
      onTap: () {
        onChange(icon);
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: selectedIcon == icon ? AppColors.grey : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: CircleAvatar(
          radius: 32,
          backgroundColor: selectedColor ?? AppColors.grey,
          child: Icon(
            icon,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
