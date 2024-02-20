import 'package:hermes_app/shared/entities/transaction_model.dart';
import 'package:hermes_app/shared/entities/unmapped_entities/base_model.dart';

class TransactionTypeModel extends BaseModel<TransactionTypeModel> {
  final String name;
  final String totalValue;
  final List<TransactionModel> transactions;

  const TransactionTypeModel({
    required int? id,
    required this.name,
    required this.totalValue,
    required this.transactions,
  }) : super(id: id);

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'total_value': totalValue,
      'transactions': transactions,
    };
  }

  factory TransactionTypeModel.fromMap(Map<String, dynamic> map) {
    return TransactionTypeModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      totalValue: map['total_value'] as String,
      transactions: map['transactions'] as List<TransactionModel>,
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
}
