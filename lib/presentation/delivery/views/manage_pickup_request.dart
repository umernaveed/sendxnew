import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/data/models/address_prediction/address_prediction.dart';
import 'package:sendx/data/models/manage_pick_up_request_meta/area.dart';
import 'package:sendx/data/models/manage_pick_up_request_meta/day.dart';
import 'package:sendx/presentation/account/views/update_profile_screen.dart';
import 'package:sendx/presentation/auth/views/login_screen.dart';
import 'package:sendx/presentation/auth/widgets/drop_down.dart';
import 'package:sendx/presentation/base_screen.dart';
import 'package:sendx/presentation/bottom_nav/controllers/bottom_nav_controller.dart';
import 'package:sendx/presentation/delivery/controllers/manage_pickup_request_controller.dart';
import 'package:sendx/presentation/delivery/views/delivery_request_confirmation.dart';
import 'package:sendx/app/core/routes/app_pages.dart';
import 'package:sendx/presentation/delivery/views/form_builder_time_slot_selector.dart';
import 'package:sizer/sizer.dart';

class ManagePickupRequest extends GetView<ManagePickUpRequestController> {
  const ManagePickupRequest({super.key});

  @override
  Widget build(BuildContext context) {
    final instantUser = controller.getInstantUser();
    final argumnents = Get.arguments;
    print(argumnents);

    return BaseScreen(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            final bottomNavNestedID =
                find<BottomNavController>().bottomNavNestedID;
            Get.back(id: bottomNavNestedID);
          },
        ),
        centerTitle: false,
        title: Text(
          'Manage Delivery Request',
          style: context.textTheme.bodyLarge?.copyWith(
            color: const Color(0xFF4791CE),
            fontSize: 16.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      value: SystemUiOverlayStyle.dark,
      body: SingleChildScrollView(
        child: FormBuilder(
          clearValueOnUnregister: true,
          key: controller.formKey,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: GetBuilder<ManagePickUpRequestController>(
                id: 'manage_pickup_request',
                builder: (_) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 3.5.h),
                      CustomDropDown<DeliveryType>(
                        name: 'delivery_type',
                        spaceBTW: 10,
                        initialValue: controller.deliveryType,
                        title: 'Select Request Type',
                        enabledBorder: _enableBorder(),
                        disabledBorder: _disableBorder(),
                        focusedBorder: _focusedBorder(),
                        onItemSelected: (e) {
                          if (e != null) {
                            controller.onDeloveryTypeChange(e);
                          }
                        },
                        hint: 'Regular',
                        items: [
                          DeliveryType(name: 'Regular Delivery', typeID: 1),
                          DeliveryType(name: 'Pre Pickup Delivery', typeID: 2)
                        ],
                      ),
                      SizedBox(height: 2.5.h),
                      _FieldWithLable(
                        name: 'name',
                        hint: 'Johan Doe',
                        initialValue: instantUser.userName,
                        lable: 'who should we expecting',
                        validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required()],
                        ),
                      ),
                      SizedBox(height: 2.5.h),
                      _FieldWithLable(
                        name: 'contact',
                        lable: 'Contact',
                        initialValue: instantUser.phone,
                        hint: '#####',
                        validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required()],
                        ),
                      ),

