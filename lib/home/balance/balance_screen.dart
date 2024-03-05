import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/home/balance/balance_screen_cubit.dart';
import 'package:hermes_app/home/balance/state/balance_screen_state.dart';
import 'package:hermes_app/shared/entities/movement_type_model.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/screen/default_loading_screen.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/utils/text_size.dart';
import 'package:hermes_app/shared/widgets/chart/chart.dart';
import 'package:hermes_app/shared/widgets/content_box/content_box.dart';
import 'package:hermes_app/shared/widgets/default_error_widget/default_error_widget.dart';
import 'package:hermes_app/shared/widgets/default_row/default_row.dart';
import 'package:hermes_app/shared/widgets/expandable_box/expandable_box.dart';

import 'balance_period_button.dart';
import 'get_all_movement_by_period_use_case.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  final balanceCubit = Modular.get<BalanceScreenCubit>();

  @override
  void initState() {
    balanceCubit.fetch(Period.week);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BalanceScreenCubit, BalanceScreenState>(
      bloc: balanceCubit,
      builder: (context, state) {
        if (state is BalanceScreenLoading) {
          return const DefaultLoadingScreen();
        }

        if (state is BalanceScreenError) {
          print(state.failure.error);
          print(state.failure.stackTrace);
          return DefaultErrorWidget(
            buttonLabel: 'Tentar novamente',
            description: 'Ocorreu um erro durante sua requisição',
            failure: state.failure,
            onPressed: () async {},
            title: 'Error',
          );
        }

        if (state is BalanceScreenSucess) {
          print(state.balance.currentFilter);
          print(state.balance.extract.);
          return Scaffold(
            drawer: const Drawer(
              child: Icon(
                Icons.menu,
              ),
            ),
            appBar: AppBar(
              actions: const [
                BalancePeriodButton(),
              ],
              iconTheme: IconThemeData(
                color: AppColors.black,
              ),
              backgroundColor: Colors.white12,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PeriodRow(
                    month: state.balance.currentFilter,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 80,
                    ),
                    child: Center(
                      child: BalanceChart(
                        movementTypes: [],
                      ),
                    ),
                  ),
                  const PeriodBalanceContentBox(typeModels: []),
                  const SizedBox(height: 22),
                  const DailyExtractText(),
                  ...state.balance.extract
                      .map(
                        (extract) => ExpandableBox(
                          title: Text(extract.title),
                          children: [
                            ...extract.expenses.map(
                              (e) => DefaultRow(
                                title: e.description ?? '',
                                textSize: TextSize.medium,
                                value: e.value.toString(),
                              ),
                            ),
                            ...extract.income.map(
                              (e) => DefaultRow(
                                title: e.description ?? '',
                                textSize: TextSize.medium,
                                value: e.value.toString(),
                              ),
                            ),
                            ...extract.investments.map(
                              (e) => DefaultRow(
                                title: e.description ?? '',
                                textSize: TextSize.medium,
                                value: e.value.toString(),
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList()
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class DailyExtractText extends StatelessWidget {
  const DailyExtractText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Text(
      'Extrato Diário',
      style: typography.bold.medium,
    );
  }
}

class PeriodBalanceContentBox extends StatelessWidget {
  final List<MovementTypeModel> typeModels;
  const PeriodBalanceContentBox({
    Key? key,
    required this.typeModels,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContentBox(
      outsideLabel: 'Total do período',
      child: Column(
        children: [
          ...typeModels.map(
            (e) => DefaultRow(
              title: e.name,
              value: e.getSumOfAllmovements,
              textSize: TextSize.medium,
            ),
          ),
        ],
      ),
    );
  }
}

class BalanceChart extends StatelessWidget {
  final List<MovementTypeModel> movementTypes;
  const BalanceChart({
    Key? key,
    required this.movementTypes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chart(
      sections: [
        ...movementTypes.map(
          (e) => ChartSection(
            value: double.parse(e.totalValue!),
            title: e.name,
            icon: const Icon(Icons.airplanemode_active),
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}

class PeriodRow extends StatelessWidget {
  final String month;
  const PeriodRow({
    Key? key,
    required this.month,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_left,
          ),
        ),
        Text(month),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_right),
        ),
      ],
    );
  }
}
