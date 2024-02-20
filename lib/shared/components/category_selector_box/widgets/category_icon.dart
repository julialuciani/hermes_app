import 'package:flutter/material.dart';
import 'package:hermes_app/shared/entities/category_model.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/utils/icon_utils.dart';

class CategoryIcon extends StatelessWidget {
  final CategoryModel category;
  final bool isSelected;
  final void Function(int categoryId) onChange;

  const CategoryIcon({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    final screenWidth = MediaQuery.of(context).size.width;

    double getContainerWidth() {
      return screenWidth * 0.22;
    }

    return Container(
      width: getContainerWidth(),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.lightGrey : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              onChange(category.id!);
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: category.color,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(
                IconUtils.getIconByName(category.icon),
                color: AppColors.white,
                size: 32,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            category.name,
            style: typography.regular.small.copyWith(fontSize: 14),
            overflow: TextOverflow.fade,
            softWrap: false,
          ),
        ],
      ),
    );
  }
}
