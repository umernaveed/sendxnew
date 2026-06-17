import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:sendx/data/models/manage_pick_up_request_meta/time_slot.dart';
import 'package:sizer/sizer.dart';

class FormBuilderTimeSlotSelector extends FormBuilderField<TimeSlot> {
  final List<TimeSlot> timeSlots;
  final String title;
  final Set<String>? disabledTimeSlots;

  FormBuilderTimeSlotSelector({
    super.key,
    required super.name,
    required this.timeSlots,
    required this.title,
    this.disabledTimeSlots,
    super.validator,
    super.initialValue,
    ValueChanged<TimeSlot?>? onChanged,
  }) : super(
          builder: (FormFieldState<TimeSlot?> field) {
            return _TimeSlotSelector(
              field: field,
              timeSlots: timeSlots,
              title: title,
              disabledTimeSlots: disabledTimeSlots,
            );
          },
        );
}

class _TimeSlotSelector extends StatelessWidget {
  final FormFieldState<TimeSlot?> field;
  final List<TimeSlot> timeSlots;
  final String title;
  final Set<String>? disabledTimeSlots;

  const _TimeSlotSelector({
    required this.field,
    required this.timeSlots,
    required this.title,
    this.disabledTimeSlots,
  });

  bool isDisabled(TimeSlot timeSlot) {
    if (disabledTimeSlots == null) return false;

    // Check if any ID in disabledTimeSlots matches the id of the given timeSlot
    return disabledTimeSlots
            ?.any((id) => id.toString() == timeSlot.id.toString()) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: title,
        errorText: field.errorText,
        labelStyle: context.textTheme.bodyMedium?.copyWith(
          color: const Color(0xFF7C7C7C),
          fontSize: 13.3.sp,
          fontWeight: FontWeight.w500,
        ),
        enabledBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
        border: InputBorder.none,
      ),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 3.2,
        padding: EdgeInsets.zero,
        children: timeSlots.map((timeSlot) {
          final isSelected = timeSlot == field.value;
          final disabled = isDisabled(timeSlot);

          return ChoiceChip(
            label: Text(
              '${timeSlot.startTime} - ${timeSlot.endTime}',
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF181725),
                fontSize: 10.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            selected: isSelected,
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            backgroundColor:
                disabled ? const Color(0xFFF0F0F0) : const Color(0xFFF5F5F5),
            selectedColor: const Color(0xFF4791CE),
            side: BorderSide(
              color: disabled
                  ? const Color(0xFFE0E0E0)
                  : isSelected
                      ? const Color(0xFF4791CE)
                      : const Color(0xFFE2E2E2),
              width: 1,
            ),
            onSelected: disabled
                ? null
                : (selected) {
                    field.didChange(selected ? timeSlot : null);
                  },
          );
        }).toList(),
      ),
    );
  }
}
