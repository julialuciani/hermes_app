import 'package:flutter/material.dart';
import 'package:hermes_app/shared/entities/category_model.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/utils/icon_utils.dart';
import 'package:hermes_app/shared/widgets/content_box/content_box.dart';

typedef OnAction = void Function(CategoryModel category);

class CategoryContentBoxWidget extends StatelessWidget {
  final CategoryModel category;
  final OnAction onTap;
  final OnAction onRemove;
  final int index;
  const CategoryContentBoxWidget({
    Key? key,
    required this.category,
    required this.onTap,
    required this.onRemove,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    String getMovementTypeName(String? movementTypeName) {
      switch (movementTypeName) {
        case 'expenses':
          return 'Gastos';
        case 'investments':
          return 'Investimentos';
        case 'income':
          return 'Entradas';
        default:
          return '';
      }
    }

    return ContentBox(
      onTap: () => onTap(category),
      borderWidth: 1,
      borderColor: category.color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: category.color,
                child: Icon(
                  IconUtils.getIconByName(category.icon),
                  color: AppColors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.name,
                    style: typography.regular.large,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    getMovementTypeName(
                      category.movementTypeName,
                    ),
                    style: typography.regular.medium,
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => onRemove(category),
                child: Icon(
                  Icons.delete,
                  color: AppColors.darkGrey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
