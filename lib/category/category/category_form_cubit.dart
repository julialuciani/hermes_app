import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/category/category/category_form_model.dart';
import 'package:hermes_app/category/category/category_form_state.dart';
import 'package:hermes_app/shared/entities/nullable_model.dart';

class CategoryFormCubit extends Cubit<CategoryFormState> {
  CategoryFormModel _category = const CategoryFormModel();
  CategoryFormModel get category => _category;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final nameController = TextEditingController();

  CategoryFormCubit() : super(CategoryFormInitial());

  void change({
    Nullable<int?>? movementTypeId,
    String? name,
    Nullable<IconData?>? icon,
    Nullable<Color?>? color,
  }) {
    _category = _category.copyWith(
      movementTypeId: movementTypeId,
      name: name,
      icon: icon,
      color: color,
    );

    emit(CategoryFormSuccessChangeFields());
  }
}
