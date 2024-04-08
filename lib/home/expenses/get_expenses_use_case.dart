import 'package:hermes_app/home/expenses/model/expenses_model.dart';
import 'package:hermes_app/home/utils/fetch_movements_filters.dart';
import 'package:hermes_app/shared/repositories/movement_repository.dart';

class GetExpensesUseCase {
  final MovementRepository _repository;

  GetExpensesUseCase(this._repository);

  Future<ExpensesModel> call(FetchMovementsFilters filters) async {
    final expenses = await _repository.fetch(filters);
    return ExpensesModel(
      expenses: expenses,
      periodGroup: _getPeriodGroupByDateDiff(
        filters.dateStart,
        filters.dateEnd,
      ),
    );
  }

  ExpensePeriodGroup _getPeriodGroupByDateDiff(DateTime start, DateTime end) {
    final diff = end.difference(start);
    if (diff.inDays <= 1) {
      return ExpensePeriodGroup.day;
    } else if (diff.inDays <= 7) {
      return ExpensePeriodGroup.week;
    } else if (diff.inDays <= 30) {
      return ExpensePeriodGroup.month;
    } else {
      return ExpensePeriodGroup.year;
    }
  }
}
