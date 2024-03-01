import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/category/category/category_form_cubit.dart';
import 'package:hermes_app/category/category/category_form_page.dart';

class CategoryModule extends Module {
  @override
  List<Bind<Object>> binds = [
    Bind.lazySingleton<CategoryFormCubit>(
      (i) => CategoryFormCubit(),
    ),
  ];

  @override
  List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => const CategoryFormPage(),
      transition: TransitionType.rightToLeftWithFade,
      duration: const Duration(milliseconds: 300),
    ),
  ];
}
