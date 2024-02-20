import '../constants/tables.dart';
import '../database/idatabase.dart';
import '../entities/category_model.dart';
import 'base_repository.dart';

class CategoryRepository extends BaseRepository<CategoryModel> {
  // ignore: unused_field
  final IDatabase _db;

  CategoryRepository(this._db) : super(_db, Tables.category);

  Future<List<CategoryModel>> getByTransactionTypeId(
      int transactionTypeId) async {
    final result = await _db.getAll(
      Tables.category,
      where: "transactionTypeId = ?",
      whereArgs: [transactionTypeId],
    );

    final categories =
        List<CategoryModel>.from(result.map(CategoryModel.fromMap));

    return categories;
  }
}
