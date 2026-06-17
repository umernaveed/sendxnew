import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sendx/presentation/base_screen.dart';
import 'package:sizer/sizer.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      wrapWithSafeArea: true,
      value: SystemUiOverlayStyle.dark,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(
                  'assets/svgs/app_logo_sendx.svg',
                  width: 241,
                  height: 138,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Setting up...',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Positioned(
            bottom: 5.h,
            left: 0,
            right: 0,
            child: const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
        ],
      ),
    );
  }
}
