import 'package:hermes_app/shared/entities/transaction_type.dart';

class Source {
  final int id;
  final String name;
  final TransactionType transactionType;
  const Source({
    required this.id,
    required this.name,
    required this.transactionType,
  });
}
