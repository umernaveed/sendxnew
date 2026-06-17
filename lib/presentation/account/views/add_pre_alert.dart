import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:sendx/app/util/flush_snackbar.dart';
import 'package:sendx/presentation/account/controllers/add_alert_controller.dart';
import 'package:sendx/presentation/account/views/account_screen.dart';
import 'package:sendx/presentation/auth/views/login_screen.dart';
import 'package:sendx/presentation/auth/widgets/auth_app_bar.dart';
import 'package:sendx/presentation/auth/widgets/text_field.dart';
import 'package:sendx/presentation/base_screen.dart';
import 'package:sizer/sizer.dart';

class AddPreAlertScreen extends GetView<AddPreAlertController> {
  const AddPreAlertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      wrapWithAnnotatedRegion: true,
      backgroundColor: const Color(0xFFFAF4F2).withOpacity(0.4),
      value: SystemUiOverlayStyle.dark,
      appBar: const AuthCustomAppBar.withSmallAppLogo(
        backButtonVisible: true,
        usingNavigator: true,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Container(
          width: context.width,
          margin: EdgeInsets.only(left: 6.w, right: 6.w, top: 1.h, bottom: 2.h),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(3),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x19000000),
                blurRadius: 4,
                offset: Offset(0, 3),
                spreadRadius: 2,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: 3.w, right: 5.w, top: 3.h, bottom: 2.h),
                child: Text(
                  'Add Pre-Alert',
                  style: TextStyle(
                    color: const Color(0xFF4791CE),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const AppDivider(),
              // const AccountHolderInfo(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                child: FormBuilder(
                  key: controller.formKey,
                  clearValueOnUnregister: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextField(
                        title: 'Name',
                        hint: 'Name',
                        name: 'nick_name',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      SizedBox(height: 3.h),
                      AppTextField(
                        title: 'Merchant',
                        hint: 'Merchant',
                        name: 'merchant',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      SizedBox(height: 3.h),
                      AppTextField(
                        title: 'Carrier',
                        hint: 'Carrier',
                        name: 'courier',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      SizedBox(height: 3.h),
                      AppTextField(
                        title: 'Carrier tracking number',
                        hint: 'Carrier tracking number',
                        maxLines: 10,
                        minLines: 5,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.multiline,
                        type: FieldType.normal,
                        name: 'supplier_tracking_no',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      SizedBox(height: 3.h),
                      AppTextField(
                        title: 'Weight',
                        hint: 'Weight',
                        maxLines: 10,
                        minLines: 5,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.multiline,
                        type: FieldType.normal,
                        name: 'weight',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      SizedBox(height: 3.h),
                      AppTextField(
                        title: 'Value (US \$)',
                        hint: 'Value (US \$)',
                        maxLines: 10,
                        minLines: 5,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.multiline,
                        type: FieldType.normal,
                        name: 'price',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      SizedBox(height: 3.h),
                      AppTextField(
                        title: 'Description',
                        hint: 'Description',
                        maxLines: 10,
                        minLines: 5,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.multiline,
                        type: FieldType.normal,
                        name: 'item_description',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        'Attach an invoice',
                        style: TextStyle(
                          color: const Color(0xFF7C7C7C),
                          fontSize: 10.6.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      const FilePickerWidget(),
                      SizedBox(height: 3.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: AppButton(
                              title: 'Submit',
                              onTap: () {
                                controller.onSubmit().then((value) {
                                  final isDone = value.isDone;
                                  final message = value.message;
                                  if (isDone) {
                                    Get.back();
                                    if (message.isEmpty) return;
                                    FlushSnackbar.showSnackBar(message);
                                  }
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 6.2.w),
                          Expanded(
                            child: AppButton(
                              title: 'Clear',
                              onTap: () {
                                controller.clearFile();
                              },
                              backgroundColor: Colors.white,
                              side: BorderSide(
                                width: 1,
                                color: Colors.black
                                    .withOpacity(0.30000001192092896),
                              ),
                              textColor: const Color(0xFF7C7C7C),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FilePickerWidget extends StatelessWidget {
  const FilePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddPreAlertController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => Container(
            padding: EdgeInsets.symmetric(vertical: 1.h),
            width: context.width,
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
            child: controller.pickedFile.value.path.isEmpty
                ? Padding(
                    padding: EdgeInsets.only(left: 2.w),
                    child: Text(
                      'No file choosen',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10.5.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(left: 2.w),
                    child: Row(
                      children: [
                        const Icon(Icons.file_open_rounded),
                        SizedBox(width: 2.w),
                        Flexible(
                          child: Text(
                            controller.pickedFileName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10.5.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
        Obx(
          () => Visibility(
            visible: !controller.isFilePicked,
            child: Text(
              controller.filePickError.value,
              style: TextStyle(
                color: Colors.red,
                fontSize: 10.5.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        SizedBox(height: 3.w),
        Obx(
          () => Visibility(
            visible: !controller.isFilePicked,
            child: GestureDetector(
              onTap: () {
                controller.pickFile();
              },
              child: Container(
                width: 131,
                height: 35,
                alignment: Alignment.center,
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
                child: Text(
                  'Choose File',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10.5.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
