import 'package:hermes_app/shared/entities/transaction_type_model.dart';

class BalanceModel {
  final TransactionTypeModel income;
  final TransactionTypeModel expenses;
  final TransactionTypeModel investments;
  BalanceModel({
    required this.income,
    required this.expenses,
    required this.investments,
  });
}
