import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/home/investments/filters/investments_filters_button.dart';
import 'package:hermes_app/home/investments/filters/investments_screen_filters_cubit.dart';
import 'package:hermes_app/home/investments/investments_cubit.dart';
import 'package:hermes_app/home/investments/widgets/investments_chart.dart';
import 'package:hermes_app/home/investments/widgets/investments_list.dart';
import 'package:hermes_app/home/investments/widgets/investments_period_row.dart';
import 'package:hermes_app/home/investments/widgets/investments_period_text.dart';
import 'package:hermes_app/home/utils/fetch_movements_filters.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/utils/event_bus.dart';

class InvestmentsScreen extends StatefulWidget {
  const InvestmentsScreen({super.key});

  @override
  State<InvestmentsScreen> createState() => _InvestmentsScreenState();
}

class _InvestmentsScreenState extends State<InvestmentsScreen> {
  final _investmentsCubit = Modular.get<InvestmentsCubit>();
  final _investmentsFiltersCubit = Modular.get<InvestmentsScreenFiltersCubit>();
  late FetchMovementsFilters _currentFilters;
  StreamSubscription<FetchMovementsFilters>? _filtersChangeListener;
  StreamSubscription<CreateMovement>? _createMovementListener;
  @override
  void initState() {
    super.initState();
    _investmentsCubit.fetch(_investmentsFiltersCubit.state);
    _filtersChangeListener = _investmentsFiltersCubit.stream.listen((filters) {
      _investmentsCubit.fetch(filters);
      setState(() {
        _currentFilters = filters;
      });
    });
    _createMovementListener = eventBus.on<CreateMovement>().listen((event) {
      _investmentsCubit.fetch(_investmentsFiltersCubit.state);
    });
    _currentFilters = _investmentsFiltersCubit.state;
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
      appBar: AppBar(
        actions: const [InvestmentsFiltersButton()],
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
            const InvestmentsPeriodRow(),
            const SizedBox(height: 20),
            const InvestmentsChart(),
            const InvestmentsPeriodText(),
            const SizedBox(height: 20),
            InvestmentsList(
              filterPeriodGroup: _currentFilters.periodGroup,
            ),
          ],
        ),
      ),
    );
  }
}
