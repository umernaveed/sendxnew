import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sendx/app/core/routes/app_pages.dart';
import 'package:sendx/presentation/auth/controllers/signup_controller.dart';
import 'package:sendx/presentation/auth/views/login_screen.dart';
import 'package:sendx/presentation/auth/widgets/auth_app_bar.dart';
import 'package:sendx/presentation/auth/widgets/drop_down.dart';
import 'package:sendx/presentation/auth/widgets/text_field.dart';
import 'package:sendx/presentation/base_screen.dart';
import 'package:sizer/sizer.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      wrapWithAnnotatedRegion: true,
      value: SystemUiOverlayStyle.dark,
      appBar: const AuthCustomAppBar(),
      body: CustomScrollView(
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
                        SizedBox(height: 1.5.h),
                        Text(
                          'Sign Up',
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: const Color(0xFF4791CE),
                            fontSize: 26,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: .5.h),
                        Text(
                          'Enter your credentials to continue',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF7C7C7C),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 3.5.h),
                        GetBuilder<SignUpController>(
                          id: 'managers',
                          builder: (_) {
                            return _.managers.managers.isEmpty
                                ? const SizedBox.shrink()
                                : CustomDropDown<OutLetPair>(
                                    name: 'managerId',
                                    title: 'Managers (Optional)',
                                    onItemSelected: (e) {},
                                    validator: FormBuilderValidators.compose(
                                      [],
                                    ),
                                    hint: 'Select Manager',
                                    items: controller.managers.managers
                                        .map(
                                          (e) => OutLetPair(
                                            key: e.id.toString(),
                                            value: e.name,
                                          ),
                                        )
                                        .toList(),
                                  );
                          },
                        ),
                        SizedBox(height: 3.5.h),
                        GetBuilder<SignUpController>(
                          id: 'outLet',
                          builder: (_) {
                            return CustomDropDown<OutLetPair>(
                              name: 'outletId',
                              title: 'Outlet',
                              onItemSelected: (e) {},
                              hint: 'Select Outlet',
                              items: controller.outLet.outLets
                                  .map(
                                    (e) => OutLetPair(
                                      key: e.outletId,
                                      value: e.outletName,
                                    ),
                                  )
                                  .toList(),
                            );
                          },
                        ),
                        SizedBox(height: 3.h),
                        CustomDropDown<NormalString>(
                          name: 'userType',
                          title: 'User Type',
                          onItemSelected: (e) {
                            controller.onUserTypeSelect(e?.key ?? 'Personal');
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
                        SizedBox(height: 3.h),
                        AppTextField(
                          name: 'confirm_email',
                          title: 'Confirm Email',
                          hint: 'imshuvo97@gmail.com',
                          titleColor: const Color(0xFF7C7C7C),
                          onChange: (e) {},
                          validator: FormBuilderValidators.compose(
                            [
                              FormBuilderValidators.required(),
                              FormBuilderValidators.email(),
                              (value) {
                                final email = controller.formKey.currentState
                                    ?.instantValue['email'];
                                return value?.toLowerCase() ==
                                        email.toLowerCase()
                                    ? null
                                    : 'Emails do not match';
                              }
                            ],
                          ),
                        ),
                        SizedBox(height: 3.h),
                        ValueListenableBuilder<bool>(
                            valueListenable: controller.passwordVisibility,
                            builder: (context, value, child) {
                              return AppTextField(
                                name: 'password',
                                title: 'Password',
                                obscureText: value,
                                onPasswordToggle: () =>
                                    controller.onPasswordToggle(),
                                type: FieldType.passowrd,
                                hintColor: const Color(0x337C7C7C),
                                titleColor: const Color(0xFF7C7C7C),
                                onChange: (_) {},
                                validator: FormBuilderValidators.compose(
                                  [
                                    FormBuilderValidators.required(),
                                    FormBuilderValidators.minLength(6),
                                  ],
                                ),
                              );
                            }),
                        SizedBox(height: 3.h),
                        ValueListenableBuilder<bool>(
                            valueListenable:
                                controller.confirmPasswordVisibility,
                            builder: (context, value, child) {
                              return AppTextField(
                                name: 'confirm_password',
                                title: 'Re-type password',
                                type: FieldType.passowrd,
                                obscureText: value,
                                titleColor: const Color(0xFF7C7C7C),
                                onPasswordToggle: () =>
                                    controller.onConfirmPasswordToggle(),
                                onChange: (e) {},
                                validator: FormBuilderValidators.compose(
                                  [
                                    FormBuilderValidators.required(),
                                    FormBuilderValidators.minLength(6),
                                    (value) {
                                      final pwd = controller
                                          .formKey
                                          .currentState
                                          ?.instantValue['password'];
                                      return value?.toLowerCase() ==
                                              pwd.toLowerCase()
                                          ? null
                                          : 'Passwords do not match';
                                    }
                                  ],
                                ),
                              );
                            }),
                        // SizedBox(height: 3.h),
                        // AppTextField(
                        //   name: 'trn',
                        //   title: 'TRN',
                        //   hint: 'TRN #',
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
                          titleColor: const Color(0xFF7C7C7C),
                          onChange: (e) {},
                          // validator: FormBuilderValidators.compose(
                          //   [FormBuilderValidators.required()],
                          // ),
                        ),

                        SizedBox(height: 3.h),
                        AppTextField(
                          name: 'refferal_code',
                          title: 'Refferal Code (Optional)',
                          hint: 'Enter Refferal Code',
                          titleColor: const Color(0xFF7C7C7C),
                          onChange: (e) {},
                          // validator: FormBuilderValidators.compose(
                          //   [FormBuilderValidators.required()],
                          // ),
                        ),
                        // SizedBox(height: 3.h),
                        // AppTextField(
                        //   name: 'address2',
                        //   title: 'Address 2',
                        //   hint: 'Address 2',
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
                        //   onItemSelected: (e) {},
                        //   hint: 'Select Currency ',
                        //   items: const ['JMD']
                        //       .map((e) => NormalString(value: e, key: e))
                        //       .toList(),
                        // ),
                        SizedBox(height: 5.h),
                        AppButton(
                          title: 'Create New Account',
                          onTap: () {
                            controller.onSignUpPress();
                          },
                        ),
                        SizedBox(height: 1.7.h),
                        AuthWidgetSpanBuilder(
                          firstTitle: 'Already have an account? ',
                          secondTitle: 'Log in',
                          onTap: () => Get.offAllNamed(AppPages.login),
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
      ),
    );
  }
}

