import 'package:hermes_app/home/balance/model/balance_model.dart';
import 'package:hermes_app/shared/entities/transaction_model.dart';
import 'package:hermes_app/shared/entities/transaction_type_model.dart';
import 'package:hermes_app/shared/repositories/transaction_repository.dart';
import 'package:hermes_app/shared/repositories/transaction_type_repository.dart';

class GetAllTransactionsByPeriodUseCase {
  final TransactionTypeRepository _repository;
  final TransactionRepository _transactionRepository;

  GetAllTransactionsByPeriodUseCase(
    this._repository,
    this._transactionRepository,
  );

  Future<List<TransactionModel>> getTransactionsByType(int? typeId) {
    final result = _transactionRepository.getByTypeId(typeId);
    return result;
  }

  Future<BalanceModel> call() async {
    final TransactionTypeModel expenses = await getTransactionType(
      'expenses',
    );
    final TransactionTypeModel income = await getTransactionType(
      'income',
    );
    final TransactionTypeModel investments = await getTransactionType(
      'investments',
    );

    final List<TransactionModel> expensesTransactions =
        await getTransactionsByType(expenses.id);

    final List<TransactionModel> incomeTransactions =
        await getTransactionsByType(income.id);

    final List<TransactionModel> investmentTransactions =
        await getTransactionsByType(investments.id);

    BalanceModel model = BalanceModel(
      expenses: expenses.copyWith(transactions: expensesTransactions),
      income: income.copyWith(transactions: incomeTransactions),
      investments: investments.copyWith(transactions: investmentTransactions),
    );

    return model;
  }

  Future<TransactionTypeModel> getTransactionType(String type) {
    final result = _repository.getByType(type);
    return result;
  }
}
