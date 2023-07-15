import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/home/home_page.dart';

class HomeModule extends Module {
  @override
  final List<ChildRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => const HomePage(),
    ),
  ];
}
