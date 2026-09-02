import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/app/core/routes/app_pages.dart';
import 'package:sendx/app/core/theme/app_colors.dart';
import 'package:sendx/app/util/flush_snackbar.dart';
import 'package:sendx/data/models/support_ticket/support_ticket.dart';
import 'package:sendx/presentation/base_screen.dart';
import 'package:sendx/presentation/bottom_nav/controllers/bottom_nav_controller.dart';
import 'package:sendx/presentation/support/controllers/support_controller.dart';
import 'package:sizer/sizer.dart';

class SupportScreen extends GetView<SupportController> {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      wrapWithAnnotatedRegion: true,
      value: SystemUiOverlayStyle.dark,
      showGradients: false,
      backgroundColor: const Color(0xFFF8FBFF),
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          color: const Color(0xFF176DF2),
          onRefresh: controller.loadTickets,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.fromLTRB(3.8.w, 0.3.h, 3.8.w, 2.5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _SupportHeader(),
                SizedBox(height: 1.h),
                const _SupportHero(),
                SizedBox(height: 1.4.h),
                const _TicketStatsCard(),
                SizedBox(height: 1.4.h),
                _CreateTicketCard(controller: controller),
                SizedBox(height: 1.4.h),
                _TrackTicketCard(controller: controller),
                SizedBox(height: 1.4.h),
                const _RecentTicketsCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SupportHeader extends StatelessWidget {
  const _SupportHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 8.2.h,
      child: Row(
        children: [
          SizedBox(
            width: 12.w,
            child: IconButton(
              onPressed: _goBackFromSupport,
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(
                minWidth: 10.w,
                minHeight: 5.h,
              ),
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: const Color(0xFF07132D),
                size: 2.5.h,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: SvgPicture.asset(
                'assets/svgs/app_logo_sendx.svg',
                width: 20.5.w,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(width: 12.w),
        ],
      ),
    );
  }
}

class _SupportHero extends StatelessWidget {
  const _SupportHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.2.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF176DF2),
            Color(0xFF8F45C8),
            Color(0xFFFF315B),
          ],
        ),
        borderRadius: BorderRadius.circular(17),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22176DF2),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 8.8.h,
            height: 8.8.h,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.12),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white.withOpacity(.16)),
            ),
            child: Icon(
              Icons.headset_mic_rounded,
              color: Colors.white,
              size: 5.h,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Customer Support',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: .4.h),
                Text(
                  "We're here to help you, every step of the way.",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withOpacity(.92),
                    fontSize: 10.2.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 1.1.h),
                Wrap(
                  spacing: 2.w,
                  runSpacing: .7.h,
                  children: const [
                    _HeroPill(icon: Icons.access_time_rounded, text: 'Avg response time  < 2 hrs'),
                    _HeroPill(text: 'Support hours  Mon - Sat  8AM - 6PM'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroPill extends StatelessWidget {
  const _HeroPill({required this.text, this.icon});

  final String text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: .65.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.14),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: Colors.white, size: 1.8.h),
            SizedBox(width: 1.w),
          ],
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 8.5.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _TicketStatsCard extends GetView<SupportController> {
  const _TicketStatsCard();

  @override
  Widget build(BuildContext context) {
    return _SoftCard(
      padding: EdgeInsets.all(3.4.w),
      child: Obx(
        () => Column(
          children: [
            Row(
              children: [
                _SoftIcon(
                  icon: Icons.confirmation_number_outlined,
                  color: const Color(0xFF176DF2),
                  bg: const Color(0xFFEAF4FF),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Text(
                    'My Tickets',
                    style: TextStyle(
                      color: const Color(0xFF111D35),
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: controller.loadTickets,
                  icon: Icon(
                    Icons.refresh_rounded,
                    color: const Color(0xFF344055),
                    size: 2.5.h,
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.2.h),
            _StatusSummaryRow(
              icon: Icons.info_outline_rounded,
              label: 'Open',
              count: controller.openCount,
              color: const Color(0xFF176DF2),
            ),
            _StatusSummaryRow(
              icon: Icons.access_time_rounded,
              label: 'Pending',
              count: controller.pendingCount,
              color: const Color(0xFFE0A10B),
            ),
            _StatusSummaryRow(
              icon: Icons.check_circle_outline_rounded,
              label: 'Closed',
              count: controller.closedCount,
              color: const Color(0xFF16B86A),
            ),
            SizedBox(height: 1.h),
            SizedBox(
              width: double.infinity,
              height: 4.2.h,
              child: TextButton(
                onPressed: controller.loadTickets,
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFEAF4FF),
                  foregroundColor: const Color(0xFF176DF2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: Text(
                  controller.isTicketsLoading.value ? 'Refreshing...' : 'View All Tickets',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusSummaryRow extends StatelessWidget {
  const _StatusSummaryRow({
    required this.icon,
    required this.label,
    required this.count,
    required this.color,
  });

  final IconData icon;
  final String label;
  final int count;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: .45.h),
      child: Row(
        children: [
          Icon(icon, color: color, size: 2.1.h),
          SizedBox(width: 2.2.w),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: const Color(0xFF344055),
                fontSize: 10.3.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            count.toString(),
            style: TextStyle(
              color: color,
              fontSize: 12.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _CreateTicketCard extends StatelessWidget {
  const _CreateTicketCard({required this.controller});

  final SupportController controller;

  @override
  Widget build(BuildContext context) {
    return _SoftCard(
      padding: EdgeInsets.all(3.5.w),
      child: FormBuilder(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _SoftIcon(
                  icon: Icons.add_rounded,
                  color: Colors.white,
                  bg: const Color(0xFF176DF2),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create Support Ticket',
                        style: TextStyle(
                          color: const Color(0xFF111D35),
                          fontSize: 13.2.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: .25.h),
                      Text(
                        'Tell us how we can help you.',
                        style: TextStyle(
                          color: const Color(0xFF586274),
                          fontSize: 9.5.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.7.h),
            _SectionLabel('What is your issue?'),
            SizedBox(height: .9.h),
            Obx(
              () => Wrap(
                spacing: 1.8.w,
                runSpacing: .8.h,
                children: [
                  for (final option in _issueOptions(controller.issueTypes))
                    _IssueChip(
                      option: option,
                      selected: controller.selectedIssueType.value == option.value,
                      onTap: () => controller.selectedIssueType.value = option.value,
                    ),
                ],
              ),
            ),
            SizedBox(height: 1.5.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _TrackingField(),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: _PrioritySelector(controller: controller),
                ),
              ],
            ),
            SizedBox(height: 1.4.h),
            _SectionLabel('Detailed Description *'),
            SizedBox(height: .7.h),
            FormBuilderTextField(
              name: 'description',
              minLines: 4,
              maxLines: 6,
              maxLength: 1000,
              keyboardType: TextInputType.multiline,
              validator: FormBuilderValidators.required(),
              decoration: _inputDecoration(
                hint: 'Please describe your issue in detail...',
              ).copyWith(counterText: ''),
            ),
            SizedBox(height: 1.1.h),
            _SectionLabel('Upload Files (Optional)'),
            SizedBox(height: .7.h),
            Obx(
              () => _UploadBox(
                fileName: controller.selectedFile.value?.path.split(RegExp(r'[\\/]')).last,
                onTap: controller.pickAttachment,
              ),
            ),
            SizedBox(height: 1.6.h),
            Obx(
              () => SizedBox(
                width: double.infinity,
                height: 6.2.h,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: controller.isLoading.value
                        ? null
                        : const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xFF176DF2),
                              Color(0xFF8F45C8),
                              Color(0xFFFF315B),
                            ],
                          ),
                    color: controller.isLoading.value ? const Color(0xFFB9C8DA) : null,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: TextButton.icon(
                    onPressed: controller.isLoading.value
                        ? null
                        : () async {
                            final result = await controller.submitTicket();
                            if (result.message.isNotEmpty) {
                              FlushSnackbar.showSnackBar(result.message, isError: !result.isDone);
                            }
                          },
                    icon: Icon(
                      Icons.send_outlined,
                      color: Colors.white,
                      size: 2.7.h,
                    ),
                    label: Text(
                      controller.isLoading.value ? 'Submitting...' : 'Submit Ticket',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Obx(
              () => controller.createdTicketNumber.value.isEmpty
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: EdgeInsets.only(top: 1.2.h),
                      child: Text(
                        'Ticket Number: ${controller.createdTicketNumber.value}',
                        style: TextStyle(
                          color: const Color(0xFF0A9E69),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TrackingField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionLabel('Package Tracking Number *'),
        SizedBox(height: .7.h),
        FormBuilderTextField(
          name: 'tracking_number',
          validator: FormBuilderValidators.required(),
          decoration: _inputDecoration(
            hint: 'Enter supplier tracking no.',
            icon: Icons.inventory_2_outlined,
          ),
        ),
      ],
    );
  }
}

class _PrioritySelector extends StatelessWidget {
  const _PrioritySelector({required this.controller});

  final SupportController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionLabel('Priority'),
        SizedBox(height: .7.h),
        Obx(
          () => Wrap(
            spacing: 1.5.w,
            runSpacing: .6.h,
            children: [
              for (final priority in controller.priorities)
                _PriorityChip(
                  label: priority,
                  selected: controller.selectedPriority.value == priority,
                  onTap: () => controller.selectedPriority.value = priority,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TrackTicketCard extends StatelessWidget {
  const _TrackTicketCard({required this.controller});

  final SupportController controller;

  @override
  Widget build(BuildContext context) {
    return _SoftCard(
      padding: EdgeInsets.all(3.5.w),
      child: FormBuilder(
        key: controller.trackFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _SoftIcon(
                  icon: Icons.search_rounded,
                  color: const Color(0xFF176DF2),
                  bg: const Color(0xFFEAF4FF),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Track Ticket Status',
                        style: TextStyle(
                          color: const Color(0xFF111D35),
                          fontSize: 12.5.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        'Check the status of your existing ticket.',
                        style: TextStyle(
                          color: const Color(0xFF586274),
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.5.h),
            Row(
              children: [
                Expanded(
                  child: FormBuilderTextField(
                    name: 'ticket_number',
                    decoration: _inputDecoration(hint: 'HC-2026-0001'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.5.w),
                  child: Text(
                    'OR',
                    style: TextStyle(
                      color: const Color(0xFF586274),
                      fontSize: 9.5.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Expanded(
                  child: FormBuilderTextField(
                    name: 'contact',
                    decoration: _inputDecoration(hint: 'Email or phone'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.2.h),
            SizedBox(
              width: double.infinity,
              height: 5.5.h,
              child: Obx(
                () => ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () async {
                          final result = await controller.trackTicket();
                          if (result.message.isNotEmpty) {
                            FlushSnackbar.showSnackBar(result.message, isError: !result.isDone);
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF176DF2),
                    disabledBackgroundColor: const Color(0xFFB9C8DA),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                  ),
                  child: Text(
                    controller.isLoading.value ? 'Checking...' : 'Check Status',
                    style: TextStyle(
                      fontSize: 11.5.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
            Obx(
              () {
                final ticket = controller.trackedTicket.value;
                if (ticket.ticketNumber.isEmpty) return const SizedBox.shrink();
                return Padding(
                  padding: EdgeInsets.only(top: 1.2.h),
                  child: _TicketRow(ticket: ticket),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _RecentTicketsCard extends GetView<SupportController> {
  const _RecentTicketsCard();

  @override
  Widget build(BuildContext context) {
    return _SoftCard(
      padding: EdgeInsets.all(3.5.w),
      child: Obx(
        () {
          final tickets = controller.recentTickets;
          return Column(
            children: [
              Row(
                children: [
                  _SoftIcon(
                    icon: Icons.list_alt_rounded,
                    color: const Color(0xFF176DF2),
                    bg: const Color(0xFFEAF4FF),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recent Tickets',
                          style: TextStyle(
                            color: const Color(0xFF111D35),
                            fontSize: 12.5.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          'View all your recent support tickets.',
                          style: TextStyle(
                            color: const Color(0xFF586274),
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: controller.loadTickets,
                    child: Text(
                      'View All',
                      style: TextStyle(
                        color: const Color(0xFF176DF2),
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.2.h),
              if (controller.isTicketsLoading.value)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  child: const CircularProgressIndicator(),
                )
              else if (tickets.isEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  child: Text(
                    'No support tickets found',
                    style: TextStyle(
                      color: const Color(0xFF586274),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              else
                for (int i = 0; i < tickets.length; i++) ...[
                  if (i > 0) const Divider(color: Color(0xFFE9EEF6)),
                  _TicketRow(ticket: tickets[i]),
                ],
            ],
          );
        },
      ),
    );
  }
}

class _TicketRow extends StatelessWidget {
  const _TicketRow({required this.ticket});

  final SupportTicket ticket;

  @override
  Widget build(BuildContext context) {
    final style = _statusStyle(ticket.status);
    return Row(
      children: [
        _SoftIcon(
          icon: Icons.confirmation_number_outlined,
          color: style.color,
          bg: style.bg,
          compact: true,
        ),
        SizedBox(width: 2.5.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ticket.ticketNumber,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: const Color(0xFF111D35),
                  fontSize: 10.5.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: .2.h),
              Text(
                ticket.issueType,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: const Color(0xFF586274),
                  fontSize: 8.8.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: .2.h),
              Text(
                ticket.createdAt.isEmpty ? '' : 'Updated ${ticket.createdAt.toString().split(' ').first}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: const Color(0xFF8B95A5),
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 2.2.w, vertical: .8.h),
          decoration: BoxDecoration(
            color: style.bg,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Text(
            style.label,
            style: TextStyle(
              color: style.color,
              fontSize: 8.5.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        SizedBox(width: 1.w),
        Icon(
          Icons.chevron_right_rounded,
          color: const Color(0xFF8B95A5),
          size: 2.4.h,
        ),
      ],
    );
  }
}

class _IssueChip extends StatelessWidget {
  const _IssueChip({
    required this.option,
    required this.selected,
    required this.onTap,
  });

  final _IssueOption option;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(9),
      onTap: onTap,
      child: Container(
        width: 25.8.w,
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.1.h),
        decoration: BoxDecoration(
          color: selected ? option.color.withOpacity(.12) : Colors.white,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(
            color: selected ? option.color : const Color(0xFFE5EBF4),
          ),
        ),
        child: Row(
          children: [
            Icon(option.icon, color: option.color, size: 2.6.h),
            SizedBox(width: 1.5.w),
            Expanded(
              child: Text(
                option.label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: const Color(0xFF111D35),
                  fontSize: 8.2.sp,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PriorityChip extends StatelessWidget {
  const _PriorityChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = label == 'Urgent'
        ? const Color(0xFFFF3F55)
        : label == 'Important'
            ? const Color(0xFFE0A10B)
            : const Color(0xFF16B86A);
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.1.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: selected ? color.withOpacity(.12) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: selected ? color : const Color(0xFFE5EBF4)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 9.sp,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

class _UploadBox extends StatelessWidget {
  const _UploadBox({required this.onTap, this.fileName});

  final VoidCallback onTap;
  final String? fileName;

  @override
  Widget build(BuildContext context) {
    final hasFile = fileName?.isNotEmpty ?? false;
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.7.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF6FAFF),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF8FC2FF), style: BorderStyle.solid),
        ),
        child: Row(
          children: [
            Icon(
              Icons.cloud_upload_outlined,
              color: const Color(0xFF176DF2),
              size: 3.2.h,
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Text(
                hasFile ? fileName! : 'Drag & drop files here\nor tap to browse',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: const Color(0xFF176DF2),
                  fontSize: 9.5.sp,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                ),
              ),
            ),
            Text(
              'PNG, JPG, PDF\nMax 10 MB',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: const Color(0xFF586274),
                fontSize: 8.5.sp,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SoftCard extends StatelessWidget {
  const _SoftCard({required this.child, required this.padding});

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEF3FA)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F092341),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _SoftIcon extends StatelessWidget {
  const _SoftIcon({
    required this.icon,
    required this.color,
    required this.bg,
    this.compact = false,
  });

  final IconData icon;
  final Color color;
  final Color bg;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final size = compact ? 4.7.h : 5.4.h;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(compact ? 9 : 11),
      ),
      child: Icon(icon, color: color, size: compact ? 2.5.h : 3.h),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: const Color(0xFF111D35),
        fontSize: 9.7.sp,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}

InputDecoration _inputDecoration({required String hint, IconData? icon}) {
  return InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(
      color: Color(0xFF9AA2B1),
      fontWeight: FontWeight.w600,
    ),
    prefixIcon: icon == null
        ? null
        : Icon(
            icon,
            color: const Color(0xFF9AA2B1),
          ),
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xFFE5EBF4)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xFF176DF2), width: 1.3),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.coral),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.coral, width: 1.3),
    ),
  );
}

List<_IssueOption> _issueOptions(List<String> remoteTypes) {
  final options = [
    _IssueOption('Package Missing', 'Missing Package', Icons.inventory_2_outlined, const Color(0xFF176DF2)),
    _IssueOption('Billing Issue', 'Billing/Payment Issue', Icons.attach_money_rounded, const Color(0xFF16B86A)),
    _IssueOption('Delivery Issue', 'Delivery Request', Icons.local_shipping_outlined, const Color(0xFFE0A10B)),
    _IssueOption('Invoice Issue', 'Customs/Receipt Issue', Icons.description_outlined, const Color(0xFF8F45C8)),
    _IssueOption('Account Issue', 'General Complaint', Icons.person_outline_rounded, const Color(0xFF176DF2)),
    _IssueOption('Other', 'Other', Icons.more_horiz_rounded, const Color(0xFF6B7280)),
  ];
  if (remoteTypes.isEmpty) return options;
  return options.where((option) => remoteTypes.contains(option.value)).toList()
    ..addAll(remoteTypes
        .where((type) => !options.any((option) => option.value == type))
        .map((type) => _IssueOption(type, type, Icons.help_outline_rounded, const Color(0xFF6B7280))));
}

class _IssueOption {
  const _IssueOption(this.label, this.value, this.icon, this.color);

  final String label;
  final String value;
  final IconData icon;
  final Color color;
}

({String label, Color color, Color bg}) _statusStyle(String status) {
  final normalized = status.trim().isEmpty ? 'Open' : status.trim();
  final lower = normalized.toLowerCase();
  if (lower.contains('closed') || lower.contains('resolved')) {
    return (label: 'Resolved', color: const Color(0xFF16B86A), bg: const Color(0xFFEAFBF2));
  }
  if (lower.contains('pending') || lower.contains('progress') || lower.contains('waiting')) {
    return (label: 'Customer Replied', color: const Color(0xFFE0A10B), bg: const Color(0xFFFFF7E4));
  }
  return (label: 'Waiting for Agent', color: const Color(0xFF176DF2), bg: const Color(0xFFEAF4FF));
}

void _goBackFromSupport() {
  final bottomNav = find<BottomNavController>();
  final nestedNavigator = Get.nestedKey(bottomNav.bottomNavNestedID)?.currentState;
  if (nestedNavigator?.canPop() ?? false) {
    nestedNavigator!.pop();
    return;
  }

  final rootNavigator = Get.key.currentState;
  if (rootNavigator?.canPop() ?? false) {
    Get.back();
    return;
  }

  bottomNav.onTabChange(0);
}
