import 'package:flutter/material.dart';
import 'package:hermes_app/shared/widgets/expansion_tile/expansion_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: const [
            ExpandableBox(
              title: Text(
                "06/07/2023",
              ),
              children: [
                Text("BB"),
                Text("BB"),
                Text("BB"),
                Text("BB"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
