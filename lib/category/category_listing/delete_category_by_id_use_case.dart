import 'package:hermes_app/shared/repositories/category_repository.dart';

class DeleteCategoryByIdUseCase {
  final CategoryRepository _repository;

  DeleteCategoryByIdUseCase(this._repository);

  Future<int> call(int categoryId) async {
    return _repository.delete(categoryId);
  }
}
