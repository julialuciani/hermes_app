import 'package:hermes_app/shared/models/failure.dart';

class UnknownError extends Failure {
  UnknownError({
    required super.error,
    super.stackTrace,
  });
}
