import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/home/expenses/expenses_cubit.dart';
import 'package:hermes_app/home/expenses/state/expenses_state.dart';
import 'package:hermes_app/home/extract/extract_dialog.dart';
import 'package:hermes_app/home/utils/mixin/format_date_time_by_period_group_mixin.dart';
import 'package:hermes_app/home/utils/period_group_enum.dart';
import 'package:hermes_app/shared/utils/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/utils/extensions/format_currency_extension.dart';
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
    with FormatDateTimeByPeriodGroupMixin {
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
                late String formattedDate;
                if (widget.filterPeriodGroup != PeriodGroup.year) {
                  formattedDate = DateFormat.MMMMEEEEd('pt_BR')
                      .format(expenses.first.date!);
                } else {
                  formattedDate = DateFormat('MMMM - MM/yyyy', 'pt_BR')
                      .format(expenses.first.date!);
                }
                return ExpandableBox(
                  title: Text(
                    formattedDate,
                    style: typography.regular.medium,
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
                      style: typography.regular.medium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  children: expenses.map((expense) {
                    return DefaultRow(
                      title: expense.categoryName!,
                      value: expense.value!.formatCurrency(),
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
