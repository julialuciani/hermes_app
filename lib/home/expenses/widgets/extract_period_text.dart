import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/home/expenses/filters/expenses_screen_filters_cubit.dart';
import 'package:hermes_app/home/utils/fetch_movements_filters.dart';
import 'package:hermes_app/home/widgets/extract_text_title.dart';

class ExtractPeriodText extends StatefulWidget {
  const ExtractPeriodText({super.key});

  @override
  State<ExtractPeriodText> createState() => _ExtractPeriodTextState();
}

class _ExtractPeriodTextState extends State<ExtractPeriodText> {
  final _expensesFiltersCubit = Modular.get<ExpensesScreenFiltersCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpensesScreenFiltersCubit, FetchMovementsFilters>(
      bloc: _expensesFiltersCubit,
      builder: (context, state) {
        return ExtractTextTitle(periodGroup: state.periodGroup);
      },
    );
  }
}
