import 'package:hermes_app/category/category/models/category_form_model.dart';
import 'package:hermes_app/shared/entities/category_model.dart';
import 'package:hermes_app/shared/utils/icon_utils.dart';

extension CategoryFormModelTransformer on CategoryFormModel {
  CategoryModel toCategoryModel() {
    return CategoryModel(
      id: id,
      name: name!,
      movementTypeId: movementTypeId!,
      icon: IconUtils.getIconNameByIcon(icon!),
      color: color!,
    );
  }
}
