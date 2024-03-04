import 'package:hermes_app/shared/entities/failure_model.dart';

class SaveCategoryError extends Failure {
  SaveCategoryError({
    required super.error,
    required super.stackTrace,
  });
}
