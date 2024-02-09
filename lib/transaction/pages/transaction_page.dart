import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/shared/components/transaction_type_dropdown/transaction_type_dropdown.dart';
import 'package:hermes_app/shared/components/transaction_type_dropdown/transaction_type_dropdown_cubit.dart';
import 'package:hermes_app/shared/widgets/content_box/content_box.dart';
import 'package:hermes_app/shared/widgets/default_button/default_button.dart';
import 'package:hermes_app/shared/widgets/input/input.dart';
import 'package:hermes_app/shared/widgets/select/select.dart';
import 'package:hermes_app/transaction/widgets/transaction_photo_widget.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final transactionTypesCubit = Modular.get<TransactionTypeDropdownCubit>();

  @override
  void initState() {
    transactionTypesCubit.fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TransactionTypeDropdown(
                onChanged: (value) {},
              ),
              const SizedBox(height: 20),
              const Input(
                label: "Valor",
              ),
              const SizedBox(height: 20),
              const Input(
                label: "Descrição",
              ),
              const SizedBox(height: 20),
              ContentBox(
                outsideLabel: "Categoria",
                child: Wrap(),
              ),
              const SizedBox(height: 20),
              Select(
                label: "Fonte",
                data: const [
                  SelectData(
                    value: 0,
                    label: "Dinheiro",
                  ),
                  SelectData(
                    value: 1,
                    label: "Cartão",
                  ),
                  SelectData(
                    value: 2,
                    label: "Outro",
                  ),
                ],
                onPressed: (value) {
                  print(value);
                },
                selectedValue: 0,
              ),
              const SizedBox(height: 20),
              const TransactionPhotoWidget(),
              const SizedBox(height: 100),
            ],
          ),
        ),
        bottomSheet: Container(
          padding: const EdgeInsets.all(20),
          child: DefaultButton(
            onPressed: () {},
            title: const Text("Confirmar"),
          ),
        ),
      ),
    );
  }
}
