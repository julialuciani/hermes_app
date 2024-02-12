import 'package:flutter/material.dart';
import 'package:hermes_app/home/balance/balance_screen.dart';
import 'package:hermes_app/home/expenses/expenses_screen.dart';
import 'package:hermes_app/home/income/income_screen.dart';
import 'package:hermes_app/home/investments/investments_screen.dart';
import 'package:hermes_app/home/widgets/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;

  final List<Widget> pages = [
    const BalanceScreen(),
    const ExpensesScreen(),
    const IncomeScreen(),
    const InvestmentsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value ?? 0;
          });
        },
      ),
    );
  }
}
