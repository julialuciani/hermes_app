import 'package:flutter/widgets.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/widgets/default_button/default_button.dart';
import 'package:hermes_app/shared/widgets/modal/modal.dart';
import 'package:hermes_app/shared/widgets/select/select.dart';

class BalanceFiltersModal extends StatefulWidget {
  const BalanceFiltersModal({
    super.key,
  });

  @override
  State<BalanceFiltersModal> createState() => _BalanceFiltersModalState();
}

class _BalanceFiltersModalState extends State<BalanceFiltersModal> {
  String selectedValue = 'week';
  bool isButtonEnabled = false;
  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Modal(
      content: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                SelectData(value: 'day', label: 'Dia'),
                SelectData(value: 'week', label: 'Semana'),
                SelectData(value: 'month', label: 'Mês'),
                SelectData(value: 'year', label: 'Ano'),
              ],
              onPressed: (selected) {
                setState(() {
                  if (selectedValue == selected) {
                    selectedValue = '';
                  } else {
                    selectedValue = selected;
                  }
                });
              },
              selectedValue: selectedValue,
            ),
            const SizedBox(height: 30),
            // Row(
            //   children: const [
            //     Expanded(
            //       child: Input(
            //         label: 'From',
            //       ),
            //     ),
            //     SizedBox(
            //       width: 30,
            //     ),
            //     Expanded(
            //       child: Input(
            //         label: 'To',
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 28),
            DefaultButton(
              enabled: isButtonEnabled,
              onPressed: () {},
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
