import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:sendx/app/core/routes/app_pages.dart';
import 'package:sendx/app/core/theme/app_colors.dart';
import 'package:sendx/app/util/flush_snackbar.dart';
import 'package:sendx/presentation/auth/controllers/login_controller.dart';
import 'package:sendx/presentation/auth/widgets/auth_app_bar.dart';
import 'package:sendx/presentation/base_screen.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      wrapWithAnnotatedRegion: true,
      value: SystemUiOverlayStyle.dark,
      appBar: const AuthCustomAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.w),
          child: FormBuilder(
            key: controller.formKey,
            clearValueOnUnregister: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 1.5.h),
                Text(
                  'Log In',
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: AppColors.ink,
                    fontSize: 26,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: .5.h),
                Text(
                  'Enter your emails and password',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.muted,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  'Email',
                  style: TextStyle(
                    color: AppColors.charcoal,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                FormBuilderTextField(
                  name: 'email',
                  decoration: const InputDecoration(
                    hintText: 'imshuvo97@gmail.com',
                  ),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email()
                    ],
                  ),
                  style: const TextStyle(
                    color: AppColors.ink,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Password',
                  style: TextStyle(
                    color: AppColors.charcoal,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ValueListenableBuilder<bool>(
                    valueListenable: controller.passwordVisibility,
                    builder: (context, value, child) {
                      return FormBuilderTextField(
                        name: 'password',
                        obscureText: value,
                        obscuringCharacter: '*',
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(),
                            FormBuilderValidators.minLength(6)
                          ],
                        ),
                        style: const TextStyle(
                          color: AppColors.ink,
                          fontSize: 16,
                          letterSpacing: 3,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          hintText: '*******',
                          suffixIcon: IconButton(
                            onPressed: () => controller.onPasswordToggle(),
                            icon: Icon(
                              !value ? Icons.visibility_off : Icons.visibility,
                            ),
                          ),
                        ),
                      );
                    }),
                SizedBox(height: 0.2.h),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () => Get.toNamed(AppPages.forgetPassword),
                    child: Text(
                      'Forgot Password?',
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: AppColors.cyan,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 3.h),
                AppButton(
                  title: 'Log In',
                  onTap: () {
                    controller.onLoginPress().then((value) {
                      final isDone = value.isDone;
                      final message = value.message;
                      if (isDone) {
                        Get.offAllNamed(AppPages.bottomNav);
                      } else {
                        if (message.isEmpty) return;
                        FlushSnackbar.showSnackBar(message);
                      }
                    });
                  },
                ),
                SizedBox(height: 3.h),
                AuthWidgetSpanBuilder(
                  firstTitle: "Don't have an account? ",
                  secondTitle: 'Signup',
                  onTap: () => Get.toNamed(AppPages.signUp),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AuthWidgetSpanBuilder extends StatelessWidget {
  const AuthWidgetSpanBuilder(
      {super.key,
      required this.firstTitle,
      required this.secondTitle,
      this.onTap});
  final String firstTitle;
  final String secondTitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: firstTitle,
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.ink,
                fontSize: 9.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            WidgetSpan(
              child: InkWell(
                splashColor: AppColors.cyan.withOpacity(0.1),
                borderRadius: BorderRadius.circular(3),
                onTap: onTap,
                child: Text(
                  secondTitle,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.coral,
                    fontSize: 10.5.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final BorderSide side;
  final double buttonBorderRadius;

  /// .h is internaly used
  final double height;
  final double? width;
  final double? fontSize;
  const AppButton({
    super.key,
    required this.title,
    this.onTap,
    this.backgroundColor,
    this.textColor,
    this.side = BorderSide.none,
    this.buttonBorderRadius = 19,
    this.height = 6.9,
    this.fontSize,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final isDefaultButton = backgroundColor == null && side == BorderSide.none;
    return SizedBox(
      width: width ?? context.width,
      height: height.h,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: onTap != null && isDefaultButton ? AppColors.brandGradient : null,
          color: isDefaultButton
              ? (onTap == null ? Colors.black12.withOpacity(0.08) : null)
              : backgroundColor,
          borderRadius: BorderRadius.circular(buttonBorderRadius),
          boxShadow: onTap != null && isDefaultButton
              ? [
                  BoxShadow(
                    color: AppColors.cyan.withOpacity(0.28),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
        ),
        child: TextButton(
          style: TextButton.styleFrom(
            disabledBackgroundColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonBorderRadius),
              side: side,
            ),
          ),
          onPressed: onTap,
          child: Text(
            title,
            style: TextStyle(
              color: textColor ?? const Color(0xFFFFF9FF),
              fontSize: fontSize ?? 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
