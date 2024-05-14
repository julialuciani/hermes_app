import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/movement/movement/movement_form_cubit.dart';
import 'package:hermes_app/movement/movement/movement_form_state.dart';
import 'package:hermes_app/movement/movement/utils/movement_page_message_selectors_mixin.dart';
import 'package:hermes_app/movement/movement/widgets/movement_photo_widget.dart';
import 'package:hermes_app/movement/movement_routes.dart';
import 'package:hermes_app/shared/components/category_selector_box/category_selector_box.dart';
import 'package:hermes_app/shared/components/category_selector_box/category_selector_box_cubit.dart';
import 'package:hermes_app/shared/components/movement_type_dropdown/movement_type_dropdown.dart';
import 'package:hermes_app/shared/components/movement_type_dropdown/movement_type_dropdown_cubit.dart';
import 'package:hermes_app/shared/entities/movement_model.dart';
import 'package:hermes_app/shared/entities/nullable_model.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/utils/event_bus.dart';
import 'package:hermes_app/shared/widgets/default_app_bar/default_app_bar.dart';
import 'package:hermes_app/shared/widgets/default_button/default_button.dart';
import 'package:hermes_app/shared/widgets/default_error_widget/register_error_cubit.dart';
import 'package:hermes_app/shared/widgets/dialogs/confirmation_dialog.dart';
import 'package:hermes_app/shared/widgets/input/input.dart';
import 'package:hermes_app/shared/widgets/input/input_date.dart';
import 'package:hermes_app/shared/widgets/input/input_money.dart';
import 'package:hermes_app/shared/widgets/input/utils/date_validator.dart';

class MovementPageArgs {
  final MovementModel? movement;

  MovementPageArgs({
    this.movement,
  });
}

class MovementPage extends StatefulWidget {
  const MovementPage({
    Key? key,
    this.movement,
  }) : super(key: key);

  final MovementModel? movement;

  @override
  State<MovementPage> createState() => _MovementPageState();
}

class _MovementPageState extends State<MovementPage>
    with MovementPageMessageSelectorsMixin {
  final movementTypesCubit = Modular.get<MovementTypeDropdownCubit>();
  final movementFormCubit = Modular.get<MovementFormCubit>();
  final registerErrorCubit = Modular.get<RegisterErrorCubit>();

  @override
  void initState() {
    super.initState();
    movementTypesCubit.fetch();
    if (widget.movement != null) {
      movementFormCubit.init(widget.movement!);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        eventBus.fire(ChangeMovementTypeEvent(widget.movement!.typeId));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return BlocConsumer<MovementFormCubit, MovementFormState>(
        bloc: movementFormCubit,
        listener: (context, state) {
          if (state is MovementFormSuccessSave) {
            CherryToast.success(
              title: Text(
                'Transação salva com sucesso',
                style: typography.regular.medium,
              ),
              toastDuration: const Duration(seconds: 2),
            ).show(context);
            Modular.to.pop();
          }
          if (state is MovementFormErrorSave) {
            registerErrorCubit.registerError(state.failure);
            CherryToast.error(
              title: Text(
                'Ocorreu um erro ao salvar a transação',
                style: typography.regular.medium,
              ),
              toastDuration: const Duration(seconds: 2),
            ).show(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: const DefaultAppBar(
              title: 'Transação',
            ),
            body: Form(
              key: movementFormCubit.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    MovementTypeDropdown(
                      key: const Key('movement_type_dropdown'),
                      onChanged: (value) {
                        eventBus.fire(ChangeMovementTypeEvent(value));
                        movementFormCubit.change(typeId: Nullable(value));
                      },
                      value: movementFormCubit.movement.typeId,
                      validator: (value) {
                        if (value != null) return null;
                        return 'Campo obrigatório';
                      },
                    ),
                    const SizedBox(height: 20),
                    InputMoney(
                      key: const Key('value_input'),
                      label: 'Valor *',
                      controller: movementFormCubit.valueController,
                      onChanged: (value) {
                        movementFormCubit.change(value: value);
                      },
                      validator: (value) {
                        if (value != null && value.isNotEmpty) return null;
                        return 'Campo obrigatório';
                      },
                    ),
                    const SizedBox(height: 20),
                    Input(
                      key: const Key('description_input'),
                      label: 'Descrição',
                      controller: movementFormCubit.descriptionController,
                      onChanged: (value) {
                        movementFormCubit.change(description: value);
                      },
                    ),
                    const SizedBox(height: 20),
                    InputDate(
                      label: 'Data *',
                      controller: movementFormCubit.dateController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        final validatorResult = DateValidator.validate(value);
                        String? message =
                            getValidatorMessageByDateValidatorResult(
                          dateValidatorResult: validatorResult,
                        );

                        if (message != null) {
                          movementFormCubit.change(
                            date: Nullable(null),
                          );
                        }

                        return message;
                      },
                      onChanged: (date) {
                        movementFormCubit.change(date: Nullable(date));
                      },
                    ),
                    const SizedBox(height: 20),
                    CategorySelectorBox(
                      onChange: (categoryId) {
                        movementFormCubit.change(
                          categoryId: Nullable(categoryId),
                        );
                      },
                      selectedCategory: movementFormCubit.movement.categoryId,
                      onTapOthers: () {
                        Modular.to.pushNamed(
                          MovementRoutes.movementCategorySelector,
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    MovementPhotoWidget(
                      image: movementFormCubit.movement.image,
                      onRemove: () async {
                        final isConfirmed = await const ConfirmationDialog(
                          title: 'Deseja remover a foto?',
                        ).show(context);

                        if (isConfirmed) {
                          movementFormCubit.change(
                            image: Nullable(null),
                          );
                        }
                      },
                      onTap: () {
                        movementFormCubit.takePictureAndAdd();
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
                key: const Key('btn_save_movement'),
                onPressed: () {
                  final validateResult = movementFormCubit.validate();
                  final message = getErrorMessageByMovementValidatorResult(
                    result: validateResult,
                  );

                  if (message != null) {
                    CherryToast.error(
                      title: Text(
                        message,
                        style: typography.regular.medium,
                      ),
                      toastDuration: const Duration(seconds: 2),
                    ).show(context);
                  } else {
                    movementFormCubit.save();
                  }
                },
                title: const Text('Confirmar'),
              ),
            ),
          );
        });
  }
}
