import 'package:flutter/material.dart';
import 'package:hermes_app/home/widgets/home_drawer.dart';

class InvestmentsScreen extends StatelessWidget {
  const InvestmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Investments'),
      ),
      drawer: const HomeDrawer(),
      body: Column(
        children: const [],
      ),
    );
  }
}