                      SizedBox(height: 2.5.h),
                      CustomDropDown<Area>(
                        name: 'select_area',
                        title: 'Select Area',
                        onItemSelected: (e) {
                          if (e == null) return;
                          controller.onAreaChange(e);
                        },
                        spaceBTW: 10,
                        hint: 'CITY CENTER',
                        isDense: true,
                        enabledBorder: _enableBorder(),
                        disabledBorder: _disableBorder(),
                        focusedBorder: _focusedBorder(),
                        items: controller.areas,
                      ),
                      SizedBox(height: 2.5.h),
                      CustomDropDown<Day>(
                        name: 'select_day',
                        spaceBTW: 10,
                        title: 'Select Day',
                        enabledBorder: _enableBorder(),
                        disabledBorder: _disableBorder(),
                        focusedBorder: _focusedBorder(),
                        onItemSelected: (e) => controller.onDayChange(e),
                        hint: 'Monday',
                        items: controller.days,
                      ),
                      SizedBox(height: 2.5.h),
                      Visibility(
                        visible: controller.deliveryType.typeID == 2,
                        child: AppDatePicker(
                          title: 'Pick up Date',
                          hint: 'Pick up Date',
                          name: 'tdate',
                          spaceBTW: 10,
                          decoration: InputDecoration(
                            disabledBorder: _disableBorder(),
                            focusedBorder: _focusedBorder(),
                            enabledBorder: _enableBorder(),
                            suffixIcon: const Icon(
                              Icons.calendar_today,
                              color: Color(0xFF4791CE),
                            ),
                            hintText: 'Pick up Date',
                            hintStyle: context.textTheme.bodyMedium?.copyWith(
                              color: const Color(0x337C7C7C),
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),

                      Visibility(
                        visible: controller.timeSlots.isNotEmpty,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 0.1.h),
                            FormBuilderTimeSlotSelector(
                              name: 'time_slot',
                              title: 'Select a Time Slot',
                              timeSlots: controller.timeSlots,
                              onChanged: (e) {
                                if (e != null) controller.onTimeSlotChange(e);
                              },
                              disabledTimeSlots: controller.disableSlots
                                  .map((e) => e.id.toString())
                                  .toList()
                                  .toSet(),
                              validator: FormBuilderValidators.required(
                                errorText: 'Please select a time slot.',
                              ),
                            ),
                          ],
                        ),
                      ),
                      // CustomDropDown<Day>(
                      //   name: 'time_slot',
                      //   spaceBTW: 10,
                      //   title: 'Time',
                      //   enabledBorder: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(5),
                      //     borderSide: BorderSide(
                      //       width: 0.5,
                      //       color: Colors.grey.withOpacity(
                      //         0.6,
                      //       ),
                      //     ),
                      //   ),
                      //   disabledBorder: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(5),
                      //     borderSide: BorderSide(
                      //       width: 0.5,
                      //       color: Colors.grey.withOpacity(
                      //         0.6,
                      //       ),
                      //     ),
                      //   ),
                      //   focusedBorder: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(5),
                      //     borderSide: BorderSide(
                      //       width: 0.5,
                      //       color: Colors.grey.withOpacity(0.6),
                      //     ),
                      //   ),
                      //   onItemSelected: (e) {},
                      //   hint: '',
                      //   items: controller.timeSlots
                      //       .map((e) =>
                      //           Day(day: '${e.startTime} - ${e.endTime}'))
                      //       .toList(),
                      // ),

