import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/shared/utils/transaction_type_enum.dart';
import 'package:hermes_app/transaction/pages/transaction_page.dart';

class TransactionModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => TransactionPage(
            transactionTypeEnum:
                args.data['transactionTypeEnum'] as TransactionTypeEnum,
          ),
          transition: TransitionType.rightToLeftWithFade,
          duration: const Duration(milliseconds: 300),
        )
      ];
}
