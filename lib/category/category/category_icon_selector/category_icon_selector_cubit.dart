import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/category/category/category_icon_selector/category_icon_selector_state.dart';
import 'package:hermes_app/category/category/category_icon_selector/error/fetch_icon_segments_error.dart';
import 'package:hermes_app/category/category/category_icon_selector/get_icons_segments_use_case.dart';

class CategoryIconSelectorCubit extends Cubit<CategoryIconSelectorState> {
  final GetIconsSegmentsUseCase _useCase;

  CategoryIconSelectorCubit(
    this._useCase,
  ) : super(CategoryIconSelectorInitial());

  void fetch() async {
    emit(CategoryIconSelectorLoading());
    try {
      final iconSegments = await _useCase();
      emit(CategoryIconSelectorSuccess(iconSegments));
    } catch (error, stackTrace) {
      final failure = FetchIconSegmentsError(
        error: error,
        stackTrace: stackTrace,
      );
      emit(CategoryIconSelectorError(failure));
    }
  }
}
