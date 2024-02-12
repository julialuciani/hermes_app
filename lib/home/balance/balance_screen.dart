import 'package:flutter/material.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/widgets/modal/modal.dart';
import 'package:hermes_app/shared/widgets/select/select.dart';

class BalanceScreen extends StatelessWidget {
  const BalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  showBottomSheet(
                    context: context,
                    builder: (context) => Modal(
                      content: Column(
                        children: [
                          const Text(
                            'Período',
                          ),
                          Select(
                            data: const [
                              SelectData(value: '1', label: 'Mês'),
                              SelectData(value: '1', label: 'Mês'),
                              SelectData(value: '1', label: 'Mês'),
                            ],
                            onPressed: (p0) {},
                            selectedValue: 'Mês',
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  margin: const EdgeInsets.only(right: 10),
                  alignment: Alignment.center,
                  width: 87,
                  child: Row(
                    children: const [
                      Text('Mês'),
                      Icon(
                        Icons.expand_more,
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
        body: Column(
          children: [
            Row(
              children: const [],
            ),
          ],
        ));
  }
}
