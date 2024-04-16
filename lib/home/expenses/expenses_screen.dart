import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/home/expenses/expenses_cubit.dart';
import 'package:hermes_app/home/expenses/filters/expenses_filters_button.dart';
import 'package:hermes_app/home/expenses/filters/expenses_screen_filters_cubit.dart';
import 'package:hermes_app/home/expenses/widgets/expenses_period_row.dart';
import 'package:hermes_app/home/utils/fetch_movements_filters.dart';
import 'package:hermes_app/home/utils/period_group_enum.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/utils/event_bus.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final _expensesCubit = Modular.get<ExpensesCubit>();
  final _expensesFiltersCubit = Modular.get<ExpensesScreenFiltersCubit>();
  StreamSubscription<FetchMovementsFilters>? _filtersChangeListener;
  StreamSubscription<CreateMovement>? _createMovementListener;
  @override
  void initState() {
    super.initState();
    _expensesCubit.fetch(_expensesFiltersCubit.state);
    _filtersChangeListener = _expensesFiltersCubit.stream.listen((filters) {
      _expensesCubit.fetch(filters);
    });
    _createMovementListener = eventBus.on<CreateMovement>().listen((event) {
      _expensesCubit.fetch(_expensesFiltersCubit.state);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _filtersChangeListener?.cancel();
    _createMovementListener?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Scaffold(
      appBar: AppBar(
        actions: const [ExpensesFiltersButton()],
        iconTheme: IconThemeData(
          color: AppColors.black,
        ),
        backgroundColor: Colors.white12,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ExpensesPeriodRow(),
            const SizedBox(height: 40),
            _ExtractPeriodText(),
          ],
        ),
      ),
    );
  }
}

class _ExtractPeriodText extends StatefulWidget {
  @override
  State<_ExtractPeriodText> createState() => _ExtractPeriodTextState();
}

class _ExtractPeriodTextState extends State<_ExtractPeriodText> {
  final _expensesFiltersCubit = Modular.get<ExpensesScreenFiltersCubit>();

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    return BlocBuilder<ExpensesScreenFiltersCubit, FetchMovementsFilters>(
      bloc: _expensesFiltersCubit,
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
