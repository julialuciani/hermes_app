import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/home/balance/cubits/balance_screen_cubit.dart';
import 'package:hermes_app/home/utils/fetch_movements_filters.dart';
import 'package:hermes_app/home/utils/period_group_enum.dart';
import 'package:hermes_app/shared/utils/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/widgets/default_button/default_button.dart';
import 'package:hermes_app/shared/widgets/modal/modal.dart';
import 'package:hermes_app/shared/widgets/select/select.dart';

import 'cubits/balance_screen_filters_cubit.dart';

class BalanceFiltersModal extends StatefulWidget {
  const BalanceFiltersModal({
    super.key,
  });

  @override
  State<BalanceFiltersModal> createState() => _BalanceFiltersModalState();
}

class _BalanceFiltersModalState extends State<BalanceFiltersModal> {
  final balanceCubit = Modular.get<BalanceScreenCubit>();
  final filtersCubit = Modular.get<BalanceScreenFiltersCubit>();
  bool buttonEnabled = false;
  late FetchMovementsFilters state;

  @override
  void initState() {
    super.initState();
    state = filtersCubit.state;
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
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
              ),
              child: Text(
                'Período',
                style: typography.bold.extraLarge,
              ),
            ),
            const SizedBox(
              height: 36,
            ),
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
                  buttonEnabled = filtersCubit.state.periodGroup != selected;
                  state = state.copyWithPeriod(selected);
                });
              },
              selectedValue: state.periodGroup,
            ),
            const SizedBox(height: 30),
            DefaultButton(
              enabled: buttonEnabled,
              onPressed: () {
                filtersCubit.change(state);
                Modular.to.pop();
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
