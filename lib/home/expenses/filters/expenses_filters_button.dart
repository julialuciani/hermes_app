import 'package:flutter/material.dart';
import 'package:hermes_app/home/expenses/filters/expenses_filters_modal.dart';
import 'package:hermes_app/home/utils/period_group_enum.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';

class ExpensesFiltersButton extends StatelessWidget {
  final PeriodGroup periodGroup;
  const ExpensesFiltersButton({
    super.key,
    required this.periodGroup,
  });

  @override
  Widget build(BuildContext context) {
    String getPeriodGroupText() {
      switch (periodGroup) {
        case PeriodGroup.day:
          return 'Dia';
        case PeriodGroup.week:
          return 'Semana';
        case PeriodGroup.month:
          return 'Mês';
        case PeriodGroup.year:
          return 'Ano';
        default:
          return '';
      }
    }

    return UnconstrainedBox(
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => const ExpensesFiltersModal(),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.black,
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.only(
            left: 25,
          ),
          margin: const EdgeInsets.only(right: 10),
          alignment: Alignment.center,
          width: 87,
          child: Row(
            children: [
              Text(getPeriodGroupText()),
              Icon(
                Icons.arrow_drop_down,
                color: AppColors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
