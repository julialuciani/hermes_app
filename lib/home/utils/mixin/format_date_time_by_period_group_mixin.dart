import 'package:hermes_app/home/utils/period_group_enum.dart';
import 'package:hermes_app/shared/utils/string_extensions.dart';
import 'package:intl/intl.dart';

mixin FormatDateTimeByPeriodGroupMixin {
  String formatDateTimeByPeriodGroup(PeriodGroup group, DateTime date) {
    switch (group) {
      case PeriodGroup.day:
      case PeriodGroup.week:
      case PeriodGroup.month:
        final format = DateFormat('dd/MM/yyyy', 'pt_BR');
        return format.format(date).capitalize();
      case PeriodGroup.year:
        final format = DateFormat('MMMM - MM/yyyy', 'pt_BR');
        return format.format(date).capitalize();
      default:
        return '';
    }
  }
}
