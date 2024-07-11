import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/home/home_routes.dart';
import 'package:hermes_app/shared/widgets/loading_widgets/loading_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _initializeFirebaseAuthUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      await FirebaseAuth.instance.signInAnonymously();
    }

    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      FirebaseCrashlytics.instance.setUserIdentifier(currentUser.uid);
    }
  }

  void _initialize() async {
    final futures = Future.wait([
      _initializeFirebaseAuthUser(),
    ]);

    await futures;

    _onInitilizationEnd();
  }

  void _onInitilizationEnd() {
    Modular.to.pushNamed(HomeRoutes.home);
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: LoadingIndicator()),
    );
  }
}
