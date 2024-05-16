import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/home/income/income_cubit.dart';
import 'package:hermes_app/home/income/state/income_state.dart';
import 'package:hermes_app/shared/widgets/chart/chart.dart';
import 'package:hermes_app/shared/widgets/chart/empty_state_chart.dart';

class IncomeChart extends StatefulWidget {
  const IncomeChart({super.key});

  @override
  State<IncomeChart> createState() => _IncomeChartState();
}

class _IncomeChartState extends State<IncomeChart> {
  final _incomeCubit = Modular.get<IncomeCubit>();
  final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
    decimalDigits: 2,
    symbol: "R\$ ",
    enableNegative: false,
    locale: 'pt_BR',
  );

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<IncomeCubit, IncomeState>(
      bloc: _incomeCubit,
      builder: (context, state) {
        if (state is IncomeSuccess) {
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
