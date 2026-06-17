import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/app/util/flush_snackbar.dart';
import 'package:sendx/data/models/all_authorize_users_response/all_authorize_users_response.dart';
import 'package:sendx/presentation/account/views/account_screen.dart';
import 'package:sendx/presentation/auth/views/login_screen.dart';
import 'package:sendx/presentation/auth/widgets/auth_app_bar.dart';
import 'package:sendx/presentation/auth/widgets/text_field.dart';
import 'package:sendx/presentation/authorize/controllers/add_authorize_user_controller.dart';
import 'package:sendx/presentation/base_screen.dart';
import 'package:sendx/presentation/bottom_nav/controllers/bottom_nav_controller.dart';
import 'package:sizer/sizer.dart';

class AddAuthorizeUser extends GetView<AddAuthorizeUserController> {
  const AddAuthorizeUser({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final isEditing = args == null ? false : true;
    final user = isEditing
        ? args as AuthorizeUsersResponse
        : AuthorizeUsersResponse.empty();

    return BaseScreen(
      wrapWithAnnotatedRegion: true,
      value: SystemUiOverlayStyle.dark,
      backgroundColor: const Color(0xFFFAF4F2).withOpacity(0.4),
      appBar: const AuthCustomAppBar.withSmallAppLogo(
        backButtonVisible: true,
        usingNavigator: true,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Container(
          width: context.width,
          margin: EdgeInsets.only(left: 6.w, right: 6.w, top: 2.h, bottom: 2.h),
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
          child: FormBuilder(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: 3.w, right: 5.w, top: 3.h, bottom: 2.h),
                  child: Text(
                    isEditing ? 'Update Authorize User' : 'Add Authorize User',
                    style: TextStyle(
                      color: const Color(0xFF4791CE),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const AppDivider(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                  child: Column(
                    children: [
                      AppTextField(
                        title: 'Name',
                        hint: 'Name',
                        name: 'name',
                        initialValue: user.name,
                        validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required()],
                        ),
                      ),
                      SizedBox(height: 3.h),
                      AppTextField(
                        title: 'Phone #',
                        hint: 'Phone #',
                        name: 'phone',
                        initialValue: user.phone,
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(),
                            FormBuilderValidators.numeric(),
                          ],
                        ),
                      ),
                      SizedBox(height: 3.h),
                      AppTextField(
                        title: 'ID/Proof',
                        hint: 'ID/Proof',
                        name: 'proof',
                        initialValue: user.proof,
                        validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required()],
                        ),
                      ),
                      SizedBox(height: 5.h),
                      AppButton(
                        title: 'Submit',
                        onTap: () {
                          final bottomNavNestedID =
                              find<BottomNavController>().bottomNavNestedID;
                          controller
                              .onSubmit(
                                  isEditing: isEditing, idForUpdate: user.id)
                              .then((value) {
                            final isDone = value.isDone;
                            final message = value.message;
                            if (isDone) {
                              Get.back(id: bottomNavNestedID);
                              if (message.isEmpty) return;
                              FlushSnackbar.showSnackBar(message);
                            }
                          });
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AccountHolderInfo extends StatelessWidget {
  const _AccountHolderInfo();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: 4.h,
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      margin: EdgeInsets.only(left: 6.5.w, right: 6.5.w, top: 2.h),
      decoration: ShapeDecoration(
        color: const Color(0xFFF4F4F4),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: Colors.black.withOpacity(0.30000001192092896),
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Rizwan javed Account no: SPJ-06849',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF7C7C7C),
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SvgPicture.asset('assets/svgs/ic_drop_down.svg')
        ],
      ),
    );
  }
}
