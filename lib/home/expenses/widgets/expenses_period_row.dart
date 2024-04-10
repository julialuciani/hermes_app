import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/home/expenses/filters/expenses_screen_filters_cubit.dart';
import 'package:hermes_app/home/utils/fetch_movements_filters.dart';
import 'package:hermes_app/home/utils/period_group_enum.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:intl/intl.dart';

class ExpensesPeriodRow extends StatefulWidget {
  const ExpensesPeriodRow({super.key});

  @override
  State<ExpensesPeriodRow> createState() => _ExpensesPeriodRowState();
}

class _ExpensesPeriodRowState extends State<ExpensesPeriodRow> {
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
                final weekBegin = DateFormat('dd, MMM').format(state.dateStart);
                final weekEnd = DateFormat('dd, MMM').format(state.dateEnd);
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
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_left,
                ),
              ),
              Text(
                getTextByPeriodGroup(),
                style: typography.bold.medium,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_right),
              ),
            ],
          );
        });
  }
}
