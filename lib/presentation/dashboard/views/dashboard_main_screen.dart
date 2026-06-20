import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sendx/app/core/routes/app_pages.dart';
import 'package:sendx/app/core/theme/app_colors.dart';
import 'package:sendx/presentation/base_screen.dart';
import 'package:sendx/presentation/bottom_nav/controllers/bottom_nav_controller.dart';
import 'package:sendx/presentation/dashboard/views/dashboard.dart';
import 'package:sizer/sizer.dart';

class DashboardMainScreen extends StatelessWidget {
  const DashboardMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.white,
      ),
      showGradients: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: const [
            _DashboardHeader(),
            Expanded(child: Dashboard()),
          ],
        ),
      ),
    );
  }
}

class _DashboardHeader extends StatelessWidget {
  const _DashboardHeader();

  void _openAccount() {
    if (Get.isRegistered<BottomNavController>()) {
      Get.find<BottomNavController>().onTabChange(4);
      return;
    }
    Get.toNamed(AppPages.account);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(4.w, 1.2.h, 4.w, 1.h),
      child: Row(
        children: [
          _HeaderIconButton(
            icon: Icons.menu_rounded,
            onTap: _openAccount,
          ),
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/images/app_logo_image.png',
                height: 4.8.h,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              _HeaderIconButton(
                icon: Icons.notifications_none_rounded,
                onTap: () {
                  if (Get.isRegistered<BottomNavController>()) {
                    Get.find<BottomNavController>().onTabChange(3);
                  }
                },
              ),
              Positioned(
                right: -1,
                top: -2,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: AppColors.coral,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    '3',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _HeaderIconButton({
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: SizedBox(
          width: 11.w,
          height: 5.4.h,
          child: Icon(
            icon,
            color: AppColors.ink,
            size: 28,
          ),
        ),
      ),
    );
  }
}
