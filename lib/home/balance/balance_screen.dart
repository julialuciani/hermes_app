import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/home/balance/cubits/balance_screen_cubit.dart';
import 'package:hermes_app/home/balance/cubits/balance_screen_filters_cubit.dart';
import 'package:hermes_app/home/balance/model/balance_model.dart';
import 'package:hermes_app/home/balance/state/balance_screen_state.dart';
import 'package:hermes_app/home/extract/extract_dialog.dart';
import 'package:hermes_app/home/utils/fetch_movements_filters.dart';
import 'package:hermes_app/home/widgets/extract_text_title.dart';
import 'package:hermes_app/home/widgets/home_drawer.dart';
import 'package:hermes_app/shared/entities/movement_model.dart';
import 'package:hermes_app/shared/screen/default_loading_screen.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/utils/event_bus.dart';
import 'package:hermes_app/shared/utils/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/utils/extensions/format_currency_extension.dart';
import 'package:hermes_app/shared/utils/text_size.dart';
import 'package:hermes_app/shared/widgets/chart/chart.dart';
import 'package:hermes_app/shared/widgets/chart/empty_state_chart.dart';
import 'package:hermes_app/shared/widgets/content_box/content_box.dart';
import 'package:hermes_app/shared/widgets/default_error_widget/default_error_widget.dart';
import 'package:hermes_app/shared/widgets/default_row/default_row.dart';
import 'package:hermes_app/shared/widgets/default_title/default_title.dart';
import 'package:hermes_app/shared/widgets/expandable_box/expandable_box.dart';

import '../utils/mixin/format_date_time_by_period_group_mixin.dart';
import 'balance_period_button.dart';
import 'balance_period_row.dart';
import 'get_all_movement_by_period_use_case.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen>
    with FormatDateTimeByPeriodGroupMixin {
  final balanceCubit = Modular.get<BalanceScreenCubit>();
  final filterCubit = Modular.get<BalanceScreenFiltersCubit>();
  StreamSubscription<FetchMovementsFilters>? _filterChangeListener;
  StreamSubscription<RefreshMovementsTabs>? _refreshMovementsTabs;

  @override
  void initState() {
    super.initState();

    balanceCubit.fetch(filterCubit.state);
    _filterChangeListener = filterCubit.stream.listen((filters) {
      balanceCubit.fetch(filters);
    });
    _refreshMovementsTabs = eventBus.on<RefreshMovementsTabs>().listen((event) {
      balanceCubit.fetch(filterCubit.state);
    });
  }

  @override
  void dispose() {
    _refreshMovementsTabs?.cancel();
    _filterChangeListener?.cancel();
    super.dispose();
  }

  final useCase = Modular.get<GetAllMovementByPeriodUseCase>();
  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
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
            onPressed: () async {
              balanceCubit.fetch(filterCubit.state);
            },
            title: 'Erro',
          );
        }

        if (state is BalanceScreenSucess) {
          return Scaffold(
            drawer: const HomeDrawer(),
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
                  const BalancePeriodRow(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 80,
                    ),
                    child: Center(
                      child: BalanceChart(
                        balanceScreenCubit: balanceCubit,
                        movementModels: state.balance.allMovements,
                      ),
                    ),
                  ),
                  PeriodBalanceContentBox(
                    typesWithValue: state.balance.movementTypesWithValue,
                  ),
                  const SizedBox(height: 22),
                  ExtractTextTitle(periodGroup: filterCubit.state.periodGroup),
                  const SizedBox(height: 17),
                  ...state.balance.extract
                      .map(
                        (extract) => Padding(
                          padding: const EdgeInsets.only(
                            bottom: 18,
                          ),
                          child: ExpandableBox(
                            title: Text(extract.title),
                            footer: GestureDetector(
                              onTap: () {
                                ExtractDialog.show(
                                  context,
                                  period: formatDateTimeByPeriodGroup(
                                    filterCubit.state.periodGroup,
                                    [
                                      if (extract.expenses.isNotEmpty)
                                        extract.expenses.first.date!,
                                      if (extract.income.isNotEmpty)
                                        extract.income.first.date!,
                                      if (extract.investments.isNotEmpty)
                                        extract.investments.first.date!,
                                    ].first,
                                  ),
                                  movements: [
                                    ...extract.expenses,
                                    ...extract.income,
                                    ...extract.investments,
                                  ],
                                );
                              },
                              child: Text(
                                'Detalhes',
                                style: typography.regular.medium,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            children: [
                              if (extract.expenses.isNotEmpty)
                                const DefaultTitle(
                                  title: 'Gastos',
                                  textSize: TextSize.medium,
                                ),
                              ...extract.expenses.map(
                                (e) => DefaultRow(
                                  title: e.description ?? e.categoryName!,
                                  textSize: TextSize.medium,
                                  value: e.value?.formatCurrency() ?? '0,00',
                                ),
                              ),
                              if (extract.income.isNotEmpty)
                                const DefaultTitle(
                                  title: 'Entradas',
                                  textSize: TextSize.medium,
                                ),
                              ...extract.income.map(
                                (e) => DefaultRow(
                                  title: e.description ?? e.categoryName!,
                                  textSize: TextSize.medium,
                                  value: e.value?.formatCurrency() ?? '0,00',
                                ),
                              ),
                              if (extract.investments.isNotEmpty)
                                const DefaultTitle(
                                  title: 'Investimentos',
                                  textSize: TextSize.medium,
                                ),
                              ...extract.investments.map(
                                (e) => DefaultRow(
                                  title: e.description ?? e.categoryName!,
                                  textSize: TextSize.medium,
                                  value: e.value?.formatCurrency() ?? '0,00',
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
  final List<MovementModel> movementModels;
  final BalanceScreenCubit balanceScreenCubit;
  const BalanceChart({
    super.key,
    required this.balanceScreenCubit,
    required this.movementModels,
  });

  @override
  Widget build(BuildContext context) {
    Color getTypeColor(int typeId) {
      switch (typeId) {
        case 1:
          return Colors.green;
        case 2:
          return AppColors.red;
        case 3:
          return AppColors.blue;
        default:
          return AppColors.grey;
      }
    }

    return BlocBuilder<BalanceScreenCubit, BalanceScreenState>(
      bloc: balanceScreenCubit,
      builder: (context, state) {
        if (state is BalanceScreenSucess) {
          if (state.balance.allMovements.isEmpty) {
            return const EmptyStateChart();
          }

          return Chart(
            sections: [
              ...movementModels.map(
                (e) => ChartSection(
                  value: e.value ?? 0,
                  title: e.categoryName ?? '',
                  color: getTypeColor(e.typeId ?? 0),
                ),
              ),
            ],
          );
        }

        return const Offstage();
      },
    );
  }
}
