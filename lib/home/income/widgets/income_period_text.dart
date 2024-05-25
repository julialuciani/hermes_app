import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/home/income/filters/income_screen_filters_cubit.dart';
import 'package:hermes_app/home/utils/fetch_movements_filters.dart';
import 'package:hermes_app/home/widgets/extract_text_title.dart';

class IncomePeriodText extends StatefulWidget {
  const IncomePeriodText({super.key});

  @override
  State<IncomePeriodText> createState() => _IncomePeriodTextState();
}

class _IncomePeriodTextState extends State<IncomePeriodText> {
  final _incomeFiltersCubit = Modular.get<IncomeScreenFiltersCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IncomeScreenFiltersCubit, FetchMovementsFilters>(
      bloc: _incomeFiltersCubit,
      builder: (context, state) {
        return ExtractTextTitle(
          periodGroup: state.periodGroup,
        );
      },
    );
  }
}
