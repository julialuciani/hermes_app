import 'package:flutter/material.dart';
import 'package:hermes_app/shared/widgets/default_button/default_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: DefaultButton(
        onPressed: () {},
        title: const Text('ola gostoso'),
      ),
    );
  }
}
