import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sendx/data/models/requests/upload_invoice_request/upload_invoice_request.dart';
import 'package:sendx/presentation/auth/views/login_screen.dart';
import 'package:sendx/presentation/controller/file_upload_controller.dart';
import 'package:sizer/sizer.dart';

class FileUploadDialog extends GetView<FileUploadController> {
  FileUploadDialog({
    super.key,
    required int id,
    this.onDone,
  }) : _id = id {
    controller.onDone = onDone;
  }
  final int _id;
  final VoidCallback? onDone;

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
                SizedBox(height: 2.h),
                const Text('Upload File'),
                SizedBox(height: 2.h),
                const _FilePickerWidget(),
                SizedBox(height: 2.h),
                GetBuilder<FileUploadController>(
                  id: 'fileBuilder',
                  builder: (_) {
                    return controller.uploadProgress > 0
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: controller.uploadProgress / 100,
                              minHeight: 20.0,
                            ),
                          )
                        : AppButton(
                            title: 'Upload',
                            buttonBorderRadius: 5,
                            height: 6,
                            fontSize: 11.sp,
                            onTap: controller.file == null
                                ? null
                                : () {
                                    controller.uploadFile(
                                      UploadInvoiceRequest(packegId: _id),
                                    );
                                  },
                          );
                  },
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
                  controller.clearFile();
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

class _FilePickerWidget extends GetView<FileUploadController> {
  const _FilePickerWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
      decoration: ShapeDecoration(
        color: const Color(0xFFEFEFEF),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: Colors.black.withOpacity(0.30000001192092896),
          ),
          borderRadius: BorderRadius.circular(3),
        ),
      ),
      child: GetBuilder<FileUploadController>(
        id: 'fileBuilder',
        builder: (_) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (controller.file == null) ...[
                Text(
                  'No file choosen',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10.5.sp,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ] else ...[
                Expanded(
                  child: Text(
                    controller.file?.path.split('.').last ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.black,
                      fontSize: 10.5.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
              InkWell(
                onTap: () {
                  // controller.pickFile();
                  _showPickerSheet(
                    context,
                    onFilePicker: () => controller.pickFile(isImage: false),
                    onImagePicker: () => controller.pickFile(isImage: true),
                  );
                },
                child: Container(
                  width: 4.h,
                  height: 4.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFEFEF),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black.withOpacity(0.30000001192092896),
                    ),
                  ),
                  child: Icon(
                    Icons.attach_file,
                    size: 2.3.h,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

void _showPickerSheet(
  BuildContext context, {
  VoidCallback? onImagePicker,
  VoidCallback? onFilePicker,
}) {
  showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      title: const Text('Select Picker Type'),
      message: const Text('Please choose whether to pick an image or a file.'),
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          child: const Text(
            'Image',
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
          onPressed: () {
            onImagePicker?.call();
            Get.back();
          },
        ),
        CupertinoActionSheetAction(
          child: const Text(
            'File',
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
          onPressed: () {
            onFilePicker?.call();
            Get.back();
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: () => Get.back(),
        child: const Text(
          'Cancel',
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      ),
    ),
  );
}
