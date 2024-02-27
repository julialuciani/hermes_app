import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/home/balance/balance_screen.dart';
import 'package:hermes_app/home/expenses/expenses_screen.dart';
import 'package:hermes_app/home/income/income_screen.dart';
import 'package:hermes_app/home/investments/investments_screen.dart';
import 'package:hermes_app/home/widgets/bottom_nav_bar.dart';
import 'package:hermes_app/movement/movement_routes.dart';
import 'package:hermes_app/shared/database/idatabase.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final db = Modular.get<IDatabase>();

  int _selectedIndex = 0;

  final List<Widget> pages = [
    const BalanceScreen(),
    const ExpensesScreen(),
    const IncomeScreen(),
    const InvestmentsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // db.rawQuery('''SELECT * FROM ${Tables.movement} AS t
    //   JOIN ${Tables.category} ON t.categoryId = category.id
    //   WHERE category.movementTypeId = 1''').then(print);

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: (newIndex) {
          setState(() {
            _selectedIndex = newIndex;
          });
        },
      ),
      floatingActionButton: GestureDetector(
        key: const Key('create_new_movement_fab'),
        onTap: () {
          Modular.to.pushNamed(MovementRoutes.movement).then((result) {
            //TODO: figure it out what to do when come back, probably reload the page
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
