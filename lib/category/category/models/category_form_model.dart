import 'package:flutter/material.dart';
import 'package:hermes_app/shared/entities/nullable_model.dart';

class CategoryFormModel {
  final int? id;
  final String? name;
  final int? movementTypeId;
  final IconData? icon;
  final Color? color;
  const CategoryFormModel({
    this.id,
    this.name,
    this.movementTypeId,
    this.icon,
    this.color,
  });

  CategoryFormModel copyWith({
    int? id,
    String? name,
    Nullable<int?>? movementTypeId,
    Nullable<IconData?>? icon,
    Nullable<Color?>? color,
  }) {
    return CategoryFormModel(
      id: id ?? this.id,
      name: name ?? this.name,
      movementTypeId:
          movementTypeId != null ? movementTypeId.value : this.movementTypeId,
      icon: icon != null ? icon.value : this.icon,
      color: color != null ? color.value : this.color,
    );
  }
}
