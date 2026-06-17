import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sendx/presentation/controller/download_file_controller.dart';
import 'package:sizer/sizer.dart';

class DownloadDialog extends GetView<FileDownloadController> {
  const DownloadDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetAnimationCurve: Curves.bounceInOut,
      insetAnimationDuration: 2.seconds,
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Container(
            width: context.width,
            padding:
                EdgeInsets.only(left: 4.w, right: 4.w, top: 2.h, bottom: 1.3.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 1.h),
                const Text('Downloading File'),
                SizedBox(height: 2.h),
                Obx(
                  () => LinearProgressIndicator(
                    value: controller.isDonwloadingDone.value ? 1 : 0.2,
                    minHeight: 10.0,
                    borderRadius: BorderRadius.circular(10),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 1.1.w,
            top: 1.h,
            child: Container(
              height: 3.4.h,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFF2F3F2),
              ),
              child: IconButton(
                splashColor: Colors.blue,
                splashRadius: 10,
                padding: EdgeInsets.zero,
                highlightColor: Colors.blue,
                onPressed: () {
                  controller.clear();
                  Get.back();
                },
                icon: Icon(
                  Icons.close,
                  size: 2.h,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
