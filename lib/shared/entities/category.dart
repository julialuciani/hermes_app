import 'package:flutter/material.dart';

class Category {
  final int id;
  final String name;
  final TransactionType transactionType;
  final String icon;
  final Color color;
  const Category({
    required this.id,
    required this.name,
    required this.transactionTypeId,
    required this.icon,
    required this.color,
  });
}
