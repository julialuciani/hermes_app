import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/category/category_listing/category_listing_state.dart';

class CategoryListingCubit extends Cubit<CategoryListingState> {
  CategoryListingCubit() : super(CategoryListingInitial());
}
