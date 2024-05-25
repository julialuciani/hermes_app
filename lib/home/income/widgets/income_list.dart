import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/home/extract/extract_dialog.dart';
import 'package:hermes_app/home/income/income_cubit.dart';
import 'package:hermes_app/home/income/state/income_state.dart';
import 'package:hermes_app/home/utils/period_group_enum.dart';
import 'package:hermes_app/shared/utils/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/utils/extensions/format_currency_extension.dart';
import 'package:hermes_app/shared/utils/string_extensions.dart';
import 'package:hermes_app/shared/utils/text_size.dart';
import 'package:hermes_app/shared/widgets/default_row/default_row.dart';
import 'package:hermes_app/shared/widgets/expandable_box/expandable_box.dart';
import 'package:intl/intl.dart';

class IncomeList extends StatefulWidget {
  const IncomeList({
    Key? key,
    required this.filterPeriodGroup,
  }) : super(key: key);

  final PeriodGroup filterPeriodGroup;

  @override
  State<IncomeList> createState() => _IncomeListState();
}

class _IncomeListState extends State<IncomeList> with _IncomeListFormatMixin {
  final _incomeCubit = Modular.get<IncomeCubit>();
  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    return BlocBuilder<IncomeCubit, IncomeState>(
      bloc: _incomeCubit,
      builder: (context, state) {
        if (state is IncomeLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is IncomeSuccess) {
          final incomeModel = state.income;
          return Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: incomeModel.incomes.length,
              itemBuilder: (context, index) {
                final incomes = incomeModel.incomes[index];
                return ExpandableBox(
                  title: Text(
                    formatDateTimeByPeriodGroup(
                      widget.filterPeriodGroup,
                      incomes.first.date!,
                    ),
                    style: typography.bold.medium,
                  ),
                  footer: GestureDetector(
                    onTap: () {
                      ExtractDialog.show(
                        context,
                        period: formatDateTimeByPeriodGroup(
                          widget.filterPeriodGroup,
                          incomes.first.date!,
                        ),
                        movements: incomes,
                      );
                    },
                    child: Text(
                      'Detalhes',
                      style: typography.bold.medium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  children: incomes.map((investment) {
                    return DefaultRow(
                      title: investment.categoryName!,
                      value: investment.value!.formatCurrency(),
                      textSize: TextSize.medium,
                    );
                  }).toList(),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 12);
              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

mixin _IncomeListFormatMixin {
  String formatDateTimeByPeriodGroup(PeriodGroup group, DateTime date) {
    switch (group) {
      case PeriodGroup.day:
      case PeriodGroup.week:
      case PeriodGroup.month:
        final format = DateFormat('dd/MM/yyyy', 'pt_BR');
        return format.format(date).capitalize();
      case PeriodGroup.year:
        final format = DateFormat('MMMM - MM/yyyy', 'pt_BR');
        return format.format(date).capitalize();
      default:
        return '';
    }
  }
}
