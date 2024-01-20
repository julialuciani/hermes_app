import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterErrorCubit extends Cubit {
  RegisterErrorCubit(super.initialState);

  void registerError(Failure error) {}
}

abstract class Failure {
  final dynamic error;
  final StackTrace? stackTrace;
  Failure({
    required this.error,
    this.stackTrace,
  });
}

class UnknownError extends Failure {
  UnknownError({
    required super.error,
    super.stackTrace,
  });
}
