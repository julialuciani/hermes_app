import 'dart:typed_data';

import 'package:hermes_app/shared/entities/nullable_model.dart';
import 'package:hermes_app/shared/entities/unmapped_entities/base_model.dart';

class TransactionModel extends BaseModel<TransactionModel> {
  final String? description;
  final double? value;
  final int? typeId;
  final int? categoryId;
  final DateTime? date;
  final Uint8List? image;

  const TransactionModel({
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

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as int?,
      description: map['description'] as String,
      value: map['value'] as double,
      categoryId: map['categoryId'] as int?,
      date: map['date'] as DateTime,
      image: map['image'] as Uint8List,
    );
  }

  TransactionModel copyWith({
    String? description,
    Nullable<double?>? value,
    Nullable<int?>? typeId,
    Nullable<int?>? categoryId,
    Nullable<DateTime?>? date,
    Nullable<Uint8List?>? image,
  }) {
    return TransactionModel(
      description: description ?? this.description,
      value: value != null ? value.value : this.value,
      typeId: typeId != null ? typeId.value : this.typeId,
      categoryId: categoryId != null ? categoryId.value : this.categoryId,
      date: date != null ? date.value : this.date,
      image: image != null ? image.value : this.image,
    );
  }
}
