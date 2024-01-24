import 'package:flutter/material.dart';
import 'package:hermes_app/shared/widgets/dropdown/dropdown.dart';
import 'package:hermes_app/shared/widgets/dropdown/dropdown_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Dropdown(
              items: List.generate(
                5,
                (index) => DropdownItem(
                    description: "Item ${index + 1}", value: index),
              ),
              onChanged: (id) {},
            ),
          ),
        ],
      ),
    );
  }
}
