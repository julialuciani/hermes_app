import 'package:hermes_app/shared/entities/movement_type_model.dart';
import 'package:hermes_app/shared/entities/not_found_error.dart';

import '../constants/tables.dart';
import '../database/idatabase.dart';
import 'base_repository.dart';

class MovementTypeRepository extends BaseRepository<MovementTypeModel> {
  final IDatabase _db;

  MovementTypeRepository(this._db) : super(_db, Tables.movementType);

  Future<List<MovementTypeModel>> getAll() async {
    final result = await _db.getAll(Tables.movementType);

    final movementTypes =
        result.map((e) => MovementTypeModel.fromMap(e)).toList();

    return movementTypes;
  }

  Future<MovementTypeModel> getByType(String movementType) async {
    final result = await _db.rawQuery(
        'SELECT * FROM ${Tables.movementType} WHERE name = $movementType');

    if (result.isEmpty) {
      throw NotFoundError(error: 'Não encontramos nenhum dado :(');
    } else {
      return MovementTypeModel.fromMap(result.first);
    }
  }
}
