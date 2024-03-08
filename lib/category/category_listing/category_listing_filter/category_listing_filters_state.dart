// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hermes_app/shared/entities/nullable_model.dart';

class CategoryListingFiltersState {
  final String? search;
  final int? movementTypeId;

  CategoryListingFiltersState({
    this.search,
    this.movementTypeId,
  });

  CategoryListingFiltersState copyWith({
    Nullable<String?>? search,
    Nullable<int?>? movementTypeId,
  }) {
    return CategoryListingFiltersState(
      search: search != null ? search.value : this.search,
      movementTypeId:
          movementTypeId != null ? movementTypeId.value : this.movementTypeId,
    );
  }
}
