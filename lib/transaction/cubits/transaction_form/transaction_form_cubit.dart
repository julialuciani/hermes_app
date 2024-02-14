import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/shared/entities/transaction.dart';
import 'package:hermes_app/shared/models/nullable.dart';
import 'package:hermes_app/transaction/cubits/transaction_form/transaction_form_state.dart';

class TransactionFormCubit extends Cubit<TransactionFormState> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Transaction transaction = const Transaction();
  TextEditingController valueController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  TransactionFormCubit() : super(TransactionFormInitial());

  void change({
    Nullable<int?>? typeId,
    String? value,
    String? description,
    Nullable<int?>? categoryId,
  }) {
    if (typeId != null && typeId.value != transaction.typeId) {
      categoryId = Nullable(null);
    }

    transaction = transaction.copyWith(
      typeId: typeId,
      value: _formatValueToDouble(value),
      description: description,
      categoryId: categoryId,
    );

    emit(TransactionFormSuccessChangeFields());
  }

  double? _formatValueToDouble(String? value) {
    double? formattedValue;
    if (value != null) {
      value = value.replaceAll(",", "").replaceAll("R\$ ", "");
      formattedValue = double.tryParse(value);
    }
    return formattedValue;
  }

  @override
  Future<void> close() {
    valueController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    return super.close();
  }
}
