import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/transaction/pages/transaction/save_transaction_usecase.dart';
import 'package:hermes_app/transaction/pages/transaction/transaction_form_cubit.dart';
import 'package:hermes_app/transaction/pages/transaction/transaction_page.dart';

class TransactionModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        //Usecases
        Bind.factory<SaveTransactionUsecase>(
          (i) => SaveTransactionUsecase(i()),
        ),

        //Cubits
        Bind.lazySingleton(
          (i) => TransactionFormCubit(i(), i()),
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
