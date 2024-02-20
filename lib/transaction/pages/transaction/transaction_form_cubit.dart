import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/shared/entities/nullable_model.dart';
import 'package:hermes_app/shared/entities/transaction_model.dart';
import 'package:hermes_app/shared/entities/unknown_error.dart';
import 'package:hermes_app/shared/usecases/get_picture_from_camera_use_case.dart';
import 'package:hermes_app/shared/validators/transaction_validator.dart';
import 'package:hermes_app/transaction/pages/transaction/save_transaction_use_case.dart';
import 'package:hermes_app/transaction/pages/transaction/transaction_form_state.dart';

class TransactionFormCubit extends Cubit<TransactionFormState> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TransactionModel transaction = TransactionModel(date: DateTime.now());
  TextEditingController valueController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  final GetPictureFromCameraUseCase _getPictureFromCameraUseCase;
  final SaveTransactionUseCase _saveTransactionUsecase;

  TransactionFormCubit(
    this._getPictureFromCameraUseCase,
    this._saveTransactionUsecase,
  ) : super(TransactionFormInitial());

  void reset() {
    transaction = TransactionModel(date: DateTime.now());
  }

  void change({
    Nullable<int?>? typeId,
    String? value,
    String? description,
    Nullable<DateTime?>? date,
    Nullable<int?>? categoryId,
    Nullable<Uint8List?>? image,
  }) {
    if (typeId != null && typeId.value != transaction.typeId) {
      categoryId = Nullable(null);
    }

    transaction = transaction.copyWith(
      typeId: typeId,
      value: _formatValueToDouble(value),
      description: description,
      categoryId: categoryId,
      date: date,
      image: image,
    );

    emit(TransactionFormSuccessChangeFields());
  }

  Future<void> save() async {
    try {
      await _saveTransactionUsecase(transaction);
      emit(TransactionFormSuccessSave());
    } catch (exception, stackTrace) {
      final unknownError = UnknownError(
        error: exception,
        stackTrace: stackTrace,
      );

      emit(TransactionFormErrorSave(unknownError));
    }
  }

  TransactionValidatorResult validate() {
    return transaction.validate();
  }

  Nullable<double?>? _formatValueToDouble(String? value) {
    double? formattedValue;
    if (value == null) return null;
    //Value format comes as R$  #.###,##
    value =
        value.replaceAll(".", "").replaceAll(",", ".").replaceAll("R\$ ", "");
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
