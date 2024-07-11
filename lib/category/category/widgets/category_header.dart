import 'package:flutter/material.dart';
import 'package:hermes_app/category/category/models/category_form_model.dart';
import 'package:hermes_app/shared/utils/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';

class CategoryHeader extends StatelessWidget {
  final CategoryFormModel category;
  const CategoryHeader({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: category.color ?? AppColors.grey,
            child: Icon(
              category.icon ?? Icons.abc,
              size: 48,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            category.name ?? '',
            style: typography.regular.medium,
          ),
        ],
      ),
    );
  }
}
