import 'package:hermes_app/shared/entities/unmapped_entities/base_model.dart';

class TransactionType extends BaseModel<TransactionType> {
  final String name;
  const TransactionType({
    required int? id,
    required this.name,
  }) : super(id: id);

  @override
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
    };
  }
}
