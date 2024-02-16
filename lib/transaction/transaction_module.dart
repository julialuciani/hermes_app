import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/transaction/cubits/transaction_form/transaction_form_cubit.dart';
import 'package:hermes_app/transaction/pages/transaction_page.dart';

class TransactionModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        //Cubits
        Bind.lazySingleton(
          (i) => TransactionFormCubit(i()),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const TransactionPage(),
          transition: TransitionType.rightToLeftWithFade,
          duration: const Duration(milliseconds: 300),
        )
      ];
}
