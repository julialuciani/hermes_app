import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/category/category/category_form_state.dart';
import 'package:hermes_app/category/category/errors/save_category_error.dart';
import 'package:hermes_app/category/category/models/category_form_model.dart';
import 'package:hermes_app/category/category/models/utils/category_form_model_transformer.dart';
import 'package:hermes_app/category/category/models/utils/category_form_model_validator.dart';
import 'package:hermes_app/category/category/save_category_use_case.dart';
import 'package:hermes_app/shared/entities/category_model.dart';
import 'package:hermes_app/shared/entities/nullable_model.dart';

class CategoryFormCubit extends Cubit<CategoryFormState> {
  CategoryFormModel _category = const CategoryFormModel();
  CategoryFormModel get category => _category;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final nameController = TextEditingController();

  final SaveCategoryUseCase _saveCategoryUseCase;

  CategoryFormCubit(
    this._saveCategoryUseCase,
  ) : super(CategoryFormInitial());

  CategoryFormValidationResult validateForm() {
    return category.validate();
  }

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

  void save() async {
    final categoryModel = category.toCategoryModel();

    try {
      await _saveCategoryUseCase(categoryModel);
      emit(CategoryFormSuccessSave());
    } catch (error, stackTrace) {
      final saveCategoryException = SaveCategoryError(
        error: error,
        stackTrace: stackTrace,
      );

      emit(CategoryFormErrorSave(saveCategoryException));
    }
  }

  void setCategory(CategoryModel category) {
    _category = category.toCategoryFormModel();
    nameController.text = _category.name ?? '';
    emit(CategoryFormSuccessChangeFields());
  }

  void reset() {
    _category = const CategoryFormModel();
    nameController.clear();
  }
}
