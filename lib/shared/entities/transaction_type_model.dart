import 'package:hermes_app/shared/entities/unmapped_entities/base_model.dart';

class TransactionTypeModel extends BaseModel<TransactionTypeModel> {
  final String name;

  const TransactionTypeModel({
    required int? id,
    required this.name,
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
    );
  }
}
