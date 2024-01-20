import 'package:flutter/material.dart';
import 'package:hermes_app/shared/widgets/default_error_widget/default_error_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: DefaultErrorWidget(
        title: 'Cliente não autorizado',
        description:
            'Ocorreu um erro ao abrir esta tela. Por favor tente novamente mais tarde',
        buttonLabel: 'Voltar',
        onPressed: () async {
          await Future.delayed(const Duration(seconds: 2));
        },
      ),
    );
  }
}
