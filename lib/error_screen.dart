import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sendx/app/core/assets/drawables.dart';
import 'package:sendx/presentation/base_screen.dart';
import 'package:sizer/sizer.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      value: SystemUiOverlayStyle.dark,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Drawables.warning,
              height: 20.h,
            ),
            const SizedBox(height: 16),
            const Text(
              'We are down at the moment.\nPlease try again later.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
