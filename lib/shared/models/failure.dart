abstract class Failure {
  final dynamic error;
  final StackTrace? stackTrace;
  Failure({
    required this.error,
    this.stackTrace,
  });
}
