import 'package:hermes_app/shared/constants/tables.dart';
import 'package:hermes_app/shared/database/idatabase.dart';
import 'package:hermes_app/shared/entities/transaction_model.dart';
import 'package:hermes_app/shared/repositories/base_repository.dart';

class TransactionRepository extends BaseRepository<TransactionModel> {
  // ignore: unused_field
  final IDatabase _db;

  TransactionRepository(this._db) : super(_db, Tables.transaction);
}
