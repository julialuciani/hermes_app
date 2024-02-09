import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/home/widgets/bottom_nav_bar.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SizedBox(),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (newIndex) {
          if (newIndex == null) return;
          setState(() {
            _currentIndex = newIndex;
          });
        },
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Modular.to.pushNamed('/transaction/').then((result) {
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
