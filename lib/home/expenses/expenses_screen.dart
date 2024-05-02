import 'package:flutter/material.dart';
import 'package:hermes_app/home/widgets/home_drawer.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
      ),
      drawer: const HomeDrawer(),
      body: Container(),
    );
  }
}
