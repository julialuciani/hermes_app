import 'package:hermes_app/category/category_listing/get_categories_params.dart';
import 'package:hermes_app/shared/entities/category_model.dart';
import 'package:hermes_app/shared/repositories/category_repository.dart';

class GetCategoriesUseCase {
  final CategoryRepository _repository;

  GetCategoriesUseCase(this._repository);

  Future<List<CategoryModel>> call(GetCategoriesParams params) async {
    final categories = _repository.listCategories(params);
    return categories;
  }
}
