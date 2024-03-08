import 'package:flutter/material.dart';
import 'package:hermes_app/shared/widgets/default_app_bar/default_app_bar.dart';

class CategoryListingPage extends StatelessWidget {
  const CategoryListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: DefaultAppBar(
        title: 'Categorias',
      ),
      body: Center(
        child: Text("Júlia linda"),
      ),
    );
  }
}
