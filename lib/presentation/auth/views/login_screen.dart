import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:sendx/app/core/routes/app_pages.dart';
import 'package:sendx/app/core/theme/app_colors.dart';
import 'package:sendx/app/util/flush_snackbar.dart';
import 'package:sendx/presentation/auth/controllers/login_controller.dart';
import 'package:sendx/presentation/base_screen.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      wrapWithAnnotatedRegion: true,
      value: SystemUiOverlayStyle.dark,
      showGradients: false,
      backgroundColor: const Color(0xFFF8FBFF),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFF8FBFF),
              Color(0xFFEFF8FF),
            ],
            stops: [0, 0.58, 1],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.fromLTRB(5.8.w, 1.8.h, 5.8.w, 4.h),
              child: FormBuilder(
                key: controller.formKey,
                clearValueOnUnregister: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 40,
                        minHeight: 40,
                      ),
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Color(0xFF07132D),
                        size: 26,
                      ),
                      onPressed: () => Get.back(),
                    ),
                    SizedBox(height: 3.2.h),
                    Center(
                      child: SvgPicture.asset(
                        'assets/svgs/app_logo_sendx.svg',
                        width: 42.w,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 5.4.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(5.8.w, 4.8.h, 5.8.w, 3.6.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFB9DFFF).withOpacity(0.35),
                            blurRadius: 28,
                            offset: const Offset(0, 18),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEAF5FF),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.cyan.withOpacity(0.18),
                                      blurRadius: 18,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.lock_outline_rounded,
                                  color: Color(0xFF147EDB),
                                  size: 38,
                                ),
                              ),
                              SizedBox(width: 4.2.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Welcome Back',
                                      style: context.textTheme.titleLarge?.copyWith(
                                        color: const Color(0xFF07132D),
                                        fontSize: 25,
                                        fontWeight: FontWeight.w700,
                                        height: 1.12,
                                      ),
                                    ),
                                    SizedBox(height: .8.h),
                                    Text(
                                      'Login to your SendX account',
                                      style: context.textTheme.bodyMedium?.copyWith(
                                        color: const Color(0xFF8A8D98),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.7.h),
                          _AuthLabel(text: 'Email'),
                          SizedBox(height: 1.2.h),
                          FormBuilderTextField(
                            name: 'email',
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            decoration: _inputDecoration(
                              hintText: 'Enter your email',
                              prefixIcon: Icons.mail_outline_rounded,
                            ),
                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.required(),
                                FormBuilderValidators.email(),
                              ],
                            ),
                            style: _fieldTextStyle,
                          ),
                          SizedBox(height: 3.6.h),
                          _AuthLabel(text: 'Password'),
                          SizedBox(height: 1.2.h),
                          ValueListenableBuilder<bool>(
                            valueListenable: controller.passwordVisibility,
                            builder: (context, value, child) {
                              return FormBuilderTextField(
                                name: 'password',
                                obscureText: value,
                                obscuringCharacter: '*',
                                textInputAction: TextInputAction.done,
                                validator: FormBuilderValidators.compose(
                                  [
                                    FormBuilderValidators.required(),
                                    FormBuilderValidators.minLength(6),
                                  ],
                                ),
                                style: _fieldTextStyle,
                                decoration: _inputDecoration(
                                  hintText: 'Enter your password',
                                  prefixIcon: Icons.lock_outline_rounded,
                                  suffixIcon: IconButton(
                                    onPressed: () => controller.onPasswordToggle(),
                                    icon: Icon(
                                      value
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: const Color(0xFF747780),
                                      size: 29,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 1.6.h),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(0, 36),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () => Get.toNamed(AppPages.forgetPassword),
                              child: Text(
                                'Forgot Password?',
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: const Color(0xFF168BDE),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 3.2.h),
                          _GradientLoginButton(onTap: _onLoginTap),
                          SizedBox(height: 4.h),
                          AuthWidgetSpanBuilder(
                            firstTitle: "Don't have an account? ",
                            secondTitle: 'Signup',
                            onTap: () => Get.toNamed(AppPages.signUp),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static const TextStyle _fieldTextStyle = TextStyle(
    color: Color(0xFF07132D),
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  InputDecoration _inputDecoration({
    required String hintText,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
        color: Color(0xFF9B9EA8),
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 18, right: 13),
        child: Icon(
          prefixIcon,
          color: Color(0xFF147EDB),
          size: 28,
        ),
      ),
      prefixIconConstraints: const BoxConstraints(
        minWidth: 58,
        minHeight: 58,
      ),
      suffixIcon: suffixIcon,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 21,
      ),
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Color(0xFFD7E9F8),
          width: 1.3,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Color(0xFF93C9F2),
          width: 1.6,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: AppColors.coral,
          width: 1.2,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: AppColors.coral,
          width: 1.4,
        ),
      ),
    );
  }

  void _onLoginTap() {
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
  }
}

class _AuthLabel extends StatelessWidget {
  const _AuthLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.textTheme.bodyMedium?.copyWith(
        color: const Color(0xFF07132D),
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _GradientLoginButton extends StatelessWidget {
  const _GradientLoginButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: AppColors.brandGradient,
        borderRadius: BorderRadius.circular(17),
        boxShadow: [
          BoxShadow(
            color: AppColors.coral.withOpacity(0.22),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: AppColors.cyan.withOpacity(0.18),
            blurRadius: 20,
            offset: const Offset(-8, 8),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 6.9.h,
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17),
            ),
          ),
          onPressed: onTap,
          child: const Stack(
            alignment: Alignment.center,
            children: [
              Text(
                'Log In',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 14),
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                    size: 31,
                  ),
                ),
              ),
            ],
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
