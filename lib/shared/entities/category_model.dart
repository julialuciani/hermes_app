import 'package:flutter/material.dart';
import 'package:hermes_app/shared/entities/unmapped_entities/base_model.dart';

class CategoryModel extends BaseModel<CategoryModel> {
  final String name;
  final int movementTypeId;
  final String icon;
  final Color color;
  const CategoryModel({
    required int? id,
    required this.name,
    required this.movementTypeId,
    required this.icon,
    required this.color,
  }) : super(id: id);

  @override
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "movementTypeId": movementTypeId,
      "icon": icon,
      "red": color.red,
      "green": color.green,
      "blue": color.blue,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    final color = Color.fromRGBO(
      map['red'],
      map['green'],
      map['blue'],
      1,
    );

    return CategoryModel(
      id: map['id'],
      name: map['name'],
      movementTypeId: map['movementTypeId'],
      icon: map['icon'],
      color: color,
    );
  }
}
