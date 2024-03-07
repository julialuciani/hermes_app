import 'package:flutter_test/flutter_test.dart';
import 'package:hermes_app/category/category/models/category_form_model.dart';
import 'package:hermes_app/category/category/models/utils/category_form_model_transformer.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/theme/app_icons.dart';
import 'package:hermes_app/shared/utils/icon_utils.dart';

void main() {
  test(
    'WHEN transform CategoryFormModel into CategoryModel THEN ensure values are parsed correctly',
    () {
      //ARRANGE
      final categoryFormModel = CategoryFormModel(
        movementTypeId: 1,
        name: 'Mock Category',
        color: AppColors.black,
        icon: AppIcons.cash,
      );
      final expectedIconAsString = IconUtils.getIconNameByIcon(AppIcons.cash);

      //ACT
      final categoryModel = categoryFormModel.toCategoryModel();

      //ASSERT
      expect(categoryModel.color, categoryFormModel.color);
      expect(categoryModel.name, categoryFormModel.name);
      expect(categoryModel.movementTypeId, categoryFormModel.movementTypeId);
      expect(categoryModel.icon, expectedIconAsString);
    },
  );
}
