import 'package:hermes_app/shared/database/idatabase.dart';

import '../entities/unmapped_entities/base_model.dart';

class BaseRepository<T extends BaseModel<T>> {
  final IDatabase _db;
  final String _table;

  const BaseRepository(this._db, this._table);

  Future<int> insert(T model) {
    return _db.insert(_table, model.toMap());
  }

  Future<int> update(T model) {
    return _db.update(
      _table,
      model.toMap(),
      where: "id = ${model.id}",
    );
  }

  Future<int> delete(int id) {
    return _db.delete(_table, where: "id = $id");
  }
}
