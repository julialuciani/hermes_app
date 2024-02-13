import 'package:hermes_app/shared/models/failure.dart';
import 'package:hermes_app/shared/widgets/select/select.dart';

abstract class SourceSelectState {}

class SourceSelectInitial extends SourceSelectState {}

class SourceSelectLoading extends SourceSelectState {}

class SourceSelectSuccess extends SourceSelectState {
  final List<SelectData> data;

  SourceSelectSuccess(this.data);
}

class SourceSelectError extends SourceSelectState {
  final Failure failure;

  SourceSelectError(this.failure);
}
