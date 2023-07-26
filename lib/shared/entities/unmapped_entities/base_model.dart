abstract class BaseModel<T> {
  final int? id;

  const BaseModel({
    required this.id,
  });

  Map<String, dynamic> toMap();
}
