import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/home/home_module.dart';
import 'package:hermes_app/shared/database/idatabase.dart';
import 'package:hermes_app/shared/repositories/category_repository.dart';

class AppModule extends Module {
  @override
  final List<Bind<Object>> binds = [
    Bind.factory<IDatabase>(
      (i) => DatabaseImp(),
    ),
    Bind.factory<CategoryRepository>(
      (i) => CategoryRepository(i()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(
      '/',
      module: HomeModule(),
    ),
  ];
}
