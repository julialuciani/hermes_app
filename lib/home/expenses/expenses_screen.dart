import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/home/expenses/expenses_cubit.dart';
import 'package:hermes_app/home/expenses/expenses_screen_filters_cubit.dart';
import 'package:hermes_app/home/utils/fetch_movements_filters.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
      ),
      body: Container(),
    );
  }
}
