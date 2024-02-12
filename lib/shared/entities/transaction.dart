import 'dart:typed_data';

import 'package:hermes_app/shared/entities/unmapped_entities/base_model.dart';

class Transaction extends BaseModel<Transaction> {
  final String? description;
  final double? value;
  final int? typeId;
  final int? categoryId;
  final int? sourceId;
  final DateTime? date;
  final Uint8List? image;
  const Transaction({
    int? id,
    this.description,
    this.value,
    this.typeId,
    this.categoryId,
    this.sourceId,
    this.date,
    this.image,
  }) : super(id: id);

  @override
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "description": description,
      "value": value,
      "categoryId": categoryId,
      "sourceId": sourceId,
      "date": date?.millisecondsSinceEpoch,
      "image": image,
    };
  }
}
