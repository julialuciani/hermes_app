import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/home/investments/filters/investments_screen_filters_cubit.dart';
import 'package:hermes_app/home/utils/fetch_movements_filters.dart';
import 'package:hermes_app/home/widgets/extract_text_title.dart';

class InvestmentsPeriodText extends StatefulWidget {
  const InvestmentsPeriodText({super.key});

  @override
  State<InvestmentsPeriodText> createState() => _InvestmentsPeriodTextState();
}

class _InvestmentsPeriodTextState extends State<InvestmentsPeriodText> {
  final _investmentsFiltersCubit = Modular.get<InvestmentsScreenFiltersCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvestmentsScreenFiltersCubit, FetchMovementsFilters>(
      bloc: _investmentsFiltersCubit,
      builder: (context, state) {
        return ExtractTextTitle(periodGroup: state.periodGroup);
      },
    );
  }
}
