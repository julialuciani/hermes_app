import 'package:sqflite/sqflite.dart';

typedef FutureList = Future<List<Map<String, dynamic>>>;
typedef Model = Map<String, dynamic>;

abstract class IDatabase{
  Future<int> delete(String table, {String? where, List<dynamic>? whereArgs});
  Future<int> insert(String table, Model model);
  FutureList getAll(String table,{String? where, List<dynamic>? whereArgs, String? orderBy});
  Future<int> update(String table, Model model, {String? where, List<dynamic>? whereArgs});
  FutureList rawQuery(String query, [List<dynamic>? args]);
}

class DatabaseImp implements IDatabase{
  final Database _db;

  DatabaseImp(this._db);
  @override
  Future<int> delete(String table, {String? where, List? whereArgs}) {
   return  _db.delete(table, where: where, whereArgs: whereArgs);
  }

  @override
  FutureList getAll(String table, {String? where, List? whereArgs, String? orderBy}) {
   return _db.query(table, where: where, whereArgs: whereArgs, orderBy: orderBy);
  }

  @override
  Future<int> insert(String table, Model model) {
    return  _db.insert(table, model, conflictAlgorithm: ConflictAlgorithm.fail);
  }

  @override
  FutureList rawQuery(String query, [List? args]) {
   return _db.rawQuery(query, args);
  }

  @override
  Future<int> update(String table, Model model, {String? where, List? whereArgs}) {
   return _db.update(table, model, where: where, whereArgs: whereArgs);
  }
}