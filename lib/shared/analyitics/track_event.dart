import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';

void trackEvent(
  String eventName, {
  Map<String, dynamic>? parameters,
}) {
  FirebaseAnalytics.instance.logEvent(name: eventName, parameters: parameters);
  log('Event: $eventName, parameters: $parameters');
}
