import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/home/balance/balance_period_button.dart';
import 'package:hermes_app/home/balance/balance_screen_cubit.dart';
import 'package:hermes_app/home/balance/model/balance_model.dart';
import 'package:hermes_app/home/balance/state/balance_screen_state.dart';
import 'package:hermes_app/shared/entities/movement_type_model.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/screen/default_loading_screen.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/utils/event_bus.dart';
import 'package:hermes_app/shared/utils/text_size.dart';
import 'package:hermes_app/shared/widgets/chart/chart.dart';
import 'package:hermes_app/shared/widgets/content_box/content_box.dart';
import 'package:hermes_app/shared/widgets/default_error_widget/default_error_widget.dart';
import 'package:hermes_app/shared/widgets/default_row/default_row.dart';
import 'package:hermes_app/shared/widgets/default_title/default_title.dart';
import 'package:hermes_app/shared/widgets/expandable_box/expandable_box.dart';

import 'get_all_movement_by_period_use_case.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  final balanceCubit = Modular.get<BalanceScreenCubit>();
  StreamSubscription<CreateMovement>? subscription;

  @override
  void initState() {
    subscription = eventBus.on<CreateMovement>().listen((event) {
      balanceCubit.fetch(Period.week);
    });
    balanceCubit.fetch(Period.week);
    super.initState();
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  final useCase = Modular.get<GetAllMovementByPeriodUseCase>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BalanceScreenCubit, BalanceScreenState>(
      bloc: balanceCubit,
      builder: (context, state) {
        if (state is BalanceScreenLoading) {
          return const DefaultLoadingScreen();
        }

        if (state is BalanceScreenError) {
          return DefaultErrorWidget(
            buttonLabel: 'Tentar novamente',
            description: 'Ocorreu um erro durante sua requisição',
            failure: state.failure,
            onPressed: () async {},
            title: 'Error',
          );
        }

        if (state is BalanceScreenSucess) {
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
                  PeriodBalanceContentBox(
                    typesWithValue: state.balance.movementTypesWithValue,
                  ),
                  const SizedBox(height: 22),
                  const DailyExtractText(),
                  const SizedBox(height: 17),
                  ...state.balance.extract
                      .map(
                        (extract) => Padding(
                          padding: const EdgeInsets.only(
                            bottom: 18,
                          ),
                          child: ExpandableBox(
                            title: Text(extract.title),
                            children: [
                              if (extract.expenses.isNotEmpty)
                                const DefaultTitle(
                                  title: 'Gastos',
                                  textSize: TextSize.medium,
                                ),
                              ...extract.expenses.map(
                                (e) => DefaultRow(
                                  title: e.description ?? '',
                                  textSize: TextSize.medium,
                                  value: e.value.toString(),
                                ),
                              ),
                              if (extract.income.isNotEmpty)
                                const DefaultTitle(
                                  title: 'Entradas',
                                  textSize: TextSize.medium,
                                ),
                              ...extract.income.map(
                                (e) => DefaultRow(
                                  title: e.description ?? '',
                                  textSize: TextSize.medium,
                                  value: e.value.toString(),
                                ),
                              ),
                              if (extract.investments.isNotEmpty)
                                const DefaultTitle(
                                  title: 'Investimentos',
                                  textSize: TextSize.medium,
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
  final TypesWithValue typesWithValue;
  const PeriodBalanceContentBox({
    super.key,
    required this.typesWithValue,
  });

  @override
  Widget build(BuildContext context) {
    return ContentBox(
      outsideLabel: 'Total do período',
      child: Column(
        children: [
          DefaultRow(
            title: typesWithValue.expenses.description,
            value: typesWithValue.expenses.formattedValue,
            textSize: TextSize.medium,
          ),
          DefaultRow(
            title: typesWithValue.income.description,
            value: typesWithValue.income.formattedValue,
            textSize: TextSize.medium,
          ),
          DefaultRow(
            title: typesWithValue.investments.description,
            value: typesWithValue.investments.formattedValue,
            textSize: TextSize.medium,
          ),
        ],
      ),
    );
  }
}

class BalanceChart extends StatelessWidget {
  final List<MovementTypeModel> movementTypes;
  const BalanceChart({
    super.key,
    required this.movementTypes,
  });

  @override
  Widget build(BuildContext context) {
    return Chart(
      sections: [
        ...movementTypes.map(
          (e) => ChartSection(
            value: double.parse(e.totalValue!),
            title: e.name,
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
    super.key,
    required this.month,
  });

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
