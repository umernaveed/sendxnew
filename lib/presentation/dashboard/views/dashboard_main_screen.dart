import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sendx/presentation/auth/widgets/auth_app_bar.dart';
import 'package:sendx/presentation/base_screen.dart';
import 'package:sendx/presentation/dashboard/controllers/dashboard_tabbar_controller.dart';
import 'package:sendx/presentation/dashboard/views/address.dart';
import 'package:sendx/presentation/dashboard/views/dashboard.dart';
import 'package:sendx/presentation/dashboard/views/packages.dart';
import 'package:sizer/sizer.dart';

class DashboardMainScreen extends GetView<DashboardTabBarController> {
  const DashboardMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      value: SystemUiOverlayStyle.dark,
      appBar: const AuthCustomAppBar.withSmallAppLogo(backButtonVisible: false),
      showGradients: false,
      backgroundColor: const Color(0xFFFAF4F2).withOpacity(0.4),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.w),
        child: Column(
          children: [
            SizedBox(height: 2.h),
            TabBar(
              overlayColor:
                  MaterialStateProperty.all<Color>(Colors.transparent),
              controller: controller.tabController,
              indicator: null,
              indicatorPadding: EdgeInsets.zero,
              indicatorColor: Colors.white,
              automaticIndicatorColorAdjustment: true,
              labelStyle: const TextStyle(
                color: Color(0xFF4791CE),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelStyle: const TextStyle(
                color: Color(0xFF181725),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              tabs: [
                Obx(
                  () => CustomTab(
                    text: 'Dashboard',
                    textColor: controller.isDashboardSelected
                        ? const Color(0xFF4791CE)
                        : const Color(0xFF181725),
                  ),
                ),
                Obx(
                  () => CustomTab(
                    text: 'Packages',
                    textColor: controller.isPackagesSelected
                        ? const Color(0xFF4791CE)
                        : const Color(0xFF181725),
                  ),
                ),
                Obx(
                  () => CustomTab(
                    text: 'Address',
                    textColor: controller.isAddressSelected
                        ? const Color(0xFF4791CE)
                        : const Color(0xFF181725),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: const [
                  Dashboard(),
                  Packages(),
                  Address(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTab extends StatelessWidget {
  final String text;
  final Color textColor;

  const CustomTab({
    super.key,
    required this.text,
    this.textColor = const Color(0xFF181725),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4.2.h,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        shadows: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 4,
            offset: Offset(0, 3),
            spreadRadius: 1.8,
          )
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
