import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/app/util/flush_snackbar.dart';
import 'package:sendx/presentation/account/controllers/update_profile_controller.dart';
import 'package:sendx/presentation/auth/views/login_screen.dart';
import 'package:sendx/presentation/auth/widgets/auth_app_bar.dart';
import 'package:sendx/presentation/auth/widgets/drop_down.dart';
import 'package:sendx/presentation/auth/widgets/text_field.dart';
import 'package:sendx/presentation/base_screen.dart';
import 'package:sendx/presentation/widgets/cache_image.dart';
import 'package:sizer/sizer.dart';

class UpdateProfileScreen extends GetView<UpdateProfileController> {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      wrapWithAnnotatedRegion: true,
      value: SystemUiOverlayStyle.dark,
      appBar: const AuthCustomAppBar.withSmallAppLogo(),
      body: MixinBuilder<UpdateProfileController>(
        builder: (_) {
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      FormBuilder(
                        key: controller.formKey,
                        clearValueOnUnregister: true,
                        autovalidateMode: AutovalidateMode.disabled,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 2.5.h),
                            Align(
                              alignment: Alignment.topCenter,
                              child: GetBuilder<UpdateProfileController>(
                                id: 'avatar',
                                builder: (_) {
                                  return UserAvatar(
                                    file: controller.file,
                                    imageURL: controller
                                        .accountController.user.value.image,
                                  );
                                },
                              ),
                            ),

                            SizedBox(height: 2.5.h),
                            Text(
                              'Edit Your Profile',
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: const Color(0xFF7C7C7C),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 3.5.h),
                            CustomDropDown<OutLetPair>(
                              name: 'outletId',
                              title: 'Outlet',
                              initialValue:
                                  controller.findOutLetForExsistingUser(
                                      outletId: controller.accountController
                                          .user.value.outletId),
                              onItemSelected: (e) {},
                              hint: 'Select Outlet',
                              items: controller.outLets
                                  .map((e) => OutLetPair(
                                        key: e.outletId,
                                        value: e.outletName,
                                      ))
                                  .toList(),
                            ),
                            SizedBox(height: 3.h),
                            CustomDropDown<NormalString>(
                              name: 'userType',
                              title: 'User Type',
                              initialValue: NormalString(
                                key: controller
                                    .accountController.user.value.userType,
                                value: controller
                                    .accountController.user.value.userType,
                              ),
                              onItemSelected: (e) {
                                if (e == null ||
                                    e.key.isEmpty ||
                                    e.value.isEmpty) return;
                                controller.onUserTypeChange(e.key);
                              },
                              hint: 'Personal',
                              items: const ['Personal', 'Business']
                                  .map((e) => NormalString(key: e, value: e))
                                  .toList(),
                            ),
                            SizedBox(height: 3.h),
                            AppTextField(
                              name: 'firstName',
                              title: 'First name',
                              initialValue: controller
                                  .accountController.user.value.firstName,
                              hint: 'Enter First name',
                              titleColor: const Color(0xFF7C7C7C),
                              onChange: (e) {},
                              validator: FormBuilderValidators.compose(
                                [FormBuilderValidators.required()],
                              ),
                            ),
                            SizedBox(height: 3.h),
                            AppTextField(
                              name: 'lastName',
                              title: 'Last name',
                              hint: 'Enter last name',
                              initialValue: controller
                                  .accountController.user.value.lastName,
                              titleColor: const Color(0xFF7C7C7C),
                              onChange: (e) {},
                              validator: FormBuilderValidators.compose(
                                [FormBuilderValidators.required()],
                              ),
                            ),
                            SizedBox(height: 3.h),
                            AppTextField(
                              name: 'email',
                              title: 'Email',
                              readOnly: true,
                              initialValue:
                                  controller.accountController.user.value.email,
                              hint: 'imshuvo97@gmail.com',
                              titleColor: const Color(0xFF7C7C7C),
                              onChange: (e) {},
                              validator: FormBuilderValidators.compose(
                                [
                                  FormBuilderValidators.required(),
                                  FormBuilderValidators.email(),
                                ],
                              ),
                            ),
                            // SizedBox(height: 3.h),
                            // ValueListenableBuilder<bool>(
                            //   valueListenable: controller.passwordVisibility,
                            //   builder: (context, value, child) {
                            //     return AppTextField(
                            //       name: 'password',
                            //       title: 'Password',
                            //       initialValue: controller.user.password,
                            //       obscureText: value,
                            //       onPasswordToggle: () =>
                            //           controller.onPasswordToggle(),
                            //       type: FieldType.passowrd,
                            //       hintColor: const Color(0x337C7C7C),
                            //       titleColor: const Color(0xFF7C7C7C),
                            //       onChange: (_) {},
                            //       validator: FormBuilderValidators.compose(
                            //         [
                            //           FormBuilderValidators.required(),
                            //           FormBuilderValidators.minLength(6),
                            //         ],
                            //       ),
                            //     );
                            //   },
                            // ),
                            // SizedBox(height: 3.h),
                            // AppTextField(
                            //   name: 'trn',
                            //   title: 'TRN',
                            //   hint: 'TRN #',
                            //   initialValue:
                            //       controller.accountController.user.value.trn,
                            //   titleColor: const Color(0xFF7C7C7C),
                            //   onChange: (e) {},
                            //   validator: FormBuilderValidators.compose(
                            //     [FormBuilderValidators.required()],
                            //   ),
                            // ),
                            SizedBox(height: 3.h),
                            AppTextField(
                              name: 'phone',
                              title: 'Phone (Optional)',
                              hint: 'Phone #',
                              initialValue:
                                  controller.accountController.user.value.phone,
                              titleColor: const Color(0xFF7C7C7C),
                              onChange: (e) {},
                              validator: FormBuilderValidators.compose(
                                [FormBuilderValidators.numeric()],
                              ),
                            ),
                            // SizedBox(height: 3.h),
                            // AppTextField(
                            //   name: 'mobile',
                            //   title: 'Mobile',
                            //   hint: 'Mobile #',
                            //   initialValue: controller
                            //       .accountController.user.value.mobile,
                            //   titleColor: const Color(0xFF7C7C7C),
                            //   onChange: (e) {},
                            //   validator: FormBuilderValidators.compose(
                            //     [
                            //       FormBuilderValidators.required(),
                            //       FormBuilderValidators.numeric()
                            //     ],
                            //   ),
                            // ),
                            // SizedBox(height: 3.h),
                            // const _BusinnesTypeWidgets(),
                            SizedBox(height: 3.h),
                            AppTextField(
                              name: 'address1',
                              title: 'Address 1 (Optional)',
                              hint: 'Address 1',
                              initialValue: controller
                                  .accountController.user.value.address1,
                              titleColor: const Color(0xFF7C7C7C),
                              onChange: (e) {},
                              validator: FormBuilderValidators.compose(
                                [FormBuilderValidators.required()],
                              ),
                            ),
                            // SizedBox(height: 3.h),
                            // AppTextField(
                            //   name: 'address2',
                            //   title: 'Address 2',
                            //   hint: 'Address 2',
                            //   initialValue: controller
                            //       .accountController.user.value.address2,
                            //   titleColor: const Color(0xFF7C7C7C),
                            //   onChange: (e) {},
                            //   validator: FormBuilderValidators.compose(
                            //     [FormBuilderValidators.required()],
                            //   ),
                            // ),
                            // SizedBox(height: 3.h),
                            // AppTextField(
                            //   name: 'city',
                            //   title: 'City',
                            //   hint: 'City',
                            //   initialValue:
                            //       controller.accountController.user.value.city,
                            //   titleColor: const Color(0xFF7C7C7C),
                            //   onChange: (e) {},
                            //   validator: FormBuilderValidators.compose(
                            //     [FormBuilderValidators.required()],
                            //   ),
                            // ),
                            // SizedBox(height: 3.h),
                            // AppTextField(
                            //   name: 'state',
                            //   title: 'State/Parish',
                            //   hint: 'State/Parish',
                            //   initialValue:
                            //       controller.accountController.user.value.state,
                            //   titleColor: const Color(0xFF7C7C7C),
                            //   onChange: (e) {},
                            //   validator: FormBuilderValidators.compose(
                            //     [FormBuilderValidators.required()],
                            //   ),
                            // ),
                            // SizedBox(height: 3.h),
                            // CustomDropDown<NormalString>(
                            //   name: 'country',
                            //   title: 'Country',
                            //   initialValue: NormalString(
                            //     key: 'Jamaica',
                            //     value: 'Jamaica',
                            //   ),
                            //   onItemSelected: (e) {},
                            //   hint: 'Select Country ',
                            //   items: const ['Jamaica']
                            //       .map((e) => NormalString(key: e, value: e))
                            //       .toList(),
                            // ),
                            // SizedBox(height: 3.h),
                            // CustomDropDown<NormalString>(
                            //   name: 'currency',
                            //   title: 'Currency',
                            //   initialValue: NormalString(
                            //     value: controller
                            //         .accountController.user.value.currency,
                            //     key: controller
                            //         .accountController.user.value.currency,
                            //   ),
                            //   onItemSelected: (e) {},
                            //   hint: 'Select Currency ',
                            //   items: const ['JMD']
                            //       .map((e) => NormalString(value: e, key: e))
                            //       .toList(),
                            // ),
                            SizedBox(height: 5.h),
                            AppButton(
                              title: 'Update',
                              onTap: () {
                                controller.onUpdate();
                              },
                            ),
                            SizedBox(height: 5.h),
                          ],
                        ),
                      ),
                    ],
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

