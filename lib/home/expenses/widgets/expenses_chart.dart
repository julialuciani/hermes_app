import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/home/expenses/expenses_cubit.dart';
import 'package:hermes_app/home/expenses/state/expenses_state.dart';
import 'package:hermes_app/shared/widgets/chart/chart.dart';
import 'package:hermes_app/shared/widgets/chart/empty_state_chart.dart';

class ExpensesChart extends StatefulWidget {
  const ExpensesChart({super.key});

  @override
  State<ExpensesChart> createState() => _ExpensesChartState();
}

class _ExpensesChartState extends State<ExpensesChart> {
  final _expensesCubit = Modular.get<ExpensesCubit>();
  final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
    decimalDigits: 2,
    symbol: "R\$ ",
    enableNegative: false,
    locale: 'pt_BR',
  );

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<ExpensesCubit, ExpensesState>(
      bloc: _expensesCubit,
      builder: (context, state) {
        if (state is ExpensesSuccess) {
          if (state.chartModel.sections.isEmpty) return const EmptyStateChart();

          return SizedBox(
            height: height * 0.25,
            child: Center(
              child: Chart(
                sections: state.chartModel.sections,
                innerContent: _formatter.formatDouble(state.chartModel.total),
              ),
            ),
          );
        }
        return const Offstage();
      },
    );
  }
}
