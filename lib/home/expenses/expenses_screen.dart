import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/home/expenses/expenses_cubit.dart';
import 'package:hermes_app/home/expenses/filters/expenses_filters_button.dart';
import 'package:hermes_app/home/expenses/filters/expenses_screen_filters_cubit.dart';
import 'package:hermes_app/home/expenses/widgets/expenses_chart.dart';
import 'package:hermes_app/home/expenses/widgets/expenses_list.dart';
import 'package:hermes_app/home/expenses/widgets/expenses_period_row.dart';
import 'package:hermes_app/home/expenses/widgets/extract_period_text.dart';
import 'package:hermes_app/home/utils/fetch_movements_filters.dart';
import 'package:hermes_app/home/widgets/home_drawer.dart';
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
  late FetchMovementsFilters _currentFilters;
  StreamSubscription<FetchMovementsFilters>? _filtersChangeListener;
  StreamSubscription<RefreshMovementsTabs>? _updateMovementListener;
  @override
  void initState() {
    super.initState();
    _expensesCubit.fetch(_expensesFiltersCubit.state);
    _filtersChangeListener = _expensesFiltersCubit.stream.listen((filters) {
      _expensesCubit.fetch(filters);
      setState(() {
        _currentFilters = filters;
      });
    });
    _updateMovementListener =
        eventBus.on<RefreshMovementsTabs>().listen((event) {
      _expensesCubit.fetch(_expensesFiltersCubit.state);
    });
    _currentFilters = _expensesFiltersCubit.state;
  }

  @override
  void dispose() {
    super.dispose();
    _filtersChangeListener?.cancel();
    _updateMovementListener?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HomeDrawer(),
      appBar: AppBar(
        actions: const [ExpensesFiltersButton()],
        iconTheme: IconThemeData(
          color: AppColors.black,
        ),
        backgroundColor: Colors.white12,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ExpensesPeriodRow(),
            const SizedBox(height: 20),
            const ExpensesChart(),
            const ExtractPeriodText(),
            const SizedBox(height: 20),
            ExpensesList(
              filterPeriodGroup: _currentFilters.periodGroup,
            ),
          ],
        ),
      ),
    );
  }
}
