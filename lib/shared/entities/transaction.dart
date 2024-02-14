import 'dart:typed_data';

import 'package:hermes_app/shared/entities/unmapped_entities/base_model.dart';
import 'package:hermes_app/shared/models/nullable.dart';

class Transaction extends BaseModel<Transaction> {
  final String? description;
  final double? value;
  final int? typeId;
  final int? categoryId;
  final DateTime? date;
  final Uint8List? image;

  const Transaction({
    int? id,
    this.description,
    this.value,
    this.typeId,
    this.categoryId,
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
      "date": date?.millisecondsSinceEpoch,
      "image": image,
    };
  }

  Transaction copyWith({
    String? description,
    double? value,
    Nullable<int?>? typeId,
    Nullable<int?>? categoryId,
    DateTime? date,
    Uint8List? image,
  }) {
    return Transaction(
      description: description ?? this.description,
      value: value ?? this.value,
      typeId: typeId != null ? typeId.value : this.typeId,
      categoryId: categoryId != null ? categoryId.value : this.categoryId,
      date: date ?? this.date,
      image: image ?? this.image,
    );
  }
}
