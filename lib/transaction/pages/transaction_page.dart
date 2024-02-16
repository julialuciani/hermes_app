import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/shared/components/category_selector_box/category_selector_box.dart';
import 'package:hermes_app/shared/components/category_selector_box/category_selector_box_cubit.dart';
import 'package:hermes_app/shared/components/transaction_type_dropdown/transaction_type_dropdown.dart';
import 'package:hermes_app/shared/components/transaction_type_dropdown/transaction_type_dropdown_cubit.dart';
import 'package:hermes_app/shared/entities/nullable_model.dart';
import 'package:hermes_app/shared/utils/event_bus.dart';
import 'package:hermes_app/shared/widgets/default_button/default_button.dart';
import 'package:hermes_app/shared/widgets/dialogs/confirmation_dialog.dart';
import 'package:hermes_app/shared/widgets/input/input.dart';
import 'package:hermes_app/shared/widgets/input/input_date.dart';
import 'package:hermes_app/shared/widgets/input/input_money.dart';
import 'package:hermes_app/shared/widgets/input/utils/date_validator.dart';
import 'package:hermes_app/transaction/cubits/transaction_form/transaction_form_cubit.dart';
import 'package:hermes_app/transaction/cubits/transaction_form/transaction_form_state.dart';
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
  final transactionFormCubit = Modular.get<TransactionFormCubit>();

  @override
  void initState() {
    transactionTypesCubit.fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionFormCubit, TransactionFormState>(
        bloc: transactionFormCubit,
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              body: Form(
                key: transactionFormCubit.formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TransactionTypeDropdown(
                        onChanged: (value) {
                          eventBus.fire(ChangeTransactionTypeEvent(value));
                          transactionFormCubit.change(typeId: Nullable(value));
                        },
                        value: transactionFormCubit.transaction.typeId,
                        validator: (value) {
                          if (value != null) return null;
                          return "Campo obrigatório";
                        },
                      ),
                      const SizedBox(height: 20),
                      InputMoney(
                        label: "Valor *",
                        controller: transactionFormCubit.valueController,
                        onChanged: (value) {
                          transactionFormCubit.change(value: value);
                        },
                        validator: (value) {
                          if (value != null && value.isNotEmpty) return null;
                          return "Campo obrigatório";
                        },
                      ),
                      const SizedBox(height: 20),
                      Input(
                        label: "Descrição",
                        controller: transactionFormCubit.descriptionController,
                        onChanged: (value) {
                          transactionFormCubit.change(description: value);
                        },
                      ),
                      const SizedBox(height: 20),
                      InputDate(
                        label: "Data *",
                        controller: transactionFormCubit.dateController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Campo obrigatório";
                          }
                          if (!DateValidator.validate(value)) {
                            return "Formato de data inválido";
                          }

                          return null;
                        },
                        onChanged: (date) {
                          transactionFormCubit.change(date: date);
                        },
                      ),
                      const SizedBox(height: 20),
                      CategorySelectorBox(
                        onChange: (categoryId) {
                          transactionFormCubit.change(
                            categoryId: Nullable(categoryId),
                          );
                        },
                        selectedCategory:
                            transactionFormCubit.transaction.categoryId,
                      ),
                      const SizedBox(height: 20),
                      TransactionPhotoWidget(
                        image: transactionFormCubit.transaction.image,
                        onRemove: () async {
                          const ConfirmationDialog(
                            title: "Deseja remover a foto?",
                          ).show(context).then((isConfirmed) {
                            if (isConfirmed) {
                              transactionFormCubit.change(
                                  image: Nullable(null));
                            }
                          });
                        },
                        onTap: () {
                          transactionFormCubit.takePictureAndAdd();
                        },
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
              bottomSheet: Container(
                height: 100,
                padding: const EdgeInsets.all(20),
                child: DefaultButton(
                  onPressed: () {},
                  title: const Text("Confirmar"),
                ),
              ),
            ),
          );
        });
  }
}
