import 'package:hermes_app/home/balance/model/balance_model.dart';
import 'package:hermes_app/shared/entities/movement_model.dart';
import 'package:hermes_app/shared/repositories/movement_repository.dart';
import 'package:intl/intl.dart';

import 'group_movement_use_case.dart';

class GetAllMovementByPeriodUseCase {
  final MovementRepository _repository;
  final GroupMovementUseCase _groupMovementsUseCase;

  GetAllMovementByPeriodUseCase(
    this._repository,
    this._groupMovementsUseCase,
  );

  Future<BalanceModel> call(Period period) async {
    final extract = _groupMovementsUseCase.groupMovementsByPeriod(
      await getAllMovements(),
      period,
    );
    return BalanceModel(
      movementTypesWithValue: getMovementTypesWithValue(extract),
      currentFilter: _getCurrentFilterName(period),
      extract: extract,
    );
  }

  TypesWithValue getMovementTypesWithValue(List<PeriodExtractModel> extract) {
    // Ele vau ter que passar por toda a lista de extrato
    //dentro dela terao as listas de movement model
    //para cada lista será adicionada uma key no map
    //ele vai adicionar os values de cada lista em cada key
    // depois ele irá somar o valor de cada lista

    Map<String, List<double>> periods = {};

    for (var period in extract) {
      for (var expense in period.expenses) {
        periods['expenses'] = [expense.value!];
      }

      for (var investment in period.investments) {
        periods['investments'] = [investment.value!];
      }

      for (var income in period.income) {
        periods['income'] = [income.value!];
      }
    }

    final investment = periods['investments']!.fold(
      0.0,
      (previousValue, element) => previousValue + element,
    );
    final expenses = periods['expenses']!.fold(
      0.0,
      (previousValue, element) => previousValue + element,
    );
    final income = periods['income']!.fold(
      0.0,
      (previousValue, element) => previousValue + element,
    );

    return TypesWithValue(
      expenses: ValueWithDescription(
          description: 'Gastos', formattedValue: formattAsCurrency(expenses)),
      investments: ValueWithDescription(
          description: 'Investimentos',
          formattedValue: formattAsCurrency(investment)),
      income: ValueWithDescription(
        description: 'Entradas',
        formattedValue: formattAsCurrency(income),
      ),
    );
  }

  String formattAsCurrency(double value) =>
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(value);

  String _getCurrentFilterName(Period period) {
    final month = _monthString(
      DateTime.now().month,
    );
    switch (period) {
      case Period.day:
        return '${DateTime.now().day} - $month - ${DateTime.now().year}';
      case Period.week:
        return 'não sei';
      case Period.month:
        return '$month - ${DateTime.now().year}';
      case Period.year:
        return DateTime.now().year.toString();
      default:
        return '';
    }
  }

  String _monthString(int month) {
    switch (month) {
      case 1:
        return 'Janeiro';
      case 2:
        return 'Fevereiro';
      case 3:
        return 'Março';
      case 4:
        return 'Abril';
      case 5:
        return 'Maio';
      case 6:
        return 'Junho';
      case 7:
        return 'Julho';
      case 8:
        return 'Agosto';
      case 9:
        return 'Setembro';
      case 10:
        return 'Outubro';
      case 11:
        return 'Novembro';
      case 12:
        return 'Dezembro';

      default:
        return '';
    }
  }

  Future<List<MovementModel>> getAllMovements() async {
    final result = await _repository.getAll();
    return result;
  }
}

enum Period { day, week, month, year }
