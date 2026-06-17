import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:sendx/app/core/theme/app_colors.dart';
import 'package:sendx/app/util/flush_snackbar.dart';
import 'package:sendx/presentation/account/views/account_screen.dart';
import 'package:sendx/presentation/auth/views/login_screen.dart';
import 'package:sendx/presentation/auth/widgets/auth_app_bar.dart';
import 'package:sendx/presentation/auth/widgets/text_field.dart';
import 'package:sendx/presentation/base_screen.dart';
import 'package:sendx/presentation/support/controllers/support_controller.dart';
import 'package:sizer/sizer.dart';

class SupportScreen extends GetView<SupportController> {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      wrapWithAnnotatedRegion: true,
      backgroundColor: AppColors.surfaceSoft,
      value: SystemUiOverlayStyle.dark,
      appBar: const AuthCustomAppBar.withSmallAppLogo(
        backButtonVisible: true,
        usingNavigator: true,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.fromLTRB(5.w, 2.h, 5.w, 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                gradient: AppColors.brandGradient,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cyan.withOpacity(0.22),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "SendX JA Couriers Support",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    'Connecting Miles | Delivering Smiles',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            _CreateTicketCard(controller: controller),
            SizedBox(height: 2.h),
            _TrackTicketCard(controller: controller),
          ],
        ),
      ),
    );
  }
}

class _CreateTicketCard extends StatelessWidget {
  final SupportController controller;

  const _CreateTicketCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return _SupportCard(
      title: 'Create Support Ticket',
      child: FormBuilder(
        key: controller.formKey,
        child: Column(
          children: [
            AppTextField(
              title: 'Full Name',
              hint: 'Full Name',
              name: 'full_name',
              validator: FormBuilderValidators.required(),
            ),
            SizedBox(height: 2.h),
            AppTextField(
              title: 'Phone Number',
              hint: 'Phone Number',
              name: 'phone_number',
              keyboardType: TextInputType.phone,
              validator: FormBuilderValidators.required(),
            ),
            SizedBox(height: 2.h),
            AppTextField(
              title: 'Email Address',
              hint: 'Email Address',
              name: 'email',
              keyboardType: TextInputType.emailAddress,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.email(),
              ]),
            ),
            SizedBox(height: 2.h),
            AppTextField(
              title: 'Customer Account/Suite Number',
              hint: 'Suite Number',
              name: 'suite_number',
            ),
            SizedBox(height: 2.h),
            AppTextField(
              title: 'Tracking Number',
              hint: 'Tracking Number',
              name: 'tracking_number',
            ),
            SizedBox(height: 2.h),
            AppTextField(
              title: 'Package Description',
              hint: 'Package Description',
              name: 'package_description',
            ),
            SizedBox(height: 2.h),
            FormBuilderDropdown<String>(
              name: 'issue_type',
              decoration: const InputDecoration(
                labelText: 'Issue Type',
                border: OutlineInputBorder(),
              ),
              validator: FormBuilderValidators.required(),
              items: controller.issueTypes
                  .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                  .toList(),
            ),
            SizedBox(height: 2.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description of Issue',
                  style: TextStyle(
                    color: AppColors.muted,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                FormBuilderTextField(
                  name: 'description',
                  minLines: 5,
                  maxLines: 8,
                  keyboardType: TextInputType.multiline,
                  validator: FormBuilderValidators.required(),
                  decoration: const InputDecoration(
                    hintText: 'Describe your issue',
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Obx(
              () => OutlinedButton.icon(
                onPressed: controller.pickAttachment,
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 6.h),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.2.h),
                ),
                icon: const Icon(Icons.attach_file),
                label: SizedBox(
                  width: 68.w,
                  child: Text(
                    controller.selectedFile.value == null
                        ? 'Upload receipt, invoice, photo, or document'
                        : controller.selectedFile.value!.path.split('/').last,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.h),
            Obx(
              () => controller.createdTicketNumber.value.isEmpty
                  ? const SizedBox.shrink()
                  : Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(3.w),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceSoft,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Text(
                        'Ticket Number: ${controller.createdTicketNumber.value}',
                        style: const TextStyle(
                          color: AppColors.ink,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
            ),
            SizedBox(height: 2.h),
            Obx(
              () => AppButton(
                title: controller.isLoading.value ? 'Please wait...' : 'Submit Ticket',
                onTap: controller.isLoading.value
                    ? null
                    : () async {
                        final result = await controller.submitTicket();
                        if (result.message.isNotEmpty) {
                          FlushSnackbar.showSnackBar(result.message, isError: !result.isDone);
                        }
                      },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TrackTicketCard extends StatelessWidget {
  final SupportController controller;

  const _TrackTicketCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return _SupportCard(
      title: 'Track Ticket Status',
      child: FormBuilder(
        key: controller.trackFormKey,
        child: Column(
          children: [
            AppTextField(
              title: 'Ticket Number',
              hint: 'HC-2026-0001',
              name: 'ticket_number',
              validator: FormBuilderValidators.required(),
            ),
            SizedBox(height: 2.h),
            AppTextField(
              title: 'Email or Phone Number',
              hint: 'Email or Phone Number',
              name: 'contact',
              validator: FormBuilderValidators.required(),
            ),
            SizedBox(height: 2.h),
            Obx(
              () => AppButton(
                title: controller.isLoading.value ? 'Please wait...' : 'Check Status',
                onTap: controller.isLoading.value
                    ? null
                    : () async {
                        final result = await controller.trackTicket();
                        if (result.message.isNotEmpty) {
                          FlushSnackbar.showSnackBar(result.message, isError: !result.isDone);
                        }
                      },
              ),
            ),
            SizedBox(height: 2.h),
            Obx(
              () {
                final ticket = controller.trackedTicket.value;
                if (ticket.ticketNumber.isEmpty) return const SizedBox.shrink();
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ticket.ticketNumber,
                        style: const TextStyle(
                          color: AppColors.ink,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 0.8.h),
                      Text('Status: ${ticket.status}'),
                      Text('Issue Type: ${ticket.issueType}'),
                      if (ticket.trackingNumber.isNotEmpty) Text('Tracking: ${ticket.trackingNumber}'),
                      Text('Created: ${ticket.createdAt}'),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SupportCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SupportCard({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.cyan.withOpacity(0.08),
            blurRadius: 22,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppColors.ink,
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 2.h),
          const AppDivider(),
          SizedBox(height: 2.h),
          child,
        ],
      ),
    );
  }
}
