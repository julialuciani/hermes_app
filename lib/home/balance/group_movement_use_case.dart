import 'package:hermes_app/home/balance/model/balance_model.dart';
import 'package:hermes_app/home/utils/period_group_enum.dart';
import 'package:hermes_app/shared/entities/movement_model.dart';
import 'package:intl/intl.dart';

class GroupMovementUseCase {
  List<PeriodExtractModel> groupMovementsByPeriod(
    List<MovementModel> unGroupedMovement,
    PeriodGroup period,
  ) {
    switch (period) {
      case PeriodGroup.day:
        return groupMovementsByDay(unGroupedMovement);
      case PeriodGroup.week:
        return groupMovementsByDay(unGroupedMovement);
      case PeriodGroup.month:
        return groupMovementsByDay(unGroupedMovement);
      case PeriodGroup.year:
        return groupMovementByMonth(unGroupedMovement);
    }
  }

  List<PeriodExtractModel> groupMovementByMonth(
    List<MovementModel> unGroupedMovements,
  ) {
    List<PeriodExtractModel> extract = [];

    Map<int, List<MovementModel>> groupedMovement = {};

    for (var movement in unGroupedMovements) {
      if (groupedMovement.containsKey(movement.date!.month)) {
        groupedMovement[movement.date!.month]!.add(movement);
      } else {
        groupedMovement[movement.date!.month] = [movement];
      }
    }

    groupedMovement.forEach((key, value) {
      extract.add(
        PeriodExtractModel(
            title:
                DateFormat('MMMM - MM/yyyy', 'pt_BR').format(value.first.date!),
            income:
                value.where((element) => element.typeName == 'income').toList(),
            expenses: value
                .where((element) => element.typeName == 'expenses')
                .toList(),
            investments: value
                .where((element) => element.typeName == 'investments')
                .toList()),
      );
    });

    return extract;
  }

  List<PeriodExtractModel> groupMovementsByDay(
    List<MovementModel> unGroupedMovement,
  ) {
    List<PeriodExtractModel> extract = [];

    //1 - Agrupar as listas de transações com base no dia
    //2 - Passar por cada lista agrupada e realizar as transformações para ter o balance model
    //3 - Juntar o balance model com a lista de transações e adicionar na lista extract como um PeriodExtractModel

    Map<String, List<MovementModel>> groupedMovement = {};

    for (var movement in unGroupedMovement) {
      final String formattedDate =
          DateFormat.MMMMEEEEd('pt_BR').format(movement.date!);
      if (groupedMovement.containsKey(formattedDate)) {
        groupedMovement[formattedDate]!.add(movement);
      } else {
        groupedMovement[formattedDate] = [movement];
      }
    }

    groupedMovement.forEach((key, value) {
      extract.add(
        PeriodExtractModel(
          title: key.toString(),
          income:
              value.where((element) => element.typeName == 'income').toList(),
          expenses:
              value.where((element) => element.typeName == 'expenses').toList(),
          investments: value
              .where((element) => element.typeName == 'investments')
              .toList(),
        ),
      );
    });

    return extract;
  }
}
