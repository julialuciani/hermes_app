import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/shared/components/movement_type_dropdown/movement_type_dropdown.dart';
import 'package:hermes_app/shared/components/movement_type_dropdown/movement_type_dropdown_cubit.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/widgets/content_box/content_box.dart';
import 'package:hermes_app/shared/widgets/default_app_bar/default_app_bar.dart';
import 'package:hermes_app/shared/widgets/default_button/default_button.dart';
import 'package:hermes_app/shared/widgets/input/input.dart';

class CategoryFormPage extends StatefulWidget {
  const CategoryFormPage({super.key});

  @override
  State<CategoryFormPage> createState() => _CategoryFormPageState();
}

class _CategoryFormPageState extends State<CategoryFormPage> {
  final movementTypeCubit = Modular.get<MovementTypeDropdownCubit>();

  @override
  void initState() {
    movementTypeCubit.fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const DefaultAppBar(
        title: 'Categoria',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            MovementTypeDropdown(
              onChanged: (typeId) {},
            ),
            const SizedBox(height: 20),
            const Input(
              label: 'Nome *',
            ),
            const SizedBox(height: 20),
            const ContentBox(
              outsideLabel: 'Ícone *',
              child: Center(child: Text('oi')),
            ),
            const SizedBox(height: 20),
            ContentBox(
              outsideLabel: 'Cor *',
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: 8,
                children: [
                  ...AppColors.colorsToHighlight.map(
                    (color) {
                      return CircleAvatar(
                        backgroundColor: color,
                        radius: 20,
                      );
                    },
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.grey,
                    child: Icon(
                      Icons.add,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 120),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(20),
        height: 100,
        child: DefaultButton(
          onPressed: () {},
          title: const Text('Confirmar'),
        ),
      ),
    );
  }
}
