import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/shared/entities/failure_model.dart';

class RegisterErrorCubit extends Cubit {
  RegisterErrorCubit(super.initialState);

  void registerError(Failure error) {
    debugPrint("${error.error}");
    debugPrint("${error.stackTrace}");
  }
}
