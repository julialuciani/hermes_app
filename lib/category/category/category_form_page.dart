import 'package:flutter/material.dart';
import 'package:hermes_app/shared/widgets/default_app_bar/default_app_bar.dart';

class CategoryFormPage extends StatelessWidget {
  const CategoryFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: DefaultAppBar(
        title: 'Categoria',
      ),
      body: Center(
        child: Text("Hello"),
      ),
    );
  }
}
