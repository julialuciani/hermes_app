import 'package:hermes_app/category/category/category_icon_selector/models/icon_segment.dart';
import 'package:hermes_app/shared/entities/failure_model.dart';

abstract class CategoryIconSelectorState {}

class CategoryIconSelectorInitial extends CategoryIconSelectorState {}

class CategoryIconSelectorLoading extends CategoryIconSelectorState {}

class CategoryIconSelectorSuccess extends CategoryIconSelectorState {
  final List<IconSegment> iconSegments;

  CategoryIconSelectorSuccess(this.iconSegments);
}

class CategoryIconSelectorError extends CategoryIconSelectorState {
  final Failure failure;

  CategoryIconSelectorError(this.failure);
}
