import 'package:flutter/material.dart';
import 'package:hermes_app/shared/entities/movement_model.dart';
import 'package:hermes_app/shared/widgets/default_app_bar/default_app_bar.dart';

class ExtractDialog extends StatelessWidget {
  const ExtractDialog({
    super.key,
    required this.period,
    required this.movements,
  });

  final String period;
  final List<MovementModel> movements;

  static void show(
    BuildContext context, {
    required String period,
    required List<MovementModel> movements,
  }) {
    showGeneralDialog(
      context: context,
      transitionDuration: const Duration(milliseconds: 500),
      transitionBuilder: (context, _, __, child) {
        const begin = Offset(0, 1);
        const end = Offset(0, 0);
        const curve = Curves.ease;
        final tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: tween.animate(_),
          child: child,
        );
      },
      pageBuilder: (context, _, __) {
        return ExtractDialog(
          period: period,
          movements: movements,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: 'Extrato',
        subtitle: period,
      ),
      body: Container(),
    );
  }
}
