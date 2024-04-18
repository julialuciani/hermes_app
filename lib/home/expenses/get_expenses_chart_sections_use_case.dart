import 'package:hermes_app/home/expenses/model/expenses_model.dart';
import 'package:hermes_app/home/utils/fetch_movements_filters.dart';
import 'package:hermes_app/shared/entities/movement_model.dart';
import 'package:hermes_app/shared/repositories/movement_repository.dart';
import 'package:hermes_app/shared/widgets/chart/chart.dart';

class GetExpensesChartSectionsUseCase {
  final MovementRepository _repository;

  GetExpensesChartSectionsUseCase(this._repository);

  Future<ExpensesChartModel> call(FetchMovementsFilters filters) async {
    final movements = await _repository.fetch(filters);
    final sections = <ChartSection>[];

    Map<int, List<MovementModel>> groupedByCategory = {};

    for (var movement in movements) {
      if (groupedByCategory.containsKey(movement.categoryId)) {
        groupedByCategory[movement.categoryId]!.add(movement);
      } else {
        groupedByCategory[movement.categoryId!] = [movement];
      }
    }

    for (var categoryId in groupedByCategory.keys) {
      final categoryMovements = groupedByCategory[categoryId]!;
      final total = categoryMovements.fold<double>(
        0,
        (previousValue, element) => previousValue + element.value!,
      );

      final firstItem = categoryMovements.first;
      final category = firstItem.categoryName!;
      final color = firstItem.categoryColor!;

      sections.add(
        ChartSection(
          title: category,
          value: total,
          color: color,
        ),
      );
    }

    return ExpensesChartModel(sections: sections);
  }
}
