import 'package:hermes_app/category/category/models/category_form_model.dart';

extension CategoryFormModelValidator on CategoryFormModel {
  CategoryFormValidationResult validate() {
    if (movementTypeId == null) return CategoryFormValidationResult.typeNotNull;
    if (name == null || name?.isEmpty == true) {
      return CategoryFormValidationResult.nameNotNull;
    }
    if (icon == null) return CategoryFormValidationResult.iconNotNull;
    if (color == null) return CategoryFormValidationResult.colorNotNull;
    return CategoryFormValidationResult.success;
  }
}

enum CategoryFormValidationResult {
  success,
  typeNotNull,
  nameNotNull,
  iconNotNull,
  colorNotNull,
}
