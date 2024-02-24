import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:hermes_app/shared/entities/transaction_model.dart';
import 'package:hermes_app/shared/entities/unmapped_entities/base_model.dart';
import 'package:intl/intl.dart';

class TransactionTypeModel extends BaseModel<TransactionTypeModel> {
  final String name;
  final String? totalValue;
  final List<TransactionModel> transactions;

  const TransactionTypeModel({
    required int? id,
    required this.name,
    this.totalValue,
    this.transactions = const [],
  }) : super(id: id);

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory TransactionTypeModel.fromMap(Map<String, dynamic> map) {
    return TransactionTypeModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      totalValue: map['total_value'] as String?,
    );
  }

  TransactionTypeModel copyWith({
    String? name,
    String? totalValue,
    List<TransactionModel>? transactions,
  }) {
    return TransactionTypeModel(
      id: id,
      name: name ?? this.name,
      totalValue: totalValue ?? this.totalValue,
      transactions: transactions ?? this.transactions,
    );
  }

  String get getSumOfAllTransactions {
    double sum = 0;
    for (var transaction in transactions) {
      sum += transaction.value ?? 0.0;
    }

    final locale = Intl.systemLocale;
    final formatter = CurrencyTextInputFormatter(locale: locale);

    return formatter.formatDouble(sum);
  }
}
