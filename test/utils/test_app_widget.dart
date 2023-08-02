import 'package:flutter/material.dart';

class TestAppWidget extends StatelessWidget {
  final Widget child;
  const TestAppWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MediaQuery(
        data: const MediaQueryData(),
        child: Scaffold(body: child),
      ),
    );
  }
}
