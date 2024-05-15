import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/home/income/filters/income_screen_filters_cubit.dart';
import 'package:hermes_app/home/utils/fetch_movements_filters.dart';
import 'package:hermes_app/home/utils/period_group_enum.dart';
import 'package:hermes_app/shared/components/category_dropdown/category_dropdown.dart';
import 'package:hermes_app/shared/components/category_dropdown/category_dropdown_cubit.dart';
import 'package:hermes_app/shared/entities/nullable_model.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/widgets/default_button/default_button.dart';
import 'package:hermes_app/shared/widgets/modal/modal.dart';
import 'package:hermes_app/shared/widgets/select/select.dart';

class IncomeFiltersModal extends StatefulWidget {
  const IncomeFiltersModal({
    super.key,
  });

  @override
  State<IncomeFiltersModal> createState() => _IncomeFiltersModalState();
}

class _IncomeFiltersModalState extends State<IncomeFiltersModal> {
  final filtersCubit = Modular.get<IncomeScreenFiltersCubit>();
  final categoryDropdownCubit = Modular.get<CategoryDropdownCubit>();
  late FetchMovementsFilters state;
  @override
  void initState() {
    super.initState();
    state = filtersCubit.state;
    categoryDropdownCubit.fetch(1);
  }

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Modal(
      content: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Text(
              'Período',
              style: typography.bold.medium,
            ),
            const SizedBox(height: 6),
            Select(
              data: const [
                SelectData(value: PeriodGroup.day, label: 'Dia'),
                SelectData(value: PeriodGroup.week, label: 'Semana'),
                SelectData(value: PeriodGroup.month, label: 'Mês'),
                SelectData(value: PeriodGroup.year, label: 'Ano'),
              ],
              onPressed: (selected) {
                selected as PeriodGroup;
                setState(() {
                  state = state.copyWithPeriod(selected);
                });
              },
              selectedValue: state.periodGroup,
            ),
            const SizedBox(height: 30),
            CategoryDropdown(
              onChanged: (int? categoryId) {
                setState(() {
                  state = state.copyWith(categoryId: Nullable(categoryId));
                });
              },
              value: state.categoryId,
            ),
            const SizedBox(height: 30),
            DefaultButton(
              onPressed: () {
                filtersCubit.change(state);
                Navigator.of(context).pop();
              },
              title: const Text(
                'Aplicar',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
