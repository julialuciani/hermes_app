import 'package:hermes_app/home/utils/fetch_movements_filters.dart';
import 'package:hermes_app/shared/constants/tables.dart';
import 'package:hermes_app/shared/database/idatabase.dart';
import 'package:hermes_app/shared/entities/movement_model.dart';
import 'package:hermes_app/shared/repositories/base_repository.dart';

class MovementRepository extends BaseRepository<MovementModel> {
  final IDatabase _db;

  MovementRepository(this._db) : super(_db, Tables.movement);

  Future<List<MovementModel>> getByTypeId(int? typeId) async {
    final result = await _db.rawQuery(
      '''SELECT * FROM ${Tables.movement}
      JOIN ${Tables.category} ON ${Tables.movement}.categoryId = category.id
      WHERE category.movementTypeId = $typeId''',
    );

    return result.map((e) => MovementModel.fromMap(e)).toList();
  }

  Future<List<MovementModel>> getAll() async {
    const query = '''
    SELECT
      movement.id,
      movement.description,
      movement.value,
      movement.date,
      category.red,
      category.green,
      category.blue,
      movement.categoryId,
      movement_type.name AS typeName
    FROM ${Tables.movement}
    JOIN ${Tables.category} ON movement.categoryId = category.id
    JOIN ${Tables.movementType} ON category.movementTypeId = movement_type.id
    ''';

    final result = await _db.rawQuery(query);

    final movementTypes = result.map((e) => MovementModel.fromMap(e)).toList();

    return movementTypes;
  }

  Future<List<MovementModel>> fetch(FetchMovementsFilters filters) async {
    String where = '';
    where +=
        'WHERE movement.date BETWEEN ${filters.dateStart.millisecondsSinceEpoch} AND ${filters.dateEnd.millisecondsSinceEpoch}';
    if (filters.categoryId != null) {
      where += '\nAND';
      where += ' movement.categoryId = ${filters.categoryId}';
    }
    if (filters.movementTypeId != null) {
      where += where.isEmpty ? '\nWHERE' : '\nAND';
      where += ' category.movementTypeId = ${filters.movementTypeId}';
    }
    final query = '''
    SELECT
      movement.id,
      movement.description,
      movement.value,
      movement.date,
      category.red,
      category.green,
      category.blue,
      movement.categoryId,
      movement_type.name AS typeName,
      category.name AS categoryName
    FROM ${Tables.movement}
    JOIN ${Tables.category} ON movement.categoryId = category.id
    JOIN ${Tables.movementType} ON category.movementTypeId = movement_type.id
    $where
    ''';

    final result = await _db.rawQuery(query);

    final movementTypes = result.map((e) => MovementModel.fromMap(e)).toList();

    return movementTypes;
  }
}
