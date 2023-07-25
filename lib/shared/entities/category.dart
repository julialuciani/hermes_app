import 'package:flutter/material.dart';
import 'package:hermes_app/shared/entities/transaction_type.dart';

class Category {
  final int id;
  final String name;
  final TransactionType transactionType;
  final String icon;
  final Color color;
  const Category({
    required this.id,
    required this.name,
    required this.transactionType,
    required this.icon,
    required this.color,
  });
}
