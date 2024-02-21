import 'package:hermes_app/shared/entities/category_model.dart';

class GetCategoriesToShow {
  static List<CategoryModel> get(
    List<CategoryModel> categories,
    int? currentCategoryId,
  ) {
    if (categories.length <= 5) return categories;

    final fiveFirstCategories = categories.take(5).toList();
    final isCurrentCategoryIdInFirstFive = fiveFirstCategories.any(
      (category) => category.id == currentCategoryId,
    );

    if (isCurrentCategoryIdInFirstFive || currentCategoryId == null) {
      return fiveFirstCategories;
    }

    final selectedCategory = categories.firstWhere(
      (category) => category.id == currentCategoryId,
    );

    fiveFirstCategories.insert(0, selectedCategory);
    fiveFirstCategories.removeLast();

    return fiveFirstCategories;
  }
}
