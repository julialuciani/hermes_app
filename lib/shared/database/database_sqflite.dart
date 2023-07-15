import 'dart:io';

import 'package:hermes_app/shared/utils/sql_utils.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseSqflite {
  static final DatabaseSqflite instance = DatabaseSqflite._init();
  static Database? _database;

  DatabaseSqflite._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    String databasesPath = await getDatabasesPath();
    String databaseName = "hermes.db";
    String path = "$databasesPath/$databaseName";
    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onOpen: (db) {},
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    for (int index = 1; index <= version; index++) {
      final file =
          await File('assets/migrations/migration_$index.sql').readAsString();

      final queries = SqlUtils.getMigrationQueries(file);

      for (String query in queries) {
        await db.execute(query);
      }
    }
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    for (int index = oldVersion; index <= newVersion; index++) {
      final file =
          await File('assets/migrations/migration_$index.sql').readAsString();

      final queries = SqlUtils.getMigrationQueries(file);

      for (String query in queries) {
        await db.execute(query);
      }
    }
  }
}
