import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/presentation/auth/views/login_screen.dart';
import 'package:sendx/presentation/dashboard/controllers/dashboard_controller.dart';
import 'package:sizer/sizer.dart';

class AppUpdateDialog extends StatelessWidget {
  const AppUpdateDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 1.h),
            Text(
              'App Update',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              'A new version of sendX is Available.\n Do you want to Upgrade?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 3.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 5.5.h,
                    child: AppButton(
                      title: 'Later',
                      buttonBorderRadius: 5,
                      backgroundColor: Colors.red,
                      onTap: () => Get.back(),
                    ),
                  ),
                ),
                SizedBox(width: 1.h),
                Expanded(
                  child: SizedBox(
                    height: 5.5.h,
                    child: AppButton(
                      title: 'Upgrade',
                      buttonBorderRadius: 5,
                      onTap: () {
                        Get.back();
                        final bNC = find<DashboardController>();
                        bNC.launchStore();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
