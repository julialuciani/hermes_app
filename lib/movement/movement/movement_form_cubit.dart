import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/movement/movement/movement_form_state.dart';
import 'package:hermes_app/movement/movement/save_movement_use_case.dart';
import 'package:hermes_app/shared/entities/movement_model.dart';
import 'package:hermes_app/shared/entities/nullable_model.dart';
import 'package:hermes_app/shared/entities/unknown_error.dart';
import 'package:hermes_app/shared/usecases/get_picture_from_camera_use_case.dart';
import 'package:hermes_app/shared/validators/movement_validator.dart';

class MovementFormCubit extends Cubit<MovementFormState> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  MovementModel movement = MovementModel(date: DateTime.now());
  TextEditingController valueController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  final GetPictureFromCameraUseCase _getPictureFromCameraUseCase;
  final SaveMovementUseCase _saveMovementUsecase;

  MovementFormCubit(
    this._getPictureFromCameraUseCase,
    this._saveMovementUsecase,
  ) : super(MovementFormInitial());

  void reset() {
    movement = MovementModel(date: DateTime.now());
  }

  void change({
    Nullable<int?>? typeId,
    String? value,
    String? description,
    Nullable<DateTime?>? date,
    Nullable<int?>? categoryId,
    Nullable<Uint8List?>? image,
  }) {
    if (typeId != null && typeId.value != movement.typeId) {
      categoryId = Nullable(null);
    }

    movement = movement.copyWith(
      typeId: typeId,
      value: _formatValueToDouble(value),
      description: description,
      categoryId: categoryId,
      date: date,
      image: image,
    );

    emit(MovementFormSuccessChangeFields());
  }

  Future<void> save() async {
    try {
      await _saveMovementUsecase(movement);
      emit(MovementFormSuccessSave());
    } catch (exception, stackTrace) {
      final unknownError = UnknownError(
        error: exception,
        stackTrace: stackTrace,
      );

      emit(MovementFormErrorSave(unknownError));
    }
  }

  MovementValidatorResult validate() {
    return movement.validate();
  }

  Nullable<double?>? _formatValueToDouble(String? value) {
    double? formattedValue;
    if (value == null) return null;
    value =
        value.replaceAll(".", "").replaceAll(",", "").replaceAll("R\$ ", "");
    if (value.length > 2) {
      value =
          "${value.substring(0, value.length - 2)}.${value.substring(value.length - 2)}";
    }
    formattedValue = double.tryParse(value);

    return Nullable(formattedValue);
  }

  void takePictureAndAdd() async {
    final picture = await _getPictureFromCameraUseCase();

    if (picture == null) return;

    final bytes = await picture.readAsBytes();

    change(image: Nullable(bytes));
  }

  @override
  Future<void> close() {
    valueController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    return super.close();
  }
}
