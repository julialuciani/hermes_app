import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/home/expenses/filters/expenses_screen_filters_cubit.dart';
import 'package:hermes_app/home/utils/fetch_movements_filters.dart';
import 'package:hermes_app/home/utils/period_group_enum.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:intl/intl.dart';

class ExpensesPeriodRow extends StatefulWidget {
  const ExpensesPeriodRow({super.key});

  @override
  State<ExpensesPeriodRow> createState() => _ExpensesPeriodRowState();
}

class _ExpensesPeriodRowState extends State<ExpensesPeriodRow>
    with _ExpensesPeriodRowExtension {
  final _expensesFiltersCubit = Modular.get<ExpensesScreenFiltersCubit>();
  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    return BlocBuilder<ExpensesScreenFiltersCubit, FetchMovementsFilters>(
        bloc: _expensesFiltersCubit,
        builder: (context, state) {
          String getTextByPeriodGroup() {
            switch (state.periodGroup) {
              case PeriodGroup.day:
                final dayFormat = DateFormat('dd - MMMM - yyyy');
                return dayFormat.format(state.dateStart);
              case PeriodGroup.week:
                final weekBegin = DateFormat('dd MMM').format(state.dateStart);
                final weekEnd = DateFormat('dd MMM').format(state.dateEnd);
                final year = state.dateStart.year == DateTime.now().year
                    ? ''
                    : state.dateStart.year.toString();
                return '$weekBegin - $weekEnd $year';
              case PeriodGroup.month:
                final monthFormat = DateFormat('MMMM - yyyy');
                return monthFormat.format(state.dateStart);
              case PeriodGroup.year:
                return "${state.dateStart.year}";
              default:
                return '';
            }
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  _expensesFiltersCubit.change(
                    state.copyWith(
                      dateStart: getPreviousPeriodStart(state),
                      dateEnd: getPreviousPeriodEnd(state),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.arrow_left,
                  size: 28,
                ),
              ),
              Text(
                getTextByPeriodGroup(),
                style: typography.bold.medium,
              ),
              IconButton(
                onPressed: () {
                  if (!hasNextPeriod(state)) return;
                  _expensesFiltersCubit.change(
                    state.copyWith(
                      dateStart: getNextPeriodStart(state),
                      dateEnd: getNextPeriodEnd(state),
                    ),
                  );
                },
                icon: Icon(
                  Icons.arrow_right,
                  size: 28,
                  color: hasNextPeriod(state) ? null : AppColors.grey,
                ),
              ),
            ],
          );
        });
  }
}

mixin _ExpensesPeriodRowExtension {
  DateTime getPreviousPeriodStart(FetchMovementsFilters state) {
    switch (state.periodGroup) {
      case PeriodGroup.day:
        return state.dateStart.subtract(const Duration(days: 1));
      case PeriodGroup.week:
        return state.dateStart.subtract(const Duration(days: 7));
      case PeriodGroup.month:
        return DateTime(state.dateStart.year, state.dateStart.month - 1, 1);
      case PeriodGroup.year:
        return DateTime(state.dateStart.year - 1, 1, 1);
      default:
        return state.dateStart;
    }
  }

  DateTime getPreviousPeriodEnd(FetchMovementsFilters state) {
    switch (state.periodGroup) {
      case PeriodGroup.day:
        return state.dateEnd.subtract(const Duration(days: 1));
      case PeriodGroup.week:
        return state.dateEnd.subtract(const Duration(days: 7));
      case PeriodGroup.month:
        final lastDay = DateTime(state.dateEnd.year, state.dateEnd.month, 0);
        final month =
            state.dateEnd.month - 1 > 0 ? state.dateEnd.month - 1 : 12;
        final year = month == 12 ? state.dateEnd.year - 1 : state.dateEnd.year;
        return DateTime(year, month, lastDay.day, 23, 59, 59, 999);
      case PeriodGroup.year:
        return DateTime(state.dateEnd.year - 1, 12, 31, 23, 59, 59, 999);
      default:
        return state.dateEnd;
    }
  }

  bool hasNextPeriod(FetchMovementsFilters state) {
    return state.dateEnd.isBefore(DateTime.now());
  }

  DateTime getNextPeriodStart(FetchMovementsFilters state) {
    switch (state.periodGroup) {
      case PeriodGroup.day:
        return state.dateStart.add(const Duration(days: 1));
      case PeriodGroup.week:
        return state.dateStart.add(const Duration(days: 7));
      case PeriodGroup.month:
        return DateTime(state.dateStart.year, state.dateStart.month + 1);
      case PeriodGroup.year:
        return DateTime(state.dateStart.year + 1);
      default:
        return state.dateStart;
    }
  }

  DateTime getNextPeriodEnd(FetchMovementsFilters state) {
    switch (state.periodGroup) {
      case PeriodGroup.day:
        return state.dateEnd.add(const Duration(days: 1));
      case PeriodGroup.week:
        return state.dateEnd.add(const Duration(days: 7));
      case PeriodGroup.month:
        return DateTime(
            state.dateEnd.year, state.dateEnd.month + 2, 0, 23, 59, 59, 999);
      case PeriodGroup.year:
        return DateTime(state.dateEnd.year + 1, 12, 31, 23, 59, 59, 999);
      default:
        return state.dateEnd;
    }
  }
}
