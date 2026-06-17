import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/presentation/controller/download_file_controller.dart';
import 'package:sendx/presentation/widgets/dialogs/download_dialog.dart';
import 'package:sendx/presentation/widgets/dialogs/file_upload_dialog.dart';
import 'package:sizer/sizer.dart';

class DownloadButton extends StatelessWidget {
  const DownloadButton({
    super.key,
    required this.showDownloadButton,
    required this.id,
    this.onDone,
    this.fileURL,
  });
  final bool showDownloadButton;
  final int id;
  final VoidCallback? onDone;
  final String? fileURL;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (showDownloadButton && (fileURL?.isNotEmpty ?? false)) {
          final controller = find<FileDownloadController>();
          controller.downloadFile(fileURL!);
          Get.dialog(const DownloadDialog());
        } else {
          Get.dialog(
            FileUploadDialog(
              id: id,
              onDone: onDone,
            ),
          );
        }
      },
      child: Container(
        width: 4.h,
        height: 4.h,
        decoration: const BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            showDownloadButton ? Icons.download : Icons.cloud_upload_outlined,
            color: Colors.white,
            size: 2.3.h,
          ),
        ),
      ),
    );
  }
}
