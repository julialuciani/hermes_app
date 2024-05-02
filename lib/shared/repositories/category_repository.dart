import 'package:hermes_app/category/category_listing/get_categories_params.dart';
import 'package:hermes_app/shared/repositories/errors/category_repository_errors.dart';
import 'package:sqflite/sqflite.dart';

import '../constants/tables.dart';
import '../database/idatabase.dart';
import '../entities/category_model.dart';
import 'base_repository.dart';

class CategoryRepository extends BaseRepository<CategoryModel> {
  final IDatabase _db;

  CategoryRepository(this._db) : super(_db, Tables.category);

  Future<List<CategoryModel>> getByMovementTypeId(int movementTypeId) async {
    final result = await _db.getAll(
      Tables.category,
      where: "movementTypeId = ?",
      whereArgs: [movementTypeId],
    );

    final categories =
        List<CategoryModel>.from(result.map(CategoryModel.fromMap));

    return categories;
  }

  Future<List<CategoryModel>> listCategories(GetCategoriesParams params) async {
    try {
      String where = '';
      if (params.search != null) {
        where += ' WHERE category.name LIKE "%${params.search}%"';
      }
      if (params.movementTypeId != null) {
        where += where.isEmpty ? ' WHERE ' : ' AND ';
        where += ' category.movementTypeId = ${params.movementTypeId}';
      }

      final String query = '''
      SELECT
        category.id,
        category.name,
        category.movementTypeId,
        category.`icon`,
        category.`alpha`,
        category.`red`,
        category.`green`,
        category.`blue`,
        movement_type.name AS movementTypeName
      FROM ${Tables.category}
      LEFT JOIN movement_type ON category.movementTypeId = movement_type.id
      $where
      GROUP BY category.id
    ''';

      final List<Map<String, dynamic>> queryResult = await _db.rawQuery(query);

      final categories =
          List<CategoryModel>.from(queryResult.map(CategoryModel.fromMap));

      return categories;
    } on DatabaseException {
      rethrow;
    }
  }

  Future<CategoryModel> getById(int id) async {
    final result = await _db.rawQuery(
      '''
      SELECT * FROM ${Tables.category}
      WHERE id = ?
      ''',
      [id],
    );

    if (result.isEmpty) throw CategoryNotFoundError();

    final category = CategoryModel.fromMap(result.first);

    return category;
  }
}
