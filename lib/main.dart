import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/app_module.dart';
import 'package:hermes_app/app_widget.dart';
import 'package:hermes_app/shared/database/database_sqflite.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await runZonedGuarded(
    () async {
      await DatabaseSqflite.instance.database;
      Intl.systemLocale = await findSystemLocale();
      initializeDateFormatting(Intl.systemLocale);

      runApp(
        ModularApp(
          module: AppModule(),
          child: const AppWidget(),
        ),
      );
    },
    (error, stackTrace) {
      //TODO: ADD FIREBASE CRASHLYTICS IN THE FUTURE TO RECORD THIS CRASHES
    },
  );
}
