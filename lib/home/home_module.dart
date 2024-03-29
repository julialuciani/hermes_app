import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/home/pages/home_page.dart';

import 'balance/get_all_movement_by_period_use_case.dart';
import 'balance/group_movement_use_case.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.factory<GroupMovementUseCase>(
          (i) => GroupMovementUseCase(),
        ),
        Bind.factory<GetAllMovementByPeriodUseCase>(
          (i) => GetAllMovementByPeriodUseCase(i(), i()),
        ),
      ];
  @override
  final List<ChildRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => const HomePage(),
    ),
  ];
}
