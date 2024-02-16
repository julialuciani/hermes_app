import 'package:hermes_app/shared/entities/category_model.dart';
import 'package:hermes_app/shared/repositories/category_repository.dart';

class GetCategoriesByTransactionTypeIdUseCase {
  final CategoryRepository _repository;

  GetCategoriesByTransactionTypeIdUseCase(
    this._repository,
  );

  Future<List<CategoryModel>> call(int transactionTypeId) async {
    final categories = await _repository.getByTransactionTypeId(
      transactionTypeId,
    );

    return categories;
  }
}