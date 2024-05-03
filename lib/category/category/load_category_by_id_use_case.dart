import 'package:hermes_app/shared/entities/category_model.dart';
import 'package:hermes_app/shared/repositories/category_repository.dart';

class LoadCategoryByIdUseCase {
  final CategoryRepository _repository;

  LoadCategoryByIdUseCase(this._repository);

  Future<CategoryModel> call(int categoryId) async {
    final CategoryModel category = await _repository.getById(categoryId);
    return category;
  }
}
