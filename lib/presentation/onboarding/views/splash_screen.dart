import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sendx/error_screen.dart';
import 'package:sendx/firebase_initlizer.dart';
import 'package:sendx/loading_screen.dart';
import 'package:sendx/presentation/base_screen.dart';
import 'package:sendx/presentation/onboarding/controllers/on_boarding_controller.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends GetView<OnBoardingController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FirebaseInitializer(
      errorBuilder: (context) => const ErrorScreen(),
      loadingBuilder: (context) => const LoadingScreen(),
      successBuilder: (context) => _SplashView(controller: controller),
      onAppInitDone: () {
        Future.delayed(3.seconds, () {
          controller.proceedFurther();
        });
      },
    );
  }
}

class _SplashView extends StatelessWidget {
  const _SplashView({
    required this.controller,
  });

  final OnBoardingController controller;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      wrapWithSafeArea: true,
      value: SystemUiOverlayStyle.dark,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(
                  'assets/svgs/app_logo_sendx.svg',
                  width: 241,
                  height: 138,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 5.h,
            left: 0,
            right: 0,
            child: Center(
              child: Obx(
                () {
                  return controller.isLoading.value
                      ? const CircularProgressIndicator.adaptive()
                      : const SizedBox.shrink();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension WidgetX on Widget {
  wrapWithBGGradient(
      {required String topGradient, required String bottomGradient}) {}
}
