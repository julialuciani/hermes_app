import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/shared/models/failure.dart';

class RegisterErrorCubit extends Cubit {
  RegisterErrorCubit(super.initialState);

  void registerError(Failure error) {}
}
