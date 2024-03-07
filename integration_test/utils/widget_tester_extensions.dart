import 'package:flutter_test/flutter_test.dart';

extension WidgetTesterExtension on WidgetTester {
  Future<void> tapAndPump(
    Finder finder, [
    Duration duration = const Duration(seconds: 1),
  ]) async {
    await tap(finder);
    await pump(duration);
  }

  Future<void> tapAndPumpAndSettle(
    Finder finder, [
    Duration duration = const Duration(seconds: 1),
  ]) async {
    await tap(finder);
    await pumpAndSettle(duration);
  }
}
