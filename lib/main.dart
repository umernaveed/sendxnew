import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/app/core/routes/app_routes.dart';
import 'package:sendx/app/core/theme/light_theme.dart';
import 'package:sendx/app/services/push_notifications_service.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Injector.setUp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const SendX());
}

class SendX extends StatelessWidget {
  const SendX({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,

          onInit: () {
            final badger = find<FlutterAppNotificationBadger>();
            badger.clearBadge();
          },
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!,
            );
          },

          /// theme
          themeMode: ThemeMode.light,
          theme: LightTheme().themeData,

          ///
          initialRoute: AppRoutes.initialRoute,
          getPages: AppRoutes.routes,
          title: 'SendX',
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
