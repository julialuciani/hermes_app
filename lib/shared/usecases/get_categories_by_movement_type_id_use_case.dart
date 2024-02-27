import 'package:hermes_app/shared/entities/category_model.dart';
import 'package:hermes_app/shared/repositories/category_repository.dart';

class GetCategoriesByMovementTypeIdUseCase {
  final CategoryRepository _repository;

  GetCategoriesByMovementTypeIdUseCase(
    this._repository,
  );

  Future<List<CategoryModel>> call(int movementTypeId) async {
    final categories = await _repository.getByMovementTypeId(
      movementTypeId,
    );
    return categories;
  }
}
