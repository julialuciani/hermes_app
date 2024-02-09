import 'package:flutter/material.dart';
import 'package:hermes_app/shared/utils/transaction_type_enum.dart';
import 'package:hermes_app/shared/widgets/content_box/content_box.dart';
import 'package:hermes_app/shared/widgets/default_button/default_button.dart';
import 'package:hermes_app/shared/widgets/dropdown/dropdown.dart';
import 'package:hermes_app/shared/widgets/dropdown/dropdown_item.dart';
import 'package:hermes_app/shared/widgets/input/input.dart';
import 'package:hermes_app/shared/widgets/select/select.dart';
import 'package:hermes_app/transaction/widgets/transaction_photo_widget.dart';

class TransactionPage extends StatefulWidget {
  final TransactionTypeEnum transactionTypeEnum;

  const TransactionPage({
    Key? key,
    required this.transactionTypeEnum,
  }) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Dropdown(
                items: [
                  DropdownItem(
                    description: "Gastos",
                    value: 1,
                  ),
                  DropdownItem(
                    description: "Entradas",
                    value: 2,
                  ),
                  DropdownItem(
                    description: "Investimentos",
                    value: 3,
                  ),
                ],
                onChanged: (id) {},
                label: "Tipo",
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
