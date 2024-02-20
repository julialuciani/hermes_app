import 'package:hermes_app/shared/validators/transaction_validator.dart';
import 'package:hermes_app/shared/widgets/input/utils/date_validator.dart';

mixin TransactionPageMessageSelectorsMixin {
  String? getErrorMessageByTransactionValidatorResult({
    required TransactionValidatorResult result,
  }) {
    String? message;
    switch (result) {
      case TransactionValidatorResult.success:
        break;
      case TransactionValidatorResult.typeCantBeNull:
        message = "Selecione um valor no campo tipo";
        break;
      case TransactionValidatorResult.valueCantBeNull:
        message = "Preencha o campo valor";
        break;
      case TransactionValidatorResult.dateCantBeNull:
        message = "Defina uma data válida";
        break;
      case TransactionValidatorResult.categoryCantBeNull:
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
