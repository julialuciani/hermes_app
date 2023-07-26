import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/tables.dart';
import '../database/idatabase.dart';
import '../entities/category.dart';
import 'base_repository.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>(
  (ref) => CategoryRepository(
    ref.watch(databaseProvider),
  ),
);

class CategoryRepository extends BaseRepository<Category> {
  // ignore: unused_field
  final IDatabase _db;

  CategoryRepository(this._db) : super(_db, Tables.category);
}
