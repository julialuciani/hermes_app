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

class PeriodExtractModel {
  final String title;
  final BalanceModel balance;
  PeriodExtractModel({
    required this.title,
    required this.balance,
  });

  PeriodExtractModel copyWith({
    String? title,
    BalanceModel? balance,
  }) {
    return PeriodExtractModel(
      title: title ?? this.title,
      balance: balance ?? this.balance,
    );
  }
}
