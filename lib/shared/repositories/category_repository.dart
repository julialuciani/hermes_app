import '../constants/tables.dart';
import '../database/idatabase.dart';
import '../entities/category.dart';
import 'base_repository.dart';

class CategoryRepository extends BaseRepository<Category> {
  final IDatabase _db;

  CategoryRepository(this._db) : super(_db, Tables.category);

  Future<List<Category>> getByTransactionTypeId(int transactionTypeId) async {
    final result = await _db.getAll(
      Tables.category,
      where: "transactionTypeId = ?",
      whereArgs: [transactionTypeId],
    );

    final categories = List<Category>.from(result.map(Category.fromMap));

    return categories;
  }
}
