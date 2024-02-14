import 'package:flutter/material.dart';
import 'package:hermes_app/shared/entities/unmapped_entities/base_model.dart';

class Category extends BaseModel<Category> {
  final String name;
  final int transactionTypeId;
  final String icon;
  final Color color;
  const Category({
    required int? id,
    required this.name,
    required this.transactionTypeId,
    required this.icon,
    required this.color,
  }) : super(id: id);

  @override
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "transactionTypeId": transactionTypeId,
      "icon": icon,
      "red": color.red,
      "green": color.green,
      "blue": color.blue,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    final color = Color.fromRGBO(
      map['red'],
      map['green'],
      map['blue'],
      1,
    );

    return Category(
      id: map['id'],
      name: map['name'],
      transactionTypeId: map['transactionTypeId'],
      icon: map['icon'],
      color: color,
    );
  }
}
