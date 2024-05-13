import 'package:hermes_app/home/income/model/income_model.dart';
import 'package:hermes_app/home/utils/fetch_movements_filters.dart';
import 'package:hermes_app/home/utils/period_group_enum.dart';
import 'package:hermes_app/shared/entities/movement_model.dart';
import 'package:hermes_app/shared/repositories/movement_repository.dart';

class GetIncomeUseCase {
  final MovementRepository _repository;

  GetIncomeUseCase(this._repository);

  Future<IncomeModel> call(FetchMovementsFilters filters) async {
    final expenses = await _repository.fetch(filters);

    return IncomeModel(
      incomes: _groupByPeriod(filters.periodGroup, expenses),
      periodGroup: filters.periodGroup,
    );
  }

  List<List<MovementModel>> _groupByPeriod(
      PeriodGroup periodGroup, List<MovementModel> expenses) {
    final grouped = <List<MovementModel>>[];

    switch (periodGroup) {
      case PeriodGroup.day:
      case PeriodGroup.week:
      case PeriodGroup.month:
        final groupedByDay = <int, List<MovementModel>>{};
        for (var element in expenses) {
          final day = element.date!.day;
          if (groupedByDay.containsKey(day)) {
            groupedByDay[day]!.add(element);
          } else {
            groupedByDay[day] = [element];
          }
        }
        grouped.addAll(groupedByDay.values);
        break;
      case PeriodGroup.year:
        final groupedByYear = <int, List<MovementModel>>{};
        for (var element in expenses) {
          final year = element.date!.year;
          if (groupedByYear.containsKey(year)) {
            groupedByYear[year]!.add(element);
          } else {
            groupedByYear[year] = [element];
          }
        }
        grouped.addAll(groupedByYear.values);
        break;
    }

    return grouped;
  }
}
