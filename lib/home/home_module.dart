import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/home/balance/balance_screen_cubit.dart';
import 'package:hermes_app/home/expenses/get_expenses_chart_sections_use_case.dart';
import 'package:hermes_app/home/expenses/get_expenses_use_case.dart';
import 'package:hermes_app/home/pages/home_page.dart';

import 'balance/get_all_movement_by_period_use_case.dart';
import 'balance/group_movement_use_case.dart';
import 'expenses/expenses_cubit.dart';
import 'expenses/filters/expenses_screen_filters_cubit.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        //UseCases
        Bind.factory<GroupMovementUseCase>(
          (i) => GroupMovementUseCase(),
        ),
        Bind.factory<GetAllMovementByPeriodUseCase>(
          (i) => GetAllMovementByPeriodUseCase(i(), i()),
        ),
        Bind.factory<GetExpensesUseCase>(
          (i) => GetExpensesUseCase(i()),
        ),
        Bind.factory<GetExpensesChartSectionsUseCase>(
          (i) => GetExpensesChartSectionsUseCase(i()),
        ),

        //Cubits
        Bind.lazySingleton<BalanceScreenCubit>(
          (i) => BalanceScreenCubit(i()),
        ),
        Bind.lazySingleton<ExpensesCubit>(
          (i) => ExpensesCubit(i(), i()),
        ),
        Bind.lazySingleton<ExpensesScreenFiltersCubit>(
          (i) => ExpensesScreenFiltersCubit(),
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
