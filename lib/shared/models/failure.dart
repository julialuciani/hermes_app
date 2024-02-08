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
