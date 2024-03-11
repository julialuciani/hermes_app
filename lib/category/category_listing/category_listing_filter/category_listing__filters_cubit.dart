import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/category/category_listing/category_listing_filter/category_listing_filters_state.dart';
import 'package:hermes_app/shared/entities/nullable_model.dart';

class CategoryListingFiltersCubit extends Cubit<CategoryListingFiltersState> {
  final _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  CategoryListingFiltersCubit() : super(CategoryListingFiltersState());

  void change({
    Nullable<String?>? search,
    Nullable<int?>? movementTypeId,
  }) {
    emit(state.copyWith(
      search: search,
      movementTypeId: movementTypeId,
    ));
  }

  void reset() {
    _searchController.text = '';
    emit(CategoryListingFiltersState());
  }
}
