import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sendx/app/core/routes/app_routes.dart';
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
      extendBody: true,
      wrapWithAnnotatedRegion: true,
      body: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        child: Navigator(
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
      ),
      bottomNavigationBar: Container(
        height: 12.h,
        padding: EdgeInsets.only(top: 1.h),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black38.withOpacity(0.05),
              spreadRadius: 0,
              offset: const Offset(1, 0),
              blurRadius: 5,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          child: Obx(
            () => BottomNavigationBar(
              currentIndex: controller.currentIndex.value,
              onTap: controller.onTabChange,
              items: [
                BottomNavigationBarItem(
                  activeIcon: Padding(
                    padding: EdgeInsets.only(bottom: 0.4.h, top: 0.8.h),
                    child: SvgPicture.asset(
                      'assets/svgs/ic_home.svg',
                      color: const Color(0xFF4791CE),
                      height: 2.h,
                    ),
                  ),
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 0.4.h, top: 0.8.h),
                    child: SvgPicture.asset(
                      'assets/svgs/ic_home.svg',
                      height: 2.h,
                    ),
                  ),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                  activeIcon: Padding(
                    padding: EdgeInsets.only(bottom: 0.4.h, top: 0.8.h),
                    child: SvgPicture.asset(
                      'assets/svgs/ic_person.svg',
                      color: const Color(0xFF4791CE),
                      height: 2.h,
                    ),
                  ),
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 0.4.h, top: 0.8.h),
                    child: SvgPicture.asset(
                      'assets/svgs/ic_person.svg',
                      height: 2.h,
                    ),
                  ),
                  label: 'Authorize User',
                ),
                BottomNavigationBarItem(
                  activeIcon: Padding(
                    padding: EdgeInsets.only(bottom: 0.4.h, top: 0.8.h),
                    child: SvgPicture.asset(
                      'assets/svgs/ic_delivery.svg',
                      color: const Color(0xFF4791CE),
                      height: 2.h,
                    ),
                  ),
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 0.4.h, top: 0.8.h),
                    child: SvgPicture.asset(
                      'assets/svgs/ic_delivery.svg',
                      height: 2.h,
                    ),
                  ),
                  label: 'Delivery',
                ),
                BottomNavigationBarItem(
                  activeIcon: Padding(
                    padding: EdgeInsets.only(bottom: 0.4.h, top: 0.8.h),
                    child: Icon(
                      Icons.newspaper,
                      size: 2.3.h,
                    ),
                  ),
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 0.4.h, top: 0.8.h),
                    child: Icon(
                      Icons.newspaper,
                      size: 2.3.h,
                    ),
                  ),
                  label: 'News',
                ),
                BottomNavigationBarItem(
                  activeIcon: Padding(
                    padding: EdgeInsets.only(bottom: 0.4.h, top: 0.8.h),
                    child: SvgPicture.asset(
                      'assets/svgs/ic_account.svg',
                      color: const Color(0xFF4791CE),
                      height: 2.h,
                    ),
                  ),
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 0.4.h, top: 0.8.h),
                    child: SvgPicture.asset(
                      'assets/svgs/ic_account.svg',
                      height: 2.h,
                    ),
                  ),
                  label: 'Account',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
