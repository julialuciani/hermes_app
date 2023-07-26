import 'package:flutter/material.dart';
import 'package:hermes_app/shared/entities/transaction_type.dart';
import 'package:hermes_app/shared/entities/unmapped_entities/base_model.dart';

class Category extends BaseModel<Category> {
  final String name;
  final TransactionType transactionType;
  final String icon;
  final Color color;
  const Category({
    required int? id,
    required this.name,
    required this.transactionType,
    required this.icon,
    required this.color,
  }) : super(id: id);

  @override
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "transactionTypeId": transactionType.id,
      "icon": icon,
      "alpha": color.alpha,
      "red": color.red,
      "green": color.green,
      "blue": color.blue,
    };
  }
}
