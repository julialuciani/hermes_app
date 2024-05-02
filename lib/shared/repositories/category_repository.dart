import '../constants/tables.dart';
import '../database/idatabase.dart';
import '../entities/category_model.dart';
import 'base_repository.dart';

class CategoryRepository extends BaseRepository<CategoryModel> {
  final IDatabase _db;

  CategoryRepository(this._db) : super(_db, Tables.category);

  Future<List<CategoryModel>> getByMovementTypeId(int movementTypeId) async {
    final result = await _db.rawQuery(
      '''
      SELECT
        *
      FROM ${Tables.category}
      WHERE movementTypeId = $movementTypeId
      GROUP BY id
      ''',
    );

    final categories =
        List<CategoryModel>.from(result.map(CategoryModel.fromMap));

    return categories;
  }
}
