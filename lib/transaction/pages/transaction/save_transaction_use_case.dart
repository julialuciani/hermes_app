import 'package:hermes_app/shared/entities/transaction_model.dart';
import 'package:hermes_app/shared/repositories/transaction_repository.dart';

class SaveTransactionUseCase {
  final TransactionRepository _repository;

  SaveTransactionUseCase(
    this._repository,
  );

  Future<int> call(TransactionModel transaction) async {
    if (transaction.id != null) {
      await _repository.update(transaction);
      return transaction.id!;
    } else {
      return await _repository.insert(transaction);
    }
  }
}
