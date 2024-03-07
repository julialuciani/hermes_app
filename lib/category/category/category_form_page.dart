import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/category/category/category_form_cubit.dart';
import 'package:hermes_app/category/category/category_form_state.dart';
import 'package:hermes_app/category/category/models/utils/category_form_model_validator.dart';
import 'package:hermes_app/category/category/widgets/category_header.dart';
import 'package:hermes_app/category/category/widgets/color_selector_box.dart';
import 'package:hermes_app/category/category/widgets/icon_selector_box.dart';
import 'package:hermes_app/category/category_routes.dart';
import 'package:hermes_app/shared/components/movement_type_dropdown/movement_type_dropdown.dart';
import 'package:hermes_app/shared/components/movement_type_dropdown/movement_type_dropdown_cubit.dart';
import 'package:hermes_app/shared/entities/nullable_model.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/widgets/default_app_bar/default_app_bar.dart';
import 'package:hermes_app/shared/widgets/default_button/default_button.dart';
import 'package:hermes_app/shared/widgets/default_error_widget/register_error_cubit.dart';
import 'package:hermes_app/shared/widgets/input/input.dart';

class CategoryFormPage extends StatefulWidget {
  const CategoryFormPage({super.key});

  @override
  State<CategoryFormPage> createState() => _CategoryFormPageState();
}

class _CategoryFormPageState extends State<CategoryFormPage> {
  final movementTypeCubit = Modular.get<MovementTypeDropdownCubit>();
  final formCubit = Modular.get<CategoryFormCubit>();
  final registerErrorCubit = Modular.get<RegisterErrorCubit>();

  @override
  void initState() {
    movementTypeCubit.fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    void showToastByValidationResult({
      required CategoryFormValidationResult validationResult,
    }) {
      String? message;
      switch (validationResult) {
        case CategoryFormValidationResult.success:
        case CategoryFormValidationResult.typeNotNull:
          message = 'Selecione um tipo de movimentação';
          break;
        case CategoryFormValidationResult.nameNotNull:
          message = 'Preencha um nome para a categoria';
          break;
        case CategoryFormValidationResult.iconNotNull:
          message = 'Selecione um ícone';
          break;
        case CategoryFormValidationResult.colorNotNull:
          message = 'Selecione uma cor';
          break;
      }

      CherryToast.error(
        title: Text(
          message,
          style: typography.regular.medium,
        ),
      ).show(context);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const DefaultAppBar(
        title: 'Categoria',
      ),
      body: BlocConsumer(
          bloc: formCubit,
          listener: (context, state) {
            if (state is CategoryFormSuccessSave) {
              CherryToast.success(
                title: Text(
                  'Categoria salva com sucesso',
                  style: typography.regular.medium,
                ),
                toastDuration: const Duration(seconds: 2),
              ).show(context);
              Modular.to.pop();
            }
            if (state is CategoryFormErrorSave) {
              registerErrorCubit.registerError(state.failure);
              CherryToast.error(
                title: Text(
                  'Ocorreu um erro ao salvar a categoria',
                  style: typography.regular.medium,
                ),
                toastDuration: const Duration(seconds: 2),
              ).show(context);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              key: const Key('scroll_category_form'),
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formCubit.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    CategoryHeader(
                      category: formCubit.category,
                    ),
                    const SizedBox(height: 20),
                    MovementTypeDropdown(
                      key: const Key('movement_type_dropdown'),
                      onChanged: (typeId) {
                        formCubit.change(movementTypeId: Nullable(typeId));
                      },
                      value: formCubit.category.movementTypeId,
                      validator: (typeId) {
                        if (typeId == null) return 'Campo obrigatório';
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Input(
                      key: const Key('input_name'),
                      label: 'Nome *',
                      controller: formCubit.nameController,
                      onChanged: (value) {
                        formCubit.change(name: value);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    IconSelectorBox(
                      selectedColor: formCubit.category.color,
                      selectedIcon: formCubit.category.icon,
                      onChange: (icon) {
                        formCubit.change(icon: Nullable(icon));
                      },
                      onTapOthers: () {
                        Modular.to.pushNamed(
                          CategoryRoutes.categoryIconSelector,
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    ColorSelectorBox(
                      currentColor: formCubit.category.color,
                      onChange: (color) {
                        formCubit.change(color: Nullable(color));
                      },
                    ),
                    const SizedBox(height: 120),
                  ],
                ),
              ),
            );
          }),
      bottomSheet: Container(
        padding: const EdgeInsets.all(20),
        height: 100,
        child: DefaultButton(
          key: const Key('bnt_save_category'),
          onPressed: () {
            final validateFormResult = formCubit.validateForm();
            if (validateFormResult != CategoryFormValidationResult.success) {
              showToastByValidationResult(validationResult: validateFormResult);
              return;
            }

            formCubit.save();
          },
          title: const Text('Confirmar'),
        ),
      ),
    );
  }
}
