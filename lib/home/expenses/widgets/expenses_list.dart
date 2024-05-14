import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/home/expenses/expenses_cubit.dart';
import 'package:hermes_app/home/expenses/state/expenses_state.dart';
import 'package:hermes_app/home/extract/extract_dialog.dart';
import 'package:hermes_app/home/utils/period_group_enum.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/utils/string_extensions.dart';
import 'package:hermes_app/shared/utils/text_size.dart';
import 'package:hermes_app/shared/widgets/default_row/default_row.dart';
import 'package:hermes_app/shared/widgets/expandable_box/expandable_box.dart';
import 'package:intl/intl.dart';

class ExpensesList extends StatefulWidget {
  const ExpensesList({
    Key? key,
    required this.filterPeriodGroup,
  }) : super(key: key);

  final PeriodGroup filterPeriodGroup;

  @override
  State<ExpensesList> createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList>
    with _ExpensesListFormatMixin {
  final _expensesCubit = Modular.get<ExpensesCubit>();
  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    return BlocBuilder<ExpensesCubit, ExpensesState>(
      bloc: _expensesCubit,
      builder: (context, state) {
        if (state is ExpensesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ExpensesSuccess) {
          final expensesModel = state.expenses;
          return Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: expensesModel.expenses.length,
              itemBuilder: (context, index) {
                final expenses = expensesModel.expenses[index];
                return ExpandableBox(
                  title: Text(
                    formatDateTimeByPeriodGroup(
                      widget.filterPeriodGroup,
                      expenses.first.date!,
                    ),
                    style: typography.bold.medium,
                  ),
                  footer: GestureDetector(
                    onTap: () {
                      ExtractDialog.show(
                        context,
                        period: formatDateTimeByPeriodGroup(
                          widget.filterPeriodGroup,
                          expenses.first.date!,
                        ),
                        movements: expenses,
                      );
                    },
                    child: Text(
                      'Detalhes',
                      style: typography.bold.medium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  children: expenses.map((expense) {
                    return DefaultRow(
                      title: expense.categoryName!,
                      value: formatCurrency(expense.value!),
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

mixin _ExpensesListFormatMixin {
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

  String formatCurrency(double value) {
    final format = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return format.format(value);
  }
}
