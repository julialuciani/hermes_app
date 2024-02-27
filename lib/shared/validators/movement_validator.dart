import 'package:hermes_app/shared/entities/movement_model.dart';

extension MovementValidator on MovementModel {
  MovementValidatorResult validate() {
    if (typeId == null) {
      return MovementValidatorResult.typeCantBeNull;
    } else if (value == null) {
      return MovementValidatorResult.valueCantBeNull;
    } else if (date == null) {
      return MovementValidatorResult.dateCantBeNull;
    } else if (categoryId == null) {
      return MovementValidatorResult.categoryCantBeNull;
    }
    return MovementValidatorResult.success;
  }
}

enum MovementValidatorResult {
  success,
  typeCantBeNull,
  valueCantBeNull,
  categoryCantBeNull,
  dateCantBeNull,
}
