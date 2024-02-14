import 'package:hermes_app/shared/entities/failure_model.dart';

class UnknownError extends Failure {
  UnknownError({
    required super.error,
    super.stackTrace,
  });
}
