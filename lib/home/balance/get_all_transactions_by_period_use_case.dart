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

  List<PeriodExtractModel> _groupTransactionsByPeriod(
    List<TransactionModel> nonGroupedTransactions,
    Period period,
  ) {
    switch (period) {
      case Period.day:
      case Period.week:
      case Period.month:
        //TODO: add function to groupTransactionsByDay
        break;
      case Period.year:
        //TODO: add function to groupTransactionByMonth
        break;
    }
  }

  List<PeriodExtractModel> groupTransactionsByDay(
    List<TransactionModel> nonGroupedTransactions,
  ) {
    List<PeriodExtractModel> extract = [];

    //1 - Agrupar as listas de transações com base no dia
    //2 - Passar por cada lista agrupada e realizar as transformações para ter o balance model
    //3 - Juntar o balance model com a lista de transações e adicionar na lista extract como um PeriodExtractModel

    Map<int, List<TransactionModel>> groupedTransactions = {};

    for (var transaction in nonGroupedTransactions) {
      if (groupedTransactions.containsKey(transaction.date!.day)) {
        groupedTransactions[transaction.date!.day]!.add(transaction);
      } else {
        groupedTransactions[transaction.date!.day] = [transaction];
      }
    }
  }

  // List<PeriodExtractModel> groupTransactionByMonth(
  //   List<TransactionModel> nonGroupedTransactions,
  // ) {}

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

enum Period { day, week, month, year }
