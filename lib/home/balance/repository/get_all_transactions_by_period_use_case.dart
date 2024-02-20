import 'package:hermes_app/home/balance/model/balance_model.dart';
import 'package:hermes_app/shared/entities/transaction_type_model.dart';
import 'package:hermes_app/shared/repositories/transaction_type_repository.dart';

class GetAllTransactionsByPeriodUseCase {
  final TransactionTypeRepository _repository;

  GetAllTransactionsByPeriodUseCase(this._repository);

  // Future<List<TransactionModel>> getTransactionsByType(String typeId) {
  //   final result = _repository.getAll();
  // }

  Future<BalanceModel> getTransactionTypes() async {
    final TransactionTypeModel expenses = await getByTransactionType(
      'expenses',
    );
    final TransactionTypeModel income = await getByTransactionType(
      'income',
    );
    final TransactionTypeModel investments = await getByTransactionType(
      'investments',
    );

    return BalanceModel(
      expenses: expenses,
      income: income,
      investments: investments,
    );
  }

  Future<TransactionTypeModel> getByTransactionType(String type) {
    final result = _repository.getByType(type);
    return result;
  }
}
