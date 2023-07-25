import 'dart:typed_data';

import 'package:hermes_app/shared/entities/category.dart';
import 'package:hermes_app/shared/entities/source.dart';

class Transaction {
  final int id;
  final String description;
  final double value;
  final Category category;
  final Source source;
  final int date;
  final Uint8List image;
  const Transaction({
    required this.id,
    required this.description,
    required this.value,
    required this.category,
    required this.source,
    required this.date,
    required this.image,
  });
}
