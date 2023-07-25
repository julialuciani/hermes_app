import 'dart:typed_data';

import 'package:hermes_app/shared/entities/category.dart';
import 'package:hermes_app/shared/entities/source.dart';
import 'package:hermes_app/shared/entities/unmapped_entities/base_model.dart';

class Transaction extends BaseModel<Transaction> {
  final String description;
  final double value;
  final Category category;
  final Source source;
  final DateTime date;
  final Uint8List image;
  const Transaction({
    required int? id,
    required this.description,
    required this.value,
    required this.category,
    required this.source,
    required this.date,
    required this.image,
  }) : super(id: id);

  @override
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "description": description,
      "value": value,
      "categoryId": category.id,
      "sourceId": source.id,
      "date": date.millisecondsSinceEpoch,
      "image": image,
    };
  }
}
