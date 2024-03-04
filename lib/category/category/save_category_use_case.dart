import 'package:hermes_app/shared/entities/category_model.dart';
import 'package:hermes_app/shared/repositories/category_repository.dart';

class SaveCategoryUseCase {
  final CategoryRepository _repository;

  SaveCategoryUseCase(this._repository);

  Future<int> call(CategoryModel category) async {
    if (category.id == null) {
      return _repository.insert(category);
    } else {
      await _repository.update(category);
      return category.id!;
    }
  }
}
