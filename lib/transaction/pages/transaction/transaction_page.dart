import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/shared/components/category_selector_box/category_selector_box.dart';
import 'package:hermes_app/shared/components/category_selector_box/category_selector_box_cubit.dart';
import 'package:hermes_app/shared/components/transaction_type_dropdown/transaction_type_dropdown.dart';
import 'package:hermes_app/shared/components/transaction_type_dropdown/transaction_type_dropdown_cubit.dart';
import 'package:hermes_app/shared/entities/nullable_model.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/utils/event_bus.dart';
import 'package:hermes_app/shared/validators/transaction_validator.dart';
import 'package:hermes_app/shared/widgets/default_button/default_button.dart';
import 'package:hermes_app/shared/widgets/dialogs/confirmation_dialog.dart';
import 'package:hermes_app/shared/widgets/input/input.dart';
import 'package:hermes_app/shared/widgets/input/input_date.dart';
import 'package:hermes_app/shared/widgets/input/input_money.dart';
import 'package:hermes_app/shared/widgets/input/utils/date_validator.dart';
import 'package:hermes_app/transaction/pages/transaction/transaction_form_cubit.dart';
import 'package:hermes_app/transaction/pages/transaction/transaction_form_state.dart';
import 'package:hermes_app/transaction/pages/transaction/widgets/transaction_photo_widget.dart';

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
    final typography = context.typography;
    return BlocBuilder<TransactionFormCubit, TransactionFormState>(
        bloc: transactionFormCubit,
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              body: Form(
                key: transactionFormCubit.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          final validatorResult = DateValidator.validate(value);
                          String? message;
                          if (validatorResult != DateValidatorResult.correct) {
                            switch (validatorResult) {
                              case DateValidatorResult.correct:
                                break;
                              case DateValidatorResult.formatError:
                                message = "Formato de data inválido";
                                break;
                              case DateValidatorResult.isBefore2000:
                                message = "Data não pode ser antes de 2000";
                                break;
                              case DateValidatorResult.isAfterNow:
                                message = "Data não pode ser depois de hoje";
                                break;
                            }
                          }

                          if (message != null) {
                            transactionFormCubit.change(
                              date: Nullable(null),
                            );
                          }

                          return message;
                        },
                        onChanged: (date) {
                          transactionFormCubit.change(date: Nullable(date));
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
                          final isConfirmed = await const ConfirmationDialog(
                            title: "Deseja remover a foto?",
                          ).show(context);

                          if (isConfirmed) {
                            transactionFormCubit.change(
                              image: Nullable(null),
                            );
                          }
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
                  onPressed: () {
                    final validateResult = transactionFormCubit.validate();
                    String? message;
                    switch (validateResult) {
                      case TransactionValidatorResult.success:
                        break;
                      case TransactionValidatorResult.typeCantBeNull:
                        message = "Selecione um valor no campo tipo";
                        break;
                      case TransactionValidatorResult.valueCantBeNull:
                        message = "Preencha o campo valor";
                        break;
                      case TransactionValidatorResult.dateCantBeNull:
                        message = "Defina uma data válida";
                        break;
                      case TransactionValidatorResult.categoryCantBeNull:
                        message = "Escolha uma categoria";
                        break;
                    }

                    if (message != null) {
                      CherryToast.error(
                        title: Text(
                          message,
                          style: typography.regular.medium,
                        ),
                      ).show(context);
                    }

                    //TODO: add save call method here
                  },
                  title: const Text("Confirmar"),
                ),
              ),
            ),
          );
        });
  }
}
