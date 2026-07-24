import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sendx/app/core/routes/app_routes.dart';
import 'package:sendx/app/core/theme/app_colors.dart';
import 'package:sendx/presentation/base_screen.dart';
import 'package:sendx/presentation/bottom_nav/controllers/bottom_nav_controller.dart';
import 'package:sizer/sizer.dart';

class BottomNavScreen extends GetView<BottomNavController> {
  const BottomNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      value: SystemUiOverlayStyle.dark,
      showGradients: true,
      extendBody: false,
      wrapWithAnnotatedRegion: true,
      body: Navigator(
        key: Get.nestedKey(controller.bottomNavNestedID),
        onGenerateRoute: (settings) {
          Get.routing.args = settings.arguments;
          final page = AppRoutes.routes.firstWhere(
            (r) => r.name == settings.name,
          );
          return GetPageRoute<dynamic>(
            page: page.page,
            settings: settings,
            binding: page.binding,
            transition: page.transition,
            parameter: page.parameters,
            opaque: page.opaque,
            popGesture: page.popGesture,
            fullscreenDialog: page.fullscreenDialog,
            maintainState: page.maintainState,
            curve: page.curve,
            middlewares: page.middlewares,
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 9.8.h,
        margin: EdgeInsets.fromLTRB(3.w, 0, 3.w, 1.1.h),
        padding: EdgeInsets.only(top: 0.25.h),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.96),
          borderRadius: BorderRadius.circular(26),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: AppColors.cyan.withOpacity(0.13),
              spreadRadius: 0,
              offset: const Offset(0, 10),
              blurRadius: 24,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(26),
          child: Obx(
            () => BottomNavigationBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              currentIndex: controller.currentIndex.value,
              onTap: controller.onTabChange,
              items: [
                BottomNavigationBarItem(
                  activeIcon: Padding(
                    padding: EdgeInsets.only(bottom: 0.25.h, top: 0.35.h),
                    child: SvgPicture.asset(
                      'assets/svgs/ic_home.svg',
                      color: AppColors.cyan,
                      height: 2.2.h,
                    ),
                  ),
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 0.25.h, top: 0.35.h),
                    child: SvgPicture.asset(
                      'assets/svgs/ic_home.svg',
                      height: 2.2.h,
                    ),
                  ),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                  activeIcon: Padding(
                    padding: EdgeInsets.only(bottom: 0.25.h, top: 0.35.h),
                    child: Icon(
                      Icons.location_on_outlined,
                      color: AppColors.cyan,
                      size: 2.45.h,
                    ),
                  ),
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 0.25.h, top: 0.35.h),
                    child: Icon(
                      Icons.location_on_outlined,
                      size: 2.45.h,
                    ),
                  ),
                  label: 'Addresses',
                ),
                BottomNavigationBarItem(
                  activeIcon: Padding(
                    padding: EdgeInsets.only(bottom: 0.25.h, top: 0.35.h),
                    child: Icon(
                      Icons.local_shipping_outlined,
                      color: AppColors.cyan,
                      size: 2.55.h,
                    ),
                  ),
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 0.25.h, top: 0.35.h),
                    child: Icon(
                      Icons.local_shipping_outlined,
                      size: 2.55.h,
                    ),
                  ),
                  label: 'Delivery',
                ),
                BottomNavigationBarItem(
                  activeIcon: Padding(
                    padding: EdgeInsets.only(bottom: 0.25.h, top: 0.35.h),
                    child: Icon(
                      Icons.calendar_month_outlined,
                      color: AppColors.cyan,
                      size: 2.55.h,
                    ),
                  ),
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 0.25.h, top: 0.35.h),
                    child: Icon(
                      Icons.calendar_month_outlined,
                      size: 2.55.h,
                    ),
                  ),
                  label: 'News',
                ),
                BottomNavigationBarItem(
                  activeIcon: Padding(
                    padding: EdgeInsets.only(bottom: 0.25.h, top: 0.35.h),
                    child: Icon(
                      Icons.headset_mic_outlined,
                      color: AppColors.cyan,
                      size: 2.55.h,
                    ),
                  ),
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 0.25.h, top: 0.35.h),
                    child: Icon(
                      Icons.headset_mic_outlined,
                      size: 2.55.h,
                    ),
                  ),
                  label: 'Support',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
