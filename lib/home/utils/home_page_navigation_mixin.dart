import 'package:hermes_app/shared/utils/transaction_type_enum.dart';

mixin HomePageNavigationMixin {
  TransactionTypeEnum getTransactionTypeByIndex(int index) {
    switch (index) {
      case 0:
      case 1:
        return TransactionTypeEnum.expenses;
      case 2:
        return TransactionTypeEnum.income;
      case 3:
        return TransactionTypeEnum.investments;
      default:
        throw Exception('Index given was invalid. Index was $index');
    }
  }
}
