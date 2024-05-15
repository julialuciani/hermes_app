import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/home/balance/cubits/balance_screen_cubit.dart';
import 'package:hermes_app/home/expenses/expenses_cubit.dart';
import 'package:hermes_app/home/expenses/filters/expenses_screen_filters_cubit.dart';
import 'package:hermes_app/home/expenses/get_expenses_chart_sections_use_case.dart';
import 'package:hermes_app/home/expenses/get_expenses_use_case.dart';
import 'package:hermes_app/home/investments/filters/investments_screen_filters_cubit.dart';
import 'package:hermes_app/home/investments/get_investments_chart_sections_use_case.dart';
import 'package:hermes_app/home/investments/get_investments_use_case.dart';
import 'package:hermes_app/home/investments/investments_cubit.dart';
import 'package:hermes_app/home/pages/home_page.dart';

import 'balance/cubits/balance_screen_filter_cubit.dart';
import 'balance/get_all_movement_by_period_use_case.dart';
import 'balance/group_movement_use_case.dart';

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
        Bind.factory<GetInvestmentsUseCase>(
          (i) => GetInvestmentsUseCase(i()),
        ),
        Bind.factory<GetInvestmentsChartSectionsUseCase>(
          (i) => GetInvestmentsChartSectionsUseCase(i()),
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
        Bind.lazySingleton<BalanceScreenFilterCubit>(
          (i) => BalanceScreenFilterCubit(),
        ),
        Bind.lazySingleton<InvestmentsCubit>(
          (i) => InvestmentsCubit(i(), i()),
        ),
        Bind.lazySingleton<InvestmentsScreenFiltersCubit>(
          (i) => InvestmentsScreenFiltersCubit(),
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
