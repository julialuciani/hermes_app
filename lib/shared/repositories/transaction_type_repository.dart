import 'package:hermes_app/shared/entities/transaction_type.dart';

import '../constants/tables.dart';
import '../database/idatabase.dart';
import 'base_repository.dart';

class TransactionTypeRepository extends BaseRepository<TransactionType> {
  final IDatabase _db;

  TransactionTypeRepository(this._db) : super(_db, Tables.transactionType);

  Future<List<TransactionType>> getAll() async {
    final result = await _db.getAll(Tables.transactionType);

    final transactionTypes =
        result.map((e) => TransactionType.fromMap(e)).toList();

    return transactionTypes;
  }
}