                      _FieldWithLable(
                        name: 'delivery_coast',
                        lable: 'Delivery Coast',
                        hint: '00.00',
                        controller: controller.coastController,
                        readOnly: true,
                        validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required()],
                        ),
                      ),
                      SizedBox(height: 2.5.h),
                      _AddressField(
                        name: 'address',
                        lable: 'Pleas enter your address here',
                        controller: controller.addressController,
                        hint: 'CITY CENTER, JERUSALEM',
                        validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required()],
                        ),
                        onTap: () async {
                          final selected =
                              await Get.toNamed(AppPages.addressSearch);
                          if (selected != null &&
                              selected is AddressPrediction) {
                            final display = selected.cityCountryDisplay;
                            controller.addressController.text = display;
                            controller.formKey.currentState?.fields['address']
                                ?.didChange(display);
                            if (selected.lat != null && selected.lon != null) {
                              controller.setLatLng(
                                selected.lat!.toString(),
                                selected.lon!.toString(),
                              );
                            }
                            controller.update(['manage_pickup_request']);
                          }
                        },
                      ),
                      SizedBox(height: 2.5.h),
                      _FieldWithLable(
                        name: 'notes',
                        lable: 'Notes',
                        maxLines: 5,
                        hint: 'Notes',
                        validator: FormBuilderValidators.compose([]),
                      ),
                      SizedBox(height: 2.5.h),
                      AppButton(
                        title: 'Schedule Delivery',
                        buttonBorderRadius: 10,
                        backgroundColor: Colors.pinkAccent,
                        onTap: () {
                          if (controller.deliveryType.typeID == 1) {
                            controller.onRegularDelivery();
                          } else {
                            Get.bottomSheet(DeliveryRequestConfirmation());
                          }
                        },
                      ),
                      SizedBox(height: 2.h),
                      AppButton(
                        title: 'Cancel',
                        buttonBorderRadius: 10,
                        backgroundColor: Colors.transparent,
                        textColor: Colors.black,
                        side: const BorderSide(
                          color: Colors.black,
                          width: 0.5,
                        ),
                        onTap: () {
                          Get.back();
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _focusedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        width: 0.5,
        color: Colors.grey.withValues(
          alpha: 0.6,
        ),
      ),
    );
  }

  OutlineInputBorder _disableBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        width: 0.5,
        color: Colors.grey.withValues(
          alpha: 0.6,
        ),
      ),
    );
  }

  OutlineInputBorder _enableBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        width: 0.5,
        color: Colors.grey.withValues(
          alpha: 0.6,
        ),
      ),
    );
  }
}

/// Tappable address field: tap opens address search; selected address is shown here.
class _AddressField extends StatelessWidget {
  const _AddressField({
    required this.lable,
    required this.name,
    required this.controller,
    required this.validator,
    required this.hint,
    required this.onTap,
  });
  final String lable;
  final String name;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hint;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          lable,
          style: TextStyle(
            color: const Color(0xFF7C7C7C),
            fontSize: 11.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: onTap,
          child: AbsorbPointer(
            child: FormBuilderTextField(
              name: name,
              readOnly: true,
              controller: controller,
              decoration: InputDecoration(
                isDense: true,
                hintText: hint,
                suffixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFF4791CE),
                  size: 22,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    width: 0.5,
                    color: Colors.grey.withValues(alpha: 0.6),
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    width: 0.5,
                    color: Colors.grey.withValues(alpha: 0.6),
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(width: 0.5, color: Colors.red),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(width: 0.5, color: Colors.red),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    width: 0.5,
                    color: Colors.grey.withValues(alpha: 0.6),
                  ),
                ),
              ),
              validator: validator,
              style: const TextStyle(
                color: Color(0xFF181725),
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FieldWithLable extends StatelessWidget {
  const _FieldWithLable({
    required this.lable,
    required this.name,
    required this.validator,
    required this.hint,
    this.maxLines,
    this.initialValue,
    this.readOnly = false,
    this.controller,
  });
  final String lable;
  final String name;
  final String? Function(String?)? validator;
  final String hint;
  final int? maxLines;
  final String? initialValue;
  final bool readOnly;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          lable,
          style: TextStyle(
            color: const Color(0xFF7C7C7C),
            fontSize: 11.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 10),
        FormBuilderTextField(
          name: name,
          maxLines: maxLines,
          readOnly: readOnly,
          controller: controller,
          initialValue: initialValue,
          decoration: InputDecoration(
            isDense: true,
            hintText: hint,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: 0.5,
                color: Colors.grey.withValues(
                  alpha: 0.6,
                ),
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: 0.5,
                color: Colors.grey.withValues(
                  alpha: 0.6,
                ),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: 0.5,
                color: Colors.red,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: 0.5,
                color: Colors.red,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: 0.5,
                color: Colors.grey.withValues(
                  alpha: 0.6,
                ),
              ),
            ),
          ),
          validator: validator,
          style: const TextStyle(
            color: Color(0xFF181725),
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class DeliveryType extends Pair {
  final String name;
  final int typeID;

  DeliveryType({required this.name, required this.typeID})
      : super(
          key: typeID.toString(),
          value: name,
        );
}
