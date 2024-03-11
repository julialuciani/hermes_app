import 'package:hermes_app/category/category_listing/get_categories_params.dart';
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

extension ToGetCategoriesParams on CategoryListingFiltersState {
  GetCategoriesParams toParams() {
    return GetCategoriesParams(
      search: search,
      movementTypeId: movementTypeId,
    );
  }
}
