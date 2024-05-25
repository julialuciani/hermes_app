import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/home/income/filters/income_screen_filters_cubit.dart';
import 'package:hermes_app/home/utils/fetch_movements_filters.dart';
import 'package:hermes_app/home/utils/period_group_enum.dart';
import 'package:hermes_app/shared/utils/extensions/build_context_extensions.dart';

class IncomePeriodText extends StatefulWidget {
  const IncomePeriodText({super.key});

  @override
  State<IncomePeriodText> createState() => _IncomePeriodTextState();
}

class _IncomePeriodTextState extends State<IncomePeriodText> {
  final _incomeFiltersCubit = Modular.get<IncomeScreenFiltersCubit>();

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    return BlocBuilder<IncomeScreenFiltersCubit, FetchMovementsFilters>(
      bloc: _incomeFiltersCubit,
      builder: (context, state) {
        String getTextByPeriod() {
          switch (state.periodGroup) {
            case PeriodGroup.day:
            case PeriodGroup.week:
            case PeriodGroup.month:
              return 'Extrato diário';
            case PeriodGroup.year:
              return 'Extrato mensal';
          }
        }

        return Text(
          getTextByPeriod(),
          style: typography.bold.medium,
        );
      },
    );
  }
}
