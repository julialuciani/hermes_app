import 'package:flutter/material.dart';
import 'package:hermes_app/shared/entities/transaction_type_model.dart';
import 'package:hermes_app/shared/entities/unmapped_entities/base_model.dart';

class CategoryModel extends BaseModel<CategoryModel> {
  final String name;
  final TransactionTypeModel transactionType;
  final String icon;
  final Color color;
  const CategoryModel({
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
