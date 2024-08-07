import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/home/utils/extensions/get_time_period.dart';
import 'package:hermes_app/home/utils/fetch_movements_filters.dart';
import 'package:hermes_app/home/utils/period_group_enum.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/utils/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/utils/string_extensions.dart';
import 'package:intl/intl.dart';

import 'cubits/balance_screen_filters_cubit.dart';

class BalancePeriodRow extends StatefulWidget {
  const BalancePeriodRow({super.key});

  @override
  State<BalancePeriodRow> createState() => _BalancePeriodRowState();
}

class _BalancePeriodRowState extends State<BalancePeriodRow> {
  final _balanceFiltersCubit = Modular.get<BalanceScreenFiltersCubit>();
  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    return BlocBuilder<BalanceScreenFiltersCubit, FetchMovementsFilters>(
      bloc: _balanceFiltersCubit,
      builder: (context, state) {
        String getTextByPeriodGroup() {
          switch (state.periodGroup) {
            case PeriodGroup.day:
              final dayFormat = DateFormat('dd/MM/yyyy', 'pt_BR');
              return dayFormat.format(state.dateStart);
            case PeriodGroup.week:
              final weekBegin =
                  DateFormat('dd/MM', 'pt_BR').format(state.dateStart);
              final weekEnd =
                  DateFormat('dd/MM', 'pt_BR').format(state.dateEnd);
              final year = state.dateStart.year == DateTime.now().year
                  ? ''
                  : state.dateStart.year.toString();
              return '$weekBegin - $weekEnd $year';
            case PeriodGroup.month:
              final monthFormat = DateFormat('MMMM - MM/yyyy', 'pt_BR');
              return monthFormat.format(state.dateStart).capitalize();
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
                _balanceFiltersCubit.change(
                  state.copyWith(
                    dateStart: state.getPreviousPeriodStart(),
                    dateEnd: state.getPreviousPeriodEnd(),
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
                if (!state.hasNextPeriod()) return;
                _balanceFiltersCubit.change(
                  state.copyWith(
                    dateStart: state.getNextPeriodStart(),
                    dateEnd: state.getNextPeriodEnd(),
                  ),
                );
              },
              icon: Icon(
                Icons.arrow_right,
                size: 28,
                color: state.hasNextPeriod() ? null : AppColors.grey,
              ),
            ),
          ],
        );
      },
    );
  }
}
