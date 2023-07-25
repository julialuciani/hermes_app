import 'dart:typed_data';

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
    required this.categoryId,
    required this.sourceId,
    required this.date,
    required this.image,
  });
}
