import 'package:flutter_test/flutter_test.dart';
import 'package:hermes_app/shared/components/category_selector_box/utils/get_categories_to_show.dart';
import 'package:hermes_app/shared/entities/category_model.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';

void main() {
  late List<CategoryModel> mockCategories;

  setUpAll(() {
    mockCategories = [
      CategoryModel(
        id: 1,
        name: 'Aluguel',
        transactionTypeId: 2,
        icon: 'home',
        color: AppColors.red,
      ),
      CategoryModel(
        id: 2,
        name: 'Alimentação',
        transactionTypeId: 2,
        icon: 'food',
        color: AppColors.red,
      ),
      CategoryModel(
        id: 3,
        name: 'Transporte',
        transactionTypeId: 2,
        icon: 'bus',
        color: AppColors.red,
      ),
      CategoryModel(
        id: 4,
        name: 'Academia',
        transactionTypeId: 2,
        icon: 'barbell',
        color: AppColors.red,
      ),
      CategoryModel(
        id: 5,
        name: 'Mercado',
        transactionTypeId: 2,
        icon: 'shopping_cart',
        color: AppColors.red,
      ),
      CategoryModel(
        id: 6,
        name: 'Eletrônicos',
        transactionTypeId: 2,
        icon: 'eletronics',
        color: AppColors.red,
      ),
    ];
  });

  test(
    'WHEN no category is selected THEN should return first five items of list',
    () {
      //ARRANGE
      final expectedCategoriesIds = [1, 2, 3, 4, 5];

      //ACT
      final categories = GetCategoriesToShow.get(mockCategories, null);
      final categoriesIds = categories.map((e) => e.id).toList();

      //ASSERT
      expect(expectedCategoriesIds, categoriesIds);
    },
  );

  test(
    'WHEN category is selected but is part of first five THEN order should not be changed',
    () {
      //ARRANGE
      final expectedCategoriesIds = [1, 2, 3, 4, 5];

      //ACT
      final categories = GetCategoriesToShow.get(mockCategories, 3);
      final categoriesIds = categories.map((e) => e.id).toList();

      //ASSERT
      expect(expectedCategoriesIds, categoriesIds);
    },
  );

  test(
    'WHEN category is selected but it is not part of first five THEN it should be the first and the list removed',
    () {
      //ARRANGE
      final expectedCategoriesIds = [6, 1, 2, 3, 4];

      //ACT
      final categories = GetCategoriesToShow.get(mockCategories, 6);
      final categoriesIds = categories.map((e) => e.id).toList();

      //ASSERT
      expect(expectedCategoriesIds, categoriesIds);
    },
  );

  test(
    'WHEN categories size is less then 5 THEN it should return all containing items in order',
    () {
      //ARRANGE
      final categoriesSublist = mockCategories.sublist(0, 3);
      final expectedCategoriesIds = [1, 2, 3];

      //ACT
      final categories = GetCategoriesToShow.get(categoriesSublist, 1);
      final categoriesIds = categories.map((e) => e.id).toList();

      //ASSERT
      expect(expectedCategoriesIds, categoriesIds);
    },
  );
}
