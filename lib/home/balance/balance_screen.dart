import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/home/balance/balance_period_button.dart';
import 'package:hermes_app/home/widgets/home_drawer.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/utils/text_size.dart';
import 'package:hermes_app/shared/widgets/chart/chart.dart';
import 'package:hermes_app/shared/widgets/content_box/content_box.dart';
import 'package:hermes_app/shared/widgets/default_row/default_row.dart';
import 'package:hermes_app/shared/widgets/expandable_box/expandable_box.dart';

import 'get_all_movement_by_period_use_case.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  final useCase = Modular.get<GetAllMovementByPeriodUseCase>();
  @override
  Widget build(BuildContext context) {
    useCase(Period.week);
    return Scaffold(
      drawer: const HomeDrawer(),
      appBar: AppBar(
        actions: const [
          BalancePeriodButton(),
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
            const PeriodRow(),
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 80,
              ),
              child: Center(
                child: BalanceChart(),
              ),
            ),
            const PeriodBalanceContentBox(),
            const SizedBox(height: 22),
            const DailyExtractText(),
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
                        DefaultRow(
                          title: 'Gastos',
                          value: 'R\$ 250,00',
                          textSize: TextSize.medium,
                        ),
                        DefaultRow(
                          title: 'Alimentação',
                          value: 'R\$ 100,00',
                          textSize: TextSize.small,
                        ),
                        DefaultRow(
                          title: 'Alimentação',
                          value: 'R\$ 100,00',
                          textSize: TextSize.small,
                        ),
                        DefaultRow(
                          title: 'Alimentação',
                          value: 'R\$ 100,00',
                          textSize: TextSize.small,
                        ),
                        DefaultRow(
                          title: 'Entradas',
                          value: 'R\$ 250,00',
                          textSize: TextSize.medium,
                        ),
                        DefaultRow(
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
                  DefaultRow(
                    title: 'Gastos',
                    value: 'R\$ 250,00',
                    textSize: TextSize.medium,
                  ),
                  DefaultRow(
                    title: 'Entradas',
                    value: 'R\$ 250,00',
                    textSize: TextSize.medium,
                  ),
                  DefaultRow(
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

class DailyExtractText extends StatelessWidget {
  const DailyExtractText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Text(
      'Extrato Diário',
      style: typography.bold.medium,
    );
  }
}

class PeriodBalanceContentBox extends StatelessWidget {
  const PeriodBalanceContentBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ContentBox(
      outsideLabel: 'Total do período',
      child: Column(
        children: const [
          DefaultRow(
            title: 'Gastos',
            value: 'R\$ 700,00',
            textSize: TextSize.medium,
          ),
          DefaultRow(
            title: 'Entradas',
            value: 'R\$ 1.000',
            textSize: TextSize.medium,
          ),
          DefaultRow(
            title: 'Investimentos',
            value: 'R\$ 100,00',
            textSize: TextSize.medium,
          ),
        ],
      ),
    );
  }
}

class BalanceChart extends StatelessWidget {
  const BalanceChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Chart(
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
    );
  }
}

class PeriodRow extends StatelessWidget {
  const PeriodRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
