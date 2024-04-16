import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/home/expenses/expenses_cubit.dart';
import 'package:hermes_app/home/expenses/state/expenses_state.dart';
import 'package:hermes_app/home/utils/period_group_enum.dart';
import 'package:hermes_app/shared/utils/text_size.dart';
import 'package:hermes_app/shared/widgets/default_row/default_row.dart';
import 'package:hermes_app/shared/widgets/expandable_box/expandable_box.dart';

class ExpensesList extends StatefulWidget {
  const ExpensesList({
    Key? key,
    required this.filterPeriodGroup,
  }) : super(key: key);

  final PeriodGroup filterPeriodGroup;

  @override
  State<ExpensesList> createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList> {
  final _expensesCubit = Modular.get<ExpensesCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpensesCubit, ExpensesState>(
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
          return Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(bottom: 100),
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
    );
  }
}
