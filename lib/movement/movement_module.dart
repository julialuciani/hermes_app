import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/movement/movement/movement_category_selector_page.dart';
import 'package:hermes_app/movement/movement/movement_form_cubit.dart';
import 'package:hermes_app/movement/movement/movement_page.dart';
import 'package:hermes_app/movement/movement/save_movement_use_case.dart';

class MovementModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        //Usecases
        Bind.factory<SaveMovementUseCase>(
          (i) => SaveMovementUseCase(i()),
        ),

        //Cubits
        Bind.lazySingleton(
          (i) => MovementFormCubit(i(), i()),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const MovementPage(),
          transition: TransitionType.rightToLeftWithFade,
          duration: const Duration(milliseconds: 300),
        ),
        ChildRoute(
          '/category_selector/',
          child: (context, args) => const MovementCategorySelectorPage(),
          transition: TransitionType.rightToLeftWithFade,
          duration: const Duration(milliseconds: 300),
        ),
      ];
}
