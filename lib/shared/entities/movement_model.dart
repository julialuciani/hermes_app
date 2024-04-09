import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:hermes_app/shared/entities/nullable_model.dart';
import 'package:hermes_app/shared/entities/unmapped_entities/base_model.dart';

class MovementModel extends BaseModel<MovementModel> {
  final String? description;
  final double? value;
  final int? typeId;
  final int? categoryId;
  final DateTime? date;
  final Uint8List? image;
  final String? typeName;
  final Color? categoryColor;
  final String? categoryName;

  const MovementModel({
    int? id,
    this.description,
    this.value,
    this.typeId,
    this.categoryId,
    this.date,
    this.image,
    this.typeName,
    this.categoryColor,
    this.categoryName,
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

  factory MovementModel.fromMap(Map<String, dynamic> map) {
    Color? color;

    if (map['red'] != null &&
        map['green'] != null &&
        map['blue'] != null &&
        map['alpha'] != null) {
      color = Color.fromARGB(
        map['alpha'],
        map['red'],
        map['green'],
        map['blue'],
      );
    }
    return MovementModel(
      id: map['id'] as int?,
      description: map['description'] as String?,
      value: map['value'] as double,
      categoryId: map['categoryId'] as int?,
      date: map['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['date'])
          : null,
      typeName: map['typeName'] as String?,
      image: map['image'] as Uint8List?,
      categoryColor: color,
      categoryName: map['categoryName'] as String?,
    );
  }

  MovementModel copyWith({
    String? description,
    Nullable<double?>? value,
    Nullable<int?>? typeId,
    Nullable<int?>? categoryId,
    Nullable<DateTime?>? date,
    Nullable<String?>? typeName,
    Nullable<Uint8List?>? image,
  }) {
    return MovementModel(
      description: description ?? this.description,
      value: value != null ? value.value : this.value,
      typeId: typeId != null ? typeId.value : this.typeId,
      categoryId: categoryId != null ? categoryId.value : this.categoryId,
      typeName: typeName != null ? typeName.value : this.typeName,
      date: date != null ? date.value : this.date,
      image: image != null ? image.value : this.image,
      categoryColor: categoryColor,
    );
  }
}
