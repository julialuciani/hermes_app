import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/shared/entities/failure_model.dart';

class RegisterErrorCubit extends Cubit {
  RegisterErrorCubit(super.initialState);

  void registerError(Failure error) {
    FirebaseCrashlytics.instance.recordError(
      error.error,
      error.stackTrace,
    );
    debugPrint("${error.error}");
    debugPrint("${error.stackTrace}");
  }
}
