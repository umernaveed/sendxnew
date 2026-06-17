import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/app/services/firebae_service.dart';
import 'package:sendx/app/services/push_notifications_service.dart';
import 'package:sendx/firebase_options.dart';

class FirebaseInitializer extends StatefulWidget {
  final WidgetBuilder errorBuilder;
  final WidgetBuilder loadingBuilder;
  final Widget Function(BuildContext) successBuilder;
  final VoidCallback onAppInitDone;

  const FirebaseInitializer({
    super.key,
    required this.errorBuilder,
    required this.loadingBuilder,
    required this.successBuilder,
    required this.onAppInitDone,
  });

  @override
  State<FirebaseInitializer> createState() => _FirebaseInitializerState();
}

class _FirebaseInitializerState extends State<FirebaseInitializer> {
  Future<void>? _initialization;

  @override
  void initState() {
    super.initState();
    _initialization = _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    try {
      log('--------Initialize Firebase App--------');
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);

      AppPushNotifications.initNotifications();
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      await FirebaseMessaging.instance.setAutoInitEnabled(true);
      log('--------Initialize Firebase App Successfully Completed--------');
      widget.onAppInitDone.call();
      put<FirebaseService>(FirebaseServiceImpl(), permanent: true);
    } catch (e) {
      log('--------Error: Initialize Firebase App--------');
      log(e.toString());
      log('----------------');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return widget.errorBuilder(context);
          }
          return widget.successBuilder(context);
        }
        return widget.loadingBuilder(context);
      },
    );
  }
}