class _BusinnesTypeWidgets extends StatelessWidget {
  const _BusinnesTypeWidgets();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
      id: 'onUserTypeSelect',
      builder: (_) {
        return Visibility(
          visible: _.isTypeBusinnes,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppDatePicker(
                title: 'TCC Issue Date',
                hint: 'TCC Issue Date',
                name: 'tccIssueDate',
              ),
              SizedBox(height: 3.h),
              const AppDatePicker(
                title: 'TCC Expiry Date',
                hint: 'TCC Expiry Date',
                name: 'tccExpiryDate',
              ),
              SizedBox(height: 3.h),
              AppTextField(
                name: 'businessTrn',
                title: 'Business TRN #',
                hint: 'Business TRN #',
                titleColor: const Color(0xFF7C7C7C),
                onChange: (e) {},
                validator: FormBuilderValidators.compose(
                  [FormBuilderValidators.required()],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class AppDatePicker extends StatelessWidget {
  final String title;
  final String hint;
  final String name;
  const AppDatePicker({
    super.key,
    required this.title,
    required this.hint,
    required this.name,
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
        FormBuilderDateTimePicker(
          name: name,
          format: DateFormat('yyyy-MM-dd'),
          enabled: true,
          initialDate: null,
          inputType: InputType.date,
          onChanged: (e) {},
          style: context.textTheme.bodyMedium?.copyWith(
            color: Colors.black,
            fontSize: 11.sp,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
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

extension FormBuilderValidatorsX on FormBuilderValidators {
  static FormFieldValidator<T> equalX<T>(
    Object? value, {
    String? errorText,
  }) =>
      (T? valueCandidate) {
        print('value: $value valueCandidate: $valueCandidate');
        // Value is null and valueCandidate the form field value, when updating the field value
        return valueCandidate != value ? errorText : null;
      };
}
