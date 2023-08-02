import '../constants/tables.dart';
import '../database/idatabase.dart';
import '../entities/category.dart';
import 'base_repository.dart';

class CategoryRepository extends BaseRepository<Category> {
  // ignore: unused_field
  final IDatabase _db;

  CategoryRepository(this._db) : super(_db, Tables.category);
}
