import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:sendx/app/core/theme/app_colors.dart';
import 'package:sizer/sizer.dart';

enum FieldType {
  passowrd,
  withOutTitle,
  paragraph,
  normal;

  bool get isPassword => this == FieldType.passowrd;
  bool get isParagraph => this == FieldType.paragraph;
}

class AppTextField extends StatelessWidget {
  final String title;
  final String? hint;
  final Color? titleColor;
  final FieldType type;
  final Color? hintColor;
  final double? height;
  final ValueChanged<String?>? onChange;
  final int? maxLines;
  final TextInputType? keyboardType;
  final int? minLines;
  final TextInputAction? textInputAction;
  final String name;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool obscureText;
  final void Function()? onPasswordToggle;
  final String? initialValue;
  final bool readOnly;
  const AppTextField({
    super.key,
    required this.title,
    this.onChange,
    this.hint,
    this.titleColor,
    this.type = FieldType.normal,
    this.hintColor,
    this.height,
    this.maxLines,
    this.keyboardType,
    this.minLines,
    this.textInputAction,
    required this.name,
    this.validator,
    this.controller,
    this.obscureText = false,
    this.onPasswordToggle,
    this.initialValue,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final field = FormBuilderTextField(
      name: name,
      obscureText: obscureText,
      // maxLines: maxLines,
      // minLines: minLines,
      validator: validator,
      readOnly: readOnly,
      controller: controller,
      initialValue: initialValue,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      obscuringCharacter: '*',
      onChanged: onChange,
      decoration: InputDecoration(
        isDense: false,
        border: type.isParagraph ? InputBorder.none : null,
        hintStyle: context.theme.inputDecorationTheme.hintStyle?.copyWith(
          color: hintColor,
        ),
        hintText: type.isPassword ? '*******' : hint,
        suffixIcon: type.isPassword
            ? IconButton(
                onPressed: onPasswordToggle,
                icon: Icon(
                  !obscureText ? Icons.visibility_off : Icons.visibility,
                ),
              )
            : const SizedBox.shrink(),
      ),
      style: TextStyle(
        color: AppColors.ink,
        fontSize: 16,
        letterSpacing: type.isPassword ? 3 : 0,
        fontWeight: FontWeight.w400,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: titleColor ?? AppColors.charcoal,
            fontSize: 10.5.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (type.isParagraph) ...[
          Expanded(child: field),
        ] else ...[
          field,
        ]
      ],
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({super.key, this.hint = 'Search', this.controller});
  final String hint;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: 6.h,
      child: TextFormField(
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        controller: controller,
        decoration: InputDecoration(
          isDense: true,
          prefixIcon: IconButton(
            icon: Icon(
              Icons.search,
              color: AppColors.cyan,
              size: 2.5.h,
            ),
            onPressed: () {},
          ),
          // suffixIcon: IconButton(
          //   icon: Icon(
          //     Icons.mic,
          //     color: Colors.black,
          //     size: 2.5.h,
          //   ),
          //   onPressed: () {},
          // ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1,
              color: AppColors.border,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1,
              color: AppColors.border,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1,
              color: AppColors.coral,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: AppColors.cyan,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          hintStyle: context.theme.inputDecorationTheme.hintStyle?.copyWith(
            color: AppColors.muted,
          ),
          hintText: hint,
        ),
        style: TextStyle(
          color: AppColors.ink,
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
