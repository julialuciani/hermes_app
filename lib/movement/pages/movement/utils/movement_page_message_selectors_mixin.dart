import 'package:hermes_app/shared/validators/movement_validator.dart';
import 'package:hermes_app/shared/widgets/input/utils/date_validator.dart';

mixin MovementPageMessageSelectorsMixin {
  String? getErrorMessageByMovementValidatorResult({
    required MovementValidatorResult result,
  }) {
    String? message;
    switch (result) {
      case MovementValidatorResult.success:
        break;
      case MovementValidatorResult.typeCantBeNull:
        message = "Selecione um valor no campo tipo";
        break;
      case MovementValidatorResult.valueCantBeNull:
        message = "Preencha o campo valor";
        break;
      case MovementValidatorResult.dateCantBeNull:
        message = "Defina uma data válida";
        break;
      case MovementValidatorResult.categoryCantBeNull:
        message = "Escolha uma categoria";
        break;
    }

    return message;
  }

  String? getValidatorMessageByDateValidatorResult({
    required DateValidatorResult dateValidatorResult,
  }) {
    String? message;
    switch (dateValidatorResult) {
      case DateValidatorResult.correct:
        break;
      case DateValidatorResult.formatError:
        message = "Formato de data inválido";
        break;
      case DateValidatorResult.isBefore2000:
        message = "Data não pode ser antes de 2000";
        break;
      case DateValidatorResult.isAfterNow:
        message = "Data não pode ser depois de hoje";
        break;
    }

    return message;
  }
}
