import 'package:hermes_app/home/utils/fetch_movements_filters.dart';
import 'package:hermes_app/home/utils/period_group_enum.dart';

extension GetTimePeriod on FetchMovementsFilters {
  DateTime getPreviousPeriodStart() {
    switch (periodGroup) {
      case PeriodGroup.day:
        return dateStart.subtract(const Duration(days: 1));
      case PeriodGroup.week:
        return dateStart.subtract(const Duration(days: 7));
      case PeriodGroup.month:
        return DateTime(dateStart.year, dateStart.month - 1, 1);
      case PeriodGroup.year:
        return DateTime(dateStart.year - 1, 1, 1);
      default:
        return dateStart;
    }
  }

  DateTime getPreviousPeriodEnd() {
    switch (periodGroup) {
      case PeriodGroup.day:
        return dateEnd.subtract(const Duration(days: 1));
      case PeriodGroup.week:
        return dateEnd.subtract(const Duration(days: 7));
      case PeriodGroup.month:
        final lastDay = DateTime(dateEnd.year, dateEnd.month, 0);
        final month = dateEnd.month - 1 > 0 ? dateEnd.month - 1 : 12;
        final year = month == 12 ? dateEnd.year - 1 : dateEnd.year;
        return DateTime(year, month, lastDay.day, 23, 59, 59, 999);
      case PeriodGroup.year:
        return DateTime(dateEnd.year - 1, 12, 31, 23, 59, 59, 999);
      default:
        return dateEnd;
    }
  }

  bool hasNextPeriod() {
    return dateEnd.isBefore(DateTime.now());
  }

  DateTime getNextPeriodStart() {
    switch (periodGroup) {
      case PeriodGroup.day:
        return dateStart.add(const Duration(days: 1));
      case PeriodGroup.week:
        return dateStart.add(const Duration(days: 7));
      case PeriodGroup.month:
        return DateTime(dateStart.year, dateStart.month + 1);
      case PeriodGroup.year:
        return DateTime(dateStart.year + 1);
      default:
        return dateStart;
    }
  }

  DateTime getNextPeriodEnd() {
    switch (periodGroup) {
      case PeriodGroup.day:
        return dateEnd.add(const Duration(days: 1));
      case PeriodGroup.week:
        return dateEnd.add(const Duration(days: 7));
      case PeriodGroup.month:
        return DateTime(dateEnd.year, dateEnd.month + 2, 0, 23, 59, 59, 999);
      case PeriodGroup.year:
        return DateTime(dateEnd.year + 1, 12, 31, 23, 59, 59, 999);
      default:
        return dateEnd;
    }
  }
}
