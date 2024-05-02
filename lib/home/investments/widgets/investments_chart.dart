import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/home/investments/investments_cubit.dart';
import 'package:hermes_app/home/investments/state/investments_state.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/widgets/chart/chart.dart';

class InvestmentsChart extends StatefulWidget {
  const InvestmentsChart({super.key});

  @override
  State<InvestmentsChart> createState() => _InvestmentsChartState();
}

class _InvestmentsChartState extends State<InvestmentsChart> {
  final _investmentsCubit = Modular.get<InvestmentsCubit>();
  final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
    decimalDigits: 2,
    symbol: "R\$ ",
    enableNegative: false,
    locale: 'pt_BR',
  );

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<InvestmentsCubit, InvestmentsState>(
      bloc: _investmentsCubit,
      builder: (context, state) {
        if (state is InvestmentsSuccess) {
          if (state.chartModel.sections.isEmpty) return _EmptyStateChart();

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

class _EmptyStateChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final typography = context.typography;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: height * 0.25,
              width: height * 0.25,
              child: CircularProgressIndicator(
                value: 0,
                backgroundColor: AppColors.lightGrey,
                strokeWidth: 12,
              ),
            ),
            Text(
              'Sem dados para exibir',
              style: typography.bold.medium.copyWith(
                color: AppColors.darkGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
