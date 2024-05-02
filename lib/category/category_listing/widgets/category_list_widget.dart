import 'package:flutter/material.dart';
import 'package:hermes_app/category/category_listing/widgets/category_content_box_widget.dart';
import 'package:hermes_app/shared/entities/category_model.dart';

typedef OnAction = void Function(CategoryModel category);

class CategoryListWidget extends StatelessWidget {
  final List<CategoryModel> categories;
  final OnAction onTap;
  final OnAction onRemove;
  const CategoryListWidget({
    super.key,
    required this.categories,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 80),
      physics: const BouncingScrollPhysics(),
      itemCount: categories.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final category = categories[index];
        return CategoryContentBoxWidget(
          category: category,
          onTap: onTap,
          onRemove: onRemove,
          index: index,
        );
      },
    );
  }
}
