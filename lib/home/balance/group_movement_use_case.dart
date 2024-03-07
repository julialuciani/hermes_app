import 'package:hermes_app/home/balance/get_all_movement_by_period_use_case.dart';
import 'package:hermes_app/home/balance/model/balance_model.dart';
import 'package:hermes_app/shared/entities/movement_model.dart';

class GroupMovementUseCase {
  List<PeriodExtractModel> groupMovementsByPeriod(
    List<MovementModel> unGroupedMovement,
    Period period,
  ) {
    switch (period) {
      case Period.day:
        return groupMovementsByDay(unGroupedMovement);
      case Period.week:
        return groupMovementsByDay(unGroupedMovement);
      case Period.month:
        return groupMovementsByDay(unGroupedMovement);
      case Period.year:
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
        groupedMovement[movement.date!.day] = [movement];
      }
    }

    groupedMovement.forEach((key, value) {
      extract.add(
        PeriodExtractModel(
            title: key.toString(), //formatar
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

    Map<int, List<MovementModel>> groupedMovement = {};

    for (var movement in unGroupedMovement) {
      if (groupedMovement.containsKey(movement.date!.day)) {
        groupedMovement[movement.date!.day]!.add(movement);
      } else {
        groupedMovement[movement.date!.day] = [movement];
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
