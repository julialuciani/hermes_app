import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/home/balance/balance_screen.dart';
import 'package:hermes_app/home/expenses/expenses_screen.dart';
import 'package:hermes_app/home/income/income_screen.dart';
import 'package:hermes_app/home/investments/investments_screen.dart';
import 'package:hermes_app/home/widgets/bottom_nav_bar.dart';
import 'package:hermes_app/movement/movement_routes.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/utils/event_bus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late PageController _pageController;

  final List<Widget> pages = [
    const BalanceScreen(),
    const ExpensesScreen(),
    const IncomeScreen(),
    const InvestmentsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (newIndex) {
          setState(() {
            _selectedIndex = newIndex;
          });
        },
        children: pages,
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: (newIndex) {
          setState(() {
            _selectedIndex = newIndex;
          });
          _pageController.animateToPage(
            newIndex,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
      ),
      floatingActionButton: GestureDetector(
        key: const Key('create_new_movement_fab'),
        onTap: () {
          Modular.to.pushNamed(MovementRoutes.movement).then((result) {
            eventBus.fire(CreateMovement());
          });
        },
        child: Container(
          height: 60,
          width: 60,
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: AppColors.red,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.add,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
