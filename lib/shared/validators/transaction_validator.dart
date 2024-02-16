import 'package:hermes_app/shared/entities/transaction_model.dart';

extension TransactionValidator on TransactionModel {
  TransactionValidatorResult validate() {
    if (typeId == null) {
      return TransactionValidatorResult.typeCantBeNull;
    } else if (value == null) {
      return TransactionValidatorResult.valueCantBeNull;
    } else if (categoryId == null) {
      return TransactionValidatorResult.categoryCantBeNull;
    } else if (date == null) {
      return TransactionValidatorResult.dateCantBeNull;
    }
    return TransactionValidatorResult.success;
  }
}

enum TransactionValidatorResult {
  success,
  typeCantBeNull,
  valueCantBeNull,
  categoryCantBeNull,
  dateCantBeNull,
}
