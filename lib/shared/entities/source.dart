import 'package:hermes_app/shared/entities/transaction_type.dart';
import 'package:hermes_app/shared/entities/unmapped_entities/base_model.dart';

class Source extends BaseModel<Source> {
  final String name;
  final TransactionType transactionType;
  const Source({
    required int? id,
    required this.name,
    required this.transactionType,
  }) : super(id: id);

  @override
  Map<String, dynamic> toMap() {
    return {"id": id, "name": name, "transactionTypeId": transactionType.id};
  }
}
