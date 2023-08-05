import 'package:flutter/material.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int?) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black54,
              blurRadius: 15.0,
              offset: Offset(0.0, 0.75))
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        elevation: 30,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: AppColors.black,
        unselectedItemColor: AppColors.grey,
        unselectedIconTheme: IconThemeData(color: AppColors.grey, size: 30),
        selectedIconTheme: IconThemeData(color: AppColors.black, size: 30),
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          color: AppColors.grey,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            label: "Balance",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: "Expenses",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: "Income",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Investments",
          ),
        ],
      ),
    );
  }
}
