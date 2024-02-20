import 'package:hermes_app/shared/entities/not_found_error.dart';
import 'package:hermes_app/shared/entities/transaction_type_model.dart';

import '../constants/tables.dart';
import '../database/idatabase.dart';
import 'base_repository.dart';

class TransactionTypeRepository extends BaseRepository<TransactionTypeModel> {
  final IDatabase _db;

  TransactionTypeRepository(this._db) : super(_db, Tables.transactionType);

  Future<List<TransactionTypeModel>> getAll() async {
    final result = await _db.getAll(Tables.transactionType);

    final transactionTypes =
        result.map((e) => TransactionTypeModel.fromMap(e)).toList();

    return transactionTypes;
  }

  Future<TransactionTypeModel> getByType(String transactionType) async {
    final result = await _db.rawQuery(
        'SELECT * FROM ${Tables.transactionType} WHERE name = $transactionType');

    if (result.isEmpty) {
      throw NotFoundError(error: 'Não encontramos nenhum dado :(');
    } else {
      return TransactionTypeModel.fromMap(result.first);
    }
  }
}
