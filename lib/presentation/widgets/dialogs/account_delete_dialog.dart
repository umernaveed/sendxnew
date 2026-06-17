import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sendx/presentation/auth/views/login_screen.dart';
import 'package:sizer/sizer.dart';

class AccountDeleteConfirmationDialog extends StatelessWidget {
  const AccountDeleteConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
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
              'A New Version of SendX is available ',
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
                  child: AppButton(
                    title: 'Update',
                    buttonBorderRadius: 5,
                    backgroundColor: Colors.red,
                    onTap: () {},
                  ),
                ),
                SizedBox(width: 1.h),
                Expanded(
                  child: AppButton(
                    title: 'Cancel',
                    buttonBorderRadius: 5,
                    onTap: () => Get.back(),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
