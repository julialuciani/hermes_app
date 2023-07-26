import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hermes_app/app_module.dart';
import 'package:hermes_app/app_widget.dart';

void main() {
  runZonedGuarded(
    () {
      runApp(
        ProviderScope(
          child: ModularApp(
            module: AppModule(),
            child: const AppWidget(),
          ),
        ),
      );
    },
    (error, stackTrace) {
      //TODO: ADD FIREBASE CRASHLYTICS IN THE FUTURE TO RECORD THIS CRASHES
    },
  );
}
