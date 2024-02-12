import 'package:hermes_app/shared/entities/transaction.dart';

extension TransactionValidator on Transaction {
  TransactionValidatorResult validate() {
    if (typeId == null) {
      return TransactionValidatorResult.typeCantBeNull;
    } else if (value == null) {
      return TransactionValidatorResult.valueCantBeNull;
    } else if (categoryId == null) {
      return TransactionValidatorResult.categoryCantBeNull;
    }
    return TransactionValidatorResult.success;
  }
}

enum TransactionValidatorResult {
  success,
  typeCantBeNull,
  valueCantBeNull,
  categoryCantBeNull
}
