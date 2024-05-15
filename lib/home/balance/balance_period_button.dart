import 'package:flutter/material.dart';
import 'package:hermes_app/home/balance/balance_filters_modal.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';

class BalancePeriodButton extends StatelessWidget {
  final String currentFilter;
  const BalancePeriodButton({
    required this.currentFilter,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => const BalanceFiltersModal(),
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
              Text(currentFilter),
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
