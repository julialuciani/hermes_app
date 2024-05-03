import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/home/investments/filters/investments_filters_modal.dart';
import 'package:hermes_app/home/investments/filters/investments_screen_filters_cubit.dart';
import 'package:hermes_app/home/utils/fetch_movements_filters.dart';
import 'package:hermes_app/home/utils/period_group_enum.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';

class InvestmentsFiltersButton extends StatefulWidget {
  const InvestmentsFiltersButton({super.key});

  @override
  State<InvestmentsFiltersButton> createState() =>
      _InvestmentsFiltersButtonState();
}

class _InvestmentsFiltersButtonState extends State<InvestmentsFiltersButton> {
  final _expensesFiltersCubit = Modular.get<InvestmentsScreenFiltersCubit>();
  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    return BlocBuilder<InvestmentsScreenFiltersCubit, FetchMovementsFilters>(
        bloc: _expensesFiltersCubit,
        builder: (context, state) {
          String getPeriodGroupText() {
            switch (state.periodGroup) {
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
                  builder: (context) => const InvestmentsFiltersModal(),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                margin: const EdgeInsets.only(right: 10),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 18),
                    Text(
                      getPeriodGroupText(),
                      style: typography.regular.medium.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.white,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
