import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/home/income/filters/income_filters_button.dart';
import 'package:hermes_app/home/income/filters/income_screen_filters_cubit.dart';
import 'package:hermes_app/home/income/income_cubit.dart';
import 'package:hermes_app/home/income/widgets/income_chart.dart';
import 'package:hermes_app/home/income/widgets/income_list.dart';
import 'package:hermes_app/home/income/widgets/income_period_row.dart';
import 'package:hermes_app/home/income/widgets/income_period_text.dart';
import 'package:hermes_app/home/utils/fetch_movements_filters.dart';
import 'package:hermes_app/home/widgets/home_drawer.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/utils/event_bus.dart';

class IncomeScreen extends StatefulWidget {
  const IncomeScreen({super.key});

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  final _incomeCubit = Modular.get<IncomeCubit>();
  final _incomeFiltersCubit = Modular.get<IncomeScreenFiltersCubit>();
  late FetchMovementsFilters _currentFilters;
  StreamSubscription<FetchMovementsFilters>? _filtersChangeListener;
  StreamSubscription<CreateMovement>? _createMovementListener;
  @override
  void initState() {
    super.initState();
    _incomeCubit.fetch(_incomeFiltersCubit.state);
    _filtersChangeListener = _incomeFiltersCubit.stream.listen((filters) {
      _incomeCubit.fetch(filters);
      setState(() {
        _currentFilters = filters;
      });
    });
    _createMovementListener = eventBus.on<CreateMovement>().listen((event) {
      _incomeCubit.fetch(_incomeFiltersCubit.state);
    });
    _currentFilters = _incomeFiltersCubit.state;
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
      drawer: const HomeDrawer(),
      appBar: AppBar(
        actions: const [IncomeFiltersButton()],
        iconTheme: IconThemeData(
          color: AppColors.black,
        ),
        backgroundColor: Colors.white12,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const IncomePeriodRow(),
            const SizedBox(height: 20),
            const IncomeChart(),
            const IncomePeriodText(),
            const SizedBox(height: 20),
            IncomeList(
              filterPeriodGroup: _currentFilters.periodGroup,
            ),
          ],
        ),
      ),
    );
  }
}
