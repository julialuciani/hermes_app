import 'package:hermes_app/home/utils/period_group_enum.dart';
import 'package:hermes_app/shared/entities/nullable_model.dart';

class FetchMovementsFilters {
  final int? movementTypeId;
  final DateTime dateStart;
  final DateTime dateEnd;
  final int? categoryId;

  FetchMovementsFilters({
    this.movementTypeId,
    required this.dateStart,
    required this.dateEnd,
    this.categoryId,
  });

  PeriodGroup get periodGroup {
    final diff = dateEnd.difference(dateStart);
    if (diff.inDays <= 1) {
      return PeriodGroup.day;
    } else if (diff.inDays <= 7) {
      return PeriodGroup.week;
    } else if (diff.inDays <= 30) {
      return PeriodGroup.month;
    } else {
      return PeriodGroup.year;
    }
  }

  FetchMovementsFilters copyWith({
    int? movementTypeId,
    DateTime? dateStart,
    DateTime? dateEnd,
    Nullable<int?>? categoryId,
  }) {
    return FetchMovementsFilters(
      movementTypeId: movementTypeId ?? this.movementTypeId,
      dateStart: dateStart ?? this.dateStart,
      dateEnd: dateEnd ?? this.dateEnd,
      categoryId: categoryId != null ? categoryId.value : this.categoryId,
    );
  }

  FetchMovementsFilters copyWithPeriod(PeriodGroup periodGroup) {
    final now = DateTime.now();
    switch (periodGroup) {
      case PeriodGroup.day:
        return copyWith(
          dateStart: DateTime(now.year, now.month, now.day),
          dateEnd: DateTime(now.year, now.month, now.day, 23, 59, 59),
        );
      case PeriodGroup.week:
        final weekDay = now.weekday;
        final start = now.subtract(Duration(days: weekDay - 1));
        final end = now.add(Duration(days: 7 - weekDay));
        return copyWith(
          dateStart: DateTime(start.year, start.month, start.day),
          dateEnd: DateTime(end.year, end.month, end.day),
        );
      case PeriodGroup.month:
        return copyWith(
          dateStart: DateTime(now.year, now.month, 1),
          dateEnd: DateTime(now.year, now.month + 1, 0),
        );
      case PeriodGroup.year:
        return copyWith(
          dateStart: DateTime(now.year, 1, 1),
          dateEnd: DateTime(now.year, 12, 31),
        );
    }
  }
}
