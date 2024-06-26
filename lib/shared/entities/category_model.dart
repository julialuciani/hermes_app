import 'package:flutter/material.dart';
import 'package:hermes_app/shared/entities/unmapped_entities/base_model.dart';

class CategoryModel extends BaseModel<CategoryModel> {
  final String name;
  final int movementTypeId;
  final String icon;
  final Color color;

  final String? movementTypeName;
  const CategoryModel({
    required int? id,
    required this.name,
    required this.movementTypeId,
    required this.icon,
    required this.color,
    this.movementTypeName,
  }) : super(id: id);

  @override
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "movementTypeId": movementTypeId,
      "icon": icon,
      "alpha": color.alpha,
      "red": color.red,
      "green": color.green,
      "blue": color.blue,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    final color = Color.fromARGB(
      map['alpha'],
      map['red'],
      map['green'],
      map['blue'],
    );

    return CategoryModel(
      id: map['id'],
      name: map['name'],
      movementTypeId: map['movementTypeId'],
      icon: map['icon'],
      color: color,
      movementTypeName: map['movementTypeName'],
    );
  }
}