class _BusinnesTypeWidgets extends GetView<UpdateProfileController> {
  const _BusinnesTypeWidgets();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: controller.isTypeBusinnes.value,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppDatePicker(
              title: 'TCC Issue Date',
              hint: 'TCC Issue Date',
              name: 'tccIssueDate',
              initialDate: controller
                      .accountController.user.value.tccIssueDate.isNotEmpty
                  ? DateTime.parse(
                      controller.accountController.user.value.tccIssueDate)
                  : null,
            ),
            SizedBox(height: 3.h),
            AppDatePicker(
              title: 'TCC Expiry Date',
              hint: 'TCC Expiry Date',
              name: 'tccExpiryDate',
              initialDate: controller
                      .accountController.user.value.tccExpiryDate.isNotEmpty
                  ? DateTime.parse(
                      controller.accountController.user.value.tccExpiryDate)
                  : null,
            ),
            SizedBox(height: 3.h),
            AppTextField(
              name: 'businessTrn',
              title: 'Business TRN #',
              hint: 'Business TRN #',
              initialValue: controller.accountController.user.value.businessTrn,
              titleColor: const Color(0xFF7C7C7C),
              onChange: (e) {},
              validator: FormBuilderValidators.compose(
                [FormBuilderValidators.required()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppDatePicker extends StatelessWidget {
  final String title;
  final String hint;
  final String name;
  final DateTime? initialDate;
  final InputDecoration? decoration;
  final double? spaceBTW;
  const AppDatePicker({
    super.key,
    required this.title,
    required this.hint,
    required this.name,
    this.initialDate,
    this.decoration,
    this.spaceBTW,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: const Color(0xFF7C7C7C),
            fontSize: 11.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: spaceBTW),
        FormBuilderDateTimePicker(
          name: name,
          format: DateFormat('yyyy-MM-dd'),
          enabled: true,
          initialDate: initialDate,
          inputType: InputType.date,
          initialValue: initialDate,
          onChanged: (e) {},
          style: context.textTheme.bodyMedium?.copyWith(
            color: Colors.black,
            fontSize: 11.sp,
            fontWeight: FontWeight.w400,
          ),
          decoration: decoration ??
              InputDecoration(
                suffixIcon: const Icon(
                  Icons.calendar_today,
                  color: Color(0xFF4791CE),
                ),
                hintText: hint,
                hintStyle: context.textTheme.bodyMedium?.copyWith(
                  color: const Color(0x337C7C7C),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
        ),
      ],
    );
  }
}

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, required this.file, required this.imageURL});
  final File? file;
  final String imageURL;

  @override
  Widget build(BuildContext context) {
    final isFileToSow = file?.path.isNotEmpty ?? false;
    final showPlaceHolder = file == null && imageURL.isEmpty;
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(0.1.h),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            shape: BoxShape.circle,
          ),
          child: switch (showPlaceHolder) {
            true => _ProfilePlaceHolder(
                url: 'assets/svgs/ic_person_profile.svg',
                width: 13.h,
                height: 13.h,
              ),
            false => switch (isFileToSow) {
                true => _FileImage(
                    file: file!,
                    width: 13.h,
                    height: 13.h,
                  ),
                false => CachedImage(
                    imageUrl: imageURL,
                    width: 13.h,
                    height: 13.h,
                    circular: true,
                  ),
              },
          },
        ),
        // Positioned widget for camera icon at bottom right
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              AppSheets.showImagePickSheet(
                onImageSelected: (e) {
                  final controller = find<UpdateProfileController>();
                  controller.onImageSourceSelect(
                    sourceWrapper: e,
                  );
                },
              );
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(0.5.h),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(
                Icons.camera_alt,
                color: Colors.black,
                size: 2.5.h,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FileImage extends StatelessWidget {
  const _FileImage(
      {required this.file, required this.height, required this.width});
  final File file;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Image.file(
          file,
          height: height,
          width: width,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class _ProfilePlaceHolder extends StatelessWidget {
  const _ProfilePlaceHolder({
    required this.url,
    required this.height,
    required this.width,
  });
  final String url;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(2.h),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          url,
          height: height,
          width: width,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
