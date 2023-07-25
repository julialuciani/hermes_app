import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hermes_app/shared/database/database_sqflite.dart';
import 'package:sqflite/sqflite.dart';

final databaseProvider = Provider<IDatabase>((ref) => DatabaseImp());

typedef FutureList = Future<List<Map<String, dynamic>>>;
typedef Model = Map<String, dynamic>;

abstract class IDatabase {
  Future<int> delete(String table, {String? where, List<dynamic>? whereArgs});
  Future<int> insert(String table, Model model);
  FutureList getAll(String table,
      {String? where, List<dynamic>? whereArgs, String? orderBy});
  Future<int> update(String table, Model model,
      {String? where, List<dynamic>? whereArgs});
  FutureList rawQuery(String query, [List<dynamic>? args]);
}

class DatabaseImp implements IDatabase {
  Future<Database> _getDatabase() async {
    return await DatabaseSqflite.instance.database;
  }

  @override
  Future<int> delete(String table, {String? where, List? whereArgs}) async {
    final db = await _getDatabase();
    return db.delete(table, where: where, whereArgs: whereArgs);
  }

  @override
  FutureList getAll(String table,
      {String? where, List? whereArgs, String? orderBy}) async {
    final db = await _getDatabase();
    return db.query(table,
        where: where, whereArgs: whereArgs, orderBy: orderBy);
  }

  @override
  Future<int> insert(String table, Model model) async {
    final db = await _getDatabase();
    return db.insert(table, model, conflictAlgorithm: ConflictAlgorithm.fail);
  }

  @override
  FutureList rawQuery(String query, [List? args]) async {
    final db = await _getDatabase();
    return db.rawQuery(query, args);
  }

  @override
  Future<int> update(String table, Model model,
      {String? where, List? whereArgs}) async {
    final db = await _getDatabase();
    return db.update(table, model, where: where, whereArgs: whereArgs);
  }
}
