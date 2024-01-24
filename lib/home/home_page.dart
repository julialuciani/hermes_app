import 'package:flutter/material.dart';
import 'package:hermes_app/shared/widgets/default_button/default_button.dart';
import 'package:hermes_app/shared/widgets/dropdown/dropdown.dart';
import 'package:hermes_app/shared/widgets/dropdown/dropdown_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Dropdown(
                items: List.generate(
                  90,
                  (index) => DropdownItem(
                      description: "Item ${index + 1}", value: index),
                ),
                onChanged: (id) {},
                label: "Teste",
                validator: (value) {
                  if (value == null) return "Valor precisa ser selecionado";
                  if (value.isEven) return "Valor precisa ser par";
                  return null;
                },
                enabled: true,
                value: 2,
              ),
            ),
            DefaultButton(
              onPressed: () {
                formKey.currentState?.validate();
              },
              title: const Text("Send form"),
            ),
          ],
        ),
      ),
    );
  }
}
