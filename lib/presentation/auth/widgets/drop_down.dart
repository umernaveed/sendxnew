import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

abstract class Pair {
  final String value;
  final String key;

  Pair({required this.value, required this.key});
}

class OutLetPair extends Pair {
  OutLetPair({required super.value, required super.key});
}

class NormalString extends Pair {
  NormalString({
    required super.value,
    required super.key,
  });
}

class CustomDropDown<T extends Pair> extends StatefulWidget {
  final String title;
  final List<T> items;
  final Function(T?) onItemSelected;
  final String hint;
  final String name;
  final T? initialValue;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;
  final InputBorder? errorBorder;
  final bool? isDense;
  final double? spaceBTW;
  final String? Function(T?)? validator;

  const CustomDropDown({
    Key? key,
    required this.title,
    required this.items,
    required this.onItemSelected,
    required this.hint,
    required this.name,
    this.initialValue,
    this.focusedBorder,
    this.enabledBorder,
    this.disabledBorder,
    this.isDense,
    this.spaceBTW,
    this.errorBorder,
    this.validator,
  }) : super(key: key);

  @override
  CustomDropDownState<T> createState() => CustomDropDownState<T>();
}

class CustomDropDownState<T extends Pair> extends State<CustomDropDown<T>> {
  T? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = null; // Initialize with null to show the hint
    if (widget.initialValue != null) {
      selectedValue = widget.initialValue;
    }
  }

  T? getInitValue() {
    final value = widget.initialValue;
    if (value == null) return null;
    final item = widget.items.firstWhereOrNull(
      (e) => e.key.toLowerCase() == value.key.toLowerCase(),
    );
    return item;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: context.textTheme.bodyMedium?.copyWith(
            color: const Color(0xFF7C7C7C),
            fontSize: 11.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: widget.spaceBTW),
        FormBuilderDropdown<T>(
          name: widget.name,
          decoration: InputDecoration(
            hintText: widget.hint,
            isDense: widget.isDense,
            errorBorder: widget.errorBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    width: 0.5,
                    color: Colors.red,
                  ),
                ),
            enabledBorder: widget.enabledBorder,
            focusedBorder: widget.focusedBorder,
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: 0.5,
                color: Colors.red,
              ),
            ),
            disabledBorder: widget.disabledBorder,
            hintStyle: context.textTheme.bodyMedium?.copyWith(
              color: const Color(0x337C7C7C),
              fontSize: 11.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          validator: widget.validator ??
              FormBuilderValidators.compose(
                [
                  FormBuilderValidators.required(),
                ],
              ),
          isExpanded: true,
          initialValue: getInitValue(),
          alignment: Alignment.centerLeft,
          elevation: 1,
          style: context.textTheme.bodyMedium?.copyWith(
            color: Colors.black,
            fontSize: 11.sp,
            fontWeight: FontWeight.w400,
          ),
          onChanged: (newValue) {
            selectedValue = newValue;
            widget.onItemSelected(selectedValue);
            setState(() {});
          },
          items: widget.items.map(
            (item) {
              return DropdownMenuItem<T>(
                value: item,
                child: Text(
                  item.value,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.black,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}
