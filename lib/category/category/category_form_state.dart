import 'package:hermes_app/shared/entities/failure_model.dart';

abstract class CategoryFormState {}

class CategoryFormInitial extends CategoryFormState {}

class CategoryFormLoading extends CategoryFormState {}

class CategoryFormSuccessChangeFields extends CategoryFormState {}

class CategoryFormSuccessSave extends CategoryFormState {}

class CategoryFormErrorSave extends CategoryFormState {
  final Failure failure;

  CategoryFormErrorSave(this.failure);
}
