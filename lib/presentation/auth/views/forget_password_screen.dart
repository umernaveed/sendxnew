import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:sendx/presentation/auth/controllers/forget_password_controller.dart';
import 'package:sendx/presentation/auth/views/login_screen.dart';
import 'package:sendx/presentation/auth/widgets/auth_app_bar.dart';
import 'package:sendx/presentation/base_screen.dart';
import 'package:sizer/sizer.dart';

class ForgetPasswordScreen extends GetView<ForgetPasswordController> {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      wrapWithAnnotatedRegion: true,
      value: SystemUiOverlayStyle.dark,
      resizeToAvoidBottomInset: false,
      appBar: const AuthCustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.w),
          child: FormBuilder(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.5.h),
                Text(
                  'Forget password',
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: const Color(0xFF4791CE),
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  'Email',
                  style: TextStyle(
                    color: const Color(0xFF7C7C7C).withOpacity(0.7),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                FormBuilderTextField(
                  name: 'email',
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email()
                    ],
                  ),
                  decoration: const InputDecoration(
                    hintText: 'imshuvo97@gmail.com',
                  ),
                  style: const TextStyle(
                    color: Color(0xFF181725),
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 4.5.h),
                AppButton(
                  title: 'Submit',
                  onTap: () => controller.onSubmit(),
                ),
                SizedBox(height: 3.h),
                AuthWidgetSpanBuilder(
                  firstTitle: 'Already have an account? ',
                  secondTitle: 'Sign In',
                  onTap: () => Get.back(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
