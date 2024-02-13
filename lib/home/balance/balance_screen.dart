import 'package:flutter/material.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/widgets/chart/chart.dart';
import 'package:hermes_app/shared/widgets/content_box/content_box.dart';
import 'package:hermes_app/shared/widgets/default_button/default_button.dart';
import 'package:hermes_app/shared/widgets/expandable_box/expandable_box.dart';
import 'package:hermes_app/shared/widgets/input/input.dart';
import 'package:hermes_app/shared/widgets/modal/modal.dart';
import 'package:hermes_app/shared/widgets/select/select.dart';

class BalanceScreen extends StatelessWidget {
  const BalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    return Scaffold(
      drawer: const Drawer(
        child: Icon(
          Icons.menu,
        ),
      ),
      appBar: AppBar(
        actions: [
          UnconstrainedBox(
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => const BalanceModal(),
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
                    const Text('Mês'),
                    Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        iconTheme: IconThemeData(
          color: AppColors.black,
        ),
        backgroundColor: Colors.white12,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_left,
                  ),
                ),
                const Text('Julho - 2023'),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_right),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 80,
              ),
              child: Center(
                child: Chart(
                  sections: [
                    ChartSection(
                      value: 50,
                      title: 'Ações',
                      icon: const Icon(Icons.airplanemode_active),
                      color: Colors.red,
                    ),
                    ChartSection(
                      value: 50,
                      title: 'Alimentos',
                      icon: const Icon(Icons.food_bank),
                      color: Colors.blue,
                    ),
                  ],
                  // innerContent: ,
                ),
              ),
            ),
            ContentBox(
              outsideLabel: 'Total do período',
              child: Column(
                children: const [
                  ExpandableRow(
                    title: 'Gastos',
                    value: 'R\$ 700,00',
                    textSize: TextSize.medium,
                  ),
                  ExpandableRow(
                    title: 'Entradas',
                    value: 'R\$ 1.000',
                    textSize: TextSize.medium,
                  ),
                  ExpandableRow(
                    title: 'Investimentos',
                    value: 'R\$ 100,00',
                    textSize: TextSize.medium,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            Text(
              'Extrato Diário',
              style: typography.bold.medium,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 22,
              ),
              child: ExpandableBox(
                  title: const Text(
                    '06/07/2023',
                  ),
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: const [
                        ExpandableRow(
                          title: 'Gastos',
                          value: 'R\$ 250,00',
                          textSize: TextSize.medium,
                        ),
                        ExpandableRow(
                          title: 'Alimentação',
                          value: 'R\$ 100,00',
                          textSize: TextSize.small,
                        ),
                        ExpandableRow(
                          title: 'Alimentação',
                          value: 'R\$ 100,00',
                          textSize: TextSize.small,
                        ),
                        ExpandableRow(
                          title: 'Alimentação',
                          value: 'R\$ 100,00',
                          textSize: TextSize.small,
                        ),
                        ExpandableRow(
                          title: 'Entradas',
                          value: 'R\$ 250,00',
                          textSize: TextSize.medium,
                        ),
                        ExpandableRow(
                          title: 'Investimentos',
                          value: 'R\$ 250,00',
                          textSize: TextSize.medium,
                        ),
                      ],
                    )
                  ]),
            ),
            const Padding(
              padding: EdgeInsets.only(
                top: 22,
                bottom: 22,
              ),
              child: ExpandableBox(
                title: Text('06/07/2023'),
                children: [
                  ExpandableRow(
                    title: 'Gastos',
                    value: 'R\$ 250,00',
                    textSize: TextSize.medium,
                  ),
                  ExpandableRow(
                    title: 'Entradas',
                    value: 'R\$ 250,00',
                    textSize: TextSize.medium,
                  ),
                  ExpandableRow(
                    title: 'Investimentos',
                    value: 'R\$ 250,00',
                    textSize: TextSize.medium,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BalanceModal extends StatefulWidget {
  const BalanceModal({
    super.key,
  });

  @override
  State<BalanceModal> createState() => _BalanceModalState();
}

class _BalanceModalState extends State<BalanceModal> {
  String selectedValue = '';
  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Modal(
      content: Column(
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
          Row(
            children: const [
              Expanded(
                child: Input(
                  label: 'From',
                ),
              ),
              SizedBox(
                width: 30,
              ),
              Expanded(
                child: Input(
                  label: 'To',
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          DefaultButton(
            onPressed: () {},
            title: const Text(
              'Aplicar',
            ),
          ),
        ],
      ),
    );
  }
}

class ExpandableRow extends StatelessWidget {
  final String title;
  final String value;
  final TextSize textSize;
  const ExpandableRow({
    Key? key,
    required this.title,
    required this.value,
    required this.textSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    TextStyle getTypography(TextSize size) {
      switch (size) {
        case TextSize.small:
          return typography.regular.small;
        case TextSize.medium:
          return typography.regular.medium;
        default:
          return typography.regular.small;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            title,
            style: getTypography(textSize),
          ),
          const Spacer(),
          Text(
            value,
            style: getTypography(textSize),
          ),
        ],
      ),
    );
  }
}

enum TextSize { small, medium }
