import 'package:hermes_app/shared/constants/tables.dart';
import 'package:hermes_app/shared/database/idatabase.dart';
import 'package:hermes_app/shared/entities/transaction_model.dart';
import 'package:hermes_app/shared/repositories/base_repository.dart';

class TransactionRepository extends BaseRepository<TransactionModel> {
  final IDatabase _db;

  TransactionRepository(this._db) : super(_db, Tables.transaction);

  Future<List<TransactionModel>> getByTypeId(int? typeId) async {
    final result = await _db.rawQuery(
      '''SELECT * FROM ${Tables.transaction}
      JOIN ${Tables.category} ON transaction.categoryId = category.id
      WHERE category.transactionTypeId = $typeId''',
    );

    return result.map((e) => TransactionModel.fromMap(e)).toList();
  }
}
