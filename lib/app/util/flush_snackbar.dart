import 'package:another_flushbar/flushbar.dart';
import 'package:sendx/app/extensions/string_ext.dart';
import 'package:sendx/app/services/image_service.dart';
import 'package:sendx/presentation/widgets/sheets/image_picker_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

class FlushSnackbar {
  static void showSnackBar(
    String message, {
    VoidCallback? onPressed,
    bool isError = false,
  }) {
    Flushbar(
      message: message.filterNetConnection.filterServerError,
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(5),
      textDirection: TextDirection.rtl,
      duration: const Duration(seconds: 2),
      leftBarIndicatorColor: isError ? Colors.red : Colors.green,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      blockBackgroundInteraction: true,
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: Colors.grey.shade200,
      messageColor: Get.theme.primaryColor,
      isDismissible: true,
    ).show(Get.context!);
  }
}

class AppDialogs {
  static showPermissionDeniedDialog() {
    showCupertinoDialog<void>(
      context: Get.context!,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(
          'Permission Denied',
          style: TextStyle(
            fontSize: 13.sp,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Text(
                'Plase Allow Permission to use this feature',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black.withOpacity(0.5),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Get.back();
              openAppSettings();
            },
            child: const Text(
              'Setting',
              style: TextStyle(
                fontSize: 14,
                color: Colors.blue,
              ),
            ),
          ),
          CupertinoDialogAction(
            onPressed: () => Get.back(),
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontSize: 14,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppSheets {
  static showImagePickSheet({
    required void Function(ImageSourceWrapper) onImageSelected,
  }) {
    Get.bottomSheet(
      FilePickerBottomSheet(
        onImageSelected: (e) {
          Get.back();
          onImageSelected(e);
        },
      ),
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
    );
  }
}
