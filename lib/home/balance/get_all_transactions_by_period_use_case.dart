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
        return groupTransactionsByDay(nonGroupedTransactions);
      case Period.week:
        return groupTransactionsByDay(nonGroupedTransactions);
      case Period.month:
        return groupTransactionsByDay(nonGroupedTransactions);
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

    groupedTransactions.forEach((key, value) {
      extract.add(
        PeriodExtractModel(
          title: key.toString(),
          balance: BalanceModel(
            income:
                value.where((element) => element.typeName == 'income').toList(),
            expenses: value
                .where((element) => element.typeName == 'expenses')
                .toList(),
            investments: value
                .where((element) => element.typeName == 'investments')
                .toList(),
          ),
        ),
      );
    });

    return extract;
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

    final model = BalanceModel(
      expenses: expensesTransactions,
      income: incomeTransactions,
      investments: investmentTransactions,
    );

    return model;
  }

  Future<TransactionTypeModel> getTransactionType(String type) {
    final result = _repository.getByType(type);
    return result;
  }
}

enum Period { day, week, month, year }
