import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/home/expenses/expenses_cubit.dart';
import 'package:hermes_app/home/expenses/filters/expenses_filters_button.dart';
import 'package:hermes_app/home/expenses/filters/expenses_screen_filters_cubit.dart';
import 'package:hermes_app/home/expenses/state/expenses_state.dart';
import 'package:hermes_app/home/expenses/widgets/expenses_period_row.dart';
import 'package:hermes_app/home/expenses/widgets/extract_period_text.dart';
import 'package:hermes_app/home/utils/fetch_movements_filters.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/utils/event_bus.dart';
import 'package:hermes_app/shared/utils/text_size.dart';
import 'package:hermes_app/shared/widgets/default_row/default_row.dart';
import 'package:hermes_app/shared/widgets/expandable_box/expandable_box.dart';

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
            const ExtractPeriodText(),
            const SizedBox(height: 20),
            BlocBuilder<ExpensesCubit, ExpensesState>(
              bloc: _expensesCubit,
              builder: (context, state) {
                if (state is ExpensesLoading) {
                  //TODO: create shimmer for it
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is ExpensesSuccess) {
                  final expensesModel = state.expenses;
                  return SizedBox(
                    height: 200,
                    child: ListView.separated(
                      itemCount: expensesModel.expenses.length,
                      itemBuilder: (context, index) {
                        final expenses = expensesModel.expenses[index];
                        return ExpandableBox(
                          title: Text(expenses.first.date.toString()),
                          children: expenses.map((expense) {
                            return DefaultRow(
                              title: expense.categoryName!,
                              value: "${expense.value!}",
                              textSize: TextSize.medium,
                            );
                          }).toList(),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 12);
                      },
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
