import 'package:hermes_app/shared/entities/failure_model.dart';

abstract class MovementFormState {}

class MovementFormInitial extends MovementFormState {}

class MovementFormLoading extends MovementFormState {}

class MovementFormSuccessChangeFields extends MovementFormState {}

class MovementFormSuccessSave extends MovementFormState {}

class MovementFormErrorSave extends MovementFormState {
  final Failure failure;

  MovementFormErrorSave(this.failure);
}

class MovementFormSuccessDelete extends MovementFormState {}
