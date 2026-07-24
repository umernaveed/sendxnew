import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/app/core/routes/app_pages.dart';
import 'package:sendx/app/extensions/string_ext.dart';
import 'package:sendx/data/models/unpaid_invoice/unpaid_invoice.dart';
import 'package:sendx/presentation/base_screen.dart';
import 'package:sendx/presentation/bottom_nav/controllers/bottom_nav_controller.dart';
import 'package:sendx/presentation/unpaid_invoices/controllers/unpaid_invoices.dart';
import 'package:sizer/sizer.dart';

class UnpaidInvoicesScreen extends GetView<UnpaidInvoicesController> {
  const UnpaidInvoicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      showGradients: false,
      wrapWithAnnotatedRegion: true,
      value: SystemUiOverlayStyle.dark,
      backgroundColor: const Color(0xFFF8FBFF),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const _UnpaidHeader(),
            Padding(
              padding: EdgeInsets.fromLTRB(4.w, 1.4.h, 4.w, 1.6.h),
              child: _UnpaidSearchField(
                controller: controller.textEditingController,
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                color: const Color(0xFF176DF2),
                onRefresh: () => Future.sync(() => controller.onRefresh()),
                child: GetBuilder<UnpaidInvoicesController>(
                  id: 'unpaidInvoices',
                  builder: (_) {
                    return PagedListView<int, UnpaidInvoice>.separated(
                      pagingController: controller.pagingController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 2.2.h),
                      restorationId: 'unpaidInvoices',
                      addAutomaticKeepAlives: true,
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      builderDelegate:
                          PagedChildBuilderDelegate<UnpaidInvoice>(
                        animateTransitions: true,
                        transitionDuration: 350.milliseconds,
                        firstPageProgressIndicatorBuilder: (_) =>
                            const Center(child: CircularProgressIndicator()),
                        newPageProgressIndicatorBuilder: (_) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.h),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        noItemsFoundIndicatorBuilder: (_) =>
                            const _EmptyUnpaidInvoices(),
                        itemBuilder: (context, item, index) {
                          return _UnpaidInvoiceCard(
                            item: item,
                            onChanged: (_) => controller.onItemChecked(item),
                          );
                        },
                      ),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 1.6.h),
                    );
                  },
                ),
              ),
            ),
            const _PaymentSummaryPanel(),
          ],
        ),
      ),
    );
  }
}

class _UnpaidHeader extends StatelessWidget {
  const _UnpaidHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10.2.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 3.2.w,
            top: 1.3.h,
            child: Container(
              width: 8.7.h,
              height: 8.7.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x10092341),
                    blurRadius: 18,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () {
                  final bottomNavNestedID =
                      find<BottomNavController>().bottomNavNestedID;
                  Get.back(id: bottomNavNestedID);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: const Color(0xFF07132D),
                  size: 3.h,
                ),
              ),
            ),
          ),
          SvgPicture.asset(
            'assets/svgs/app_logo_sendx.svg',
            width: 24.w,
            fit: BoxFit.contain,
          ),
          Positioned(
            right: 5.w,
            bottom: 0.4.h,
            child: Opacity(
              opacity: .08,
              child: Icon(
                Icons.receipt_long_outlined,
                color: const Color(0xFF176DF2),
                size: 9.5.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UnpaidSearchField extends StatelessWidget {
  const _UnpaidSearchField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7.3.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5EDF7)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F092341),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(width: 4.w),
          Icon(
            Icons.search_rounded,
            color: const Color(0xFF176DF2),
            size: 3.4.h,
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: TextFormField(
              controller: controller,
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                hintText: 'Search unpaid invoices...',
                hintStyle: TextStyle(
                  color: const Color(0xFF8E95A3),
                  fontSize: 10.2.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: TextStyle(
                color: const Color(0xFF111D35),
                fontSize: 10.2.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: 2.5.w),
        ],
      ),
    );
  }
}

class _UnpaidInvoiceCard extends StatelessWidget {
  const _UnpaidInvoiceCard({
    required this.item,
    required this.onChanged,
  });

  final UnpaidInvoice item;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final amountDue = _amountWithCurrency(item.totalInvoice);
    final amountPaid = _amountWithCurrency(item.totalPaid);
    final status = (item.status?.trim().isNotEmpty ?? false)
        ? item.status!.trim()
        : 'Unpaid';

    return Container(
      padding: EdgeInsets.fromLTRB(3.5.w, 1.7.h, 3.5.w, 1.7.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: item.isToggleOn
              ? const Color(0xFF176DF2)
              : const Color(0xFFEEF3FA),
          width: item.isToggleOn ? 1.4 : 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F092341),
            blurRadius: 20,
            offset: Offset(0, 9),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              _SelectableBox(
                value: item.isToggleOn,
                onChanged: (value) {
                  item.isToggleOn = value ?? false;
                  onChanged?.call(value);
                },
              ),
              SizedBox(width: 3.w),
              _SoftIcon(
                icon: Icons.receipt_long_outlined,
                color: const Color(0xFF176DF2),
                backgroundColor: const Color(0xFFEAF4FF),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Text(
                  'Invoice #${item.invoiceNo ?? '-'}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: const Color(0xFF111D35),
                    fontSize: 11.2.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              _StatusBadge(status: status),
            ],
          ),
          SizedBox(height: 1.7.h),
          const Divider(height: 1, color: Color(0xFFEFF2F7)),
          SizedBox(height: 1.8.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    _InfoLine(
                      icon: Icons.calendar_month_outlined,
                      iconColor: const Color(0xFF176DF2),
                      iconBackground: const Color(0xFFEAF4FF),
                      label: 'Date Created',
                      value: item.createdAt?.toDDMMYYYY ?? '-',
                    ),
                    SizedBox(height: 1.7.h),
                    _InfoLine(
                      icon: Icons.request_quote_outlined,
                      iconColor: const Color(0xFF7456E8),
                      iconBackground: const Color(0xFFF0ECFF),
                      label: 'Invoice Paid',
                      value: amountPaid,
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 12.8.h,
                margin: EdgeInsets.symmetric(horizontal: 2.3.w),
                color: const Color(0xFFE8EDF5),
              ),
              Expanded(
                child: Column(
                  children: [
                    _InfoLine(
                      icon: Icons.person_outline_rounded,
                      iconColor: const Color(0xFF7456E8),
                      iconBackground: const Color(0xFFF0ECFF),
                      label: 'User Name',
                      value: item.userName ?? '-',
                    ),
                    SizedBox(height: 1.7.h),
                    _InfoLine(
                      icon: Icons.account_balance_wallet_outlined,
                      iconColor: const Color(0xFF16B86A),
                      iconBackground: const Color(0xFFEAFBF2),
                      label: 'Invoice Unpaid',
                      value: amountDue,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 1.8.h),
          SizedBox(
            width: double.infinity,
            height: 5.8.h,
            child: ElevatedButton(
              onPressed: () {
                final bottomNavNestedID =
                    find<BottomNavController>().bottomNavNestedID;
                Get.toNamed(
                  AppPages.invoiceDetails,
                  id: bottomNavNestedID,
                  arguments: item.invoiceNo.toString(),
                );
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color(0xFF176DF2),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  const Spacer(),
                  Text(
                    'Invoice Detail',
                    style: TextStyle(
                      fontSize: 10.8.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Spacer(),
                  Icon(Icons.arrow_forward_rounded, size: 3.2.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectableBox extends StatefulWidget {
  const _SelectableBox({
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final void Function(bool?)? onChanged;

  @override
  State<_SelectableBox> createState() => _SelectableBoxState();
}

class _SelectableBoxState extends State<_SelectableBox> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.value;
  }

  @override
  void didUpdateWidget(covariant _SelectableBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      isChecked = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 6.2.w,
      height: 6.2.w,
      child: Checkbox(
        value: isChecked,
        onChanged: (value) {
          setState(() => isChecked = value ?? false);
          widget.onChanged?.call(value);
        },
        activeColor: const Color(0xFF176DF2),
        checkColor: Colors.white,
        side: const BorderSide(color: Color(0xFF9AA5B5), width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        visualDensity: const VisualDensity(
          horizontal: -4,
          vertical: -4,
        ),
      ),
    );
  }
}

class _PaymentSummaryPanel extends StatelessWidget {
  const _PaymentSummaryPanel();

  @override
  Widget build(BuildContext context) {
    final controller = find<UnpaidInvoicesController>();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(4.w, 1.5.h, 4.w, 1.4.h),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Color(0x14092341),
            blurRadius: 24,
            offset: Offset(0, -8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: _SummaryTile(
                  icon: Icons.receipt_long_outlined,
                  label: 'Selected Invoices',
                  child: Obx(
                    () => Text(
                      controller.selectedItems.length.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: const Color(0xFF176DF2),
                        fontSize: 11.8.sp,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: _SummaryTile(
                  icon: Icons.account_balance_wallet_outlined,
                  label: 'Total Amount Due',
                  child: Obx(
                    () => Text(
                      _amountWithCurrency(controller.totalAmount.value),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: const Color(0xFF0CA45D),
                        fontSize: 10.7.sp,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 1.3.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => controller.onClear(),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF07132D),
                    side: const BorderSide(color: Color(0xFFE1E8F2)),
                    minimumSize: Size.fromHeight(5.8.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  icon: Icon(Icons.refresh_rounded, size: 2.5.h),
                  label: Text(
                    'Clear',
                    style: TextStyle(
                      fontSize: 10.4.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                flex: 2,
                child: Obx(
                  () {
                    final count = controller.selectedItems.length;
                    return ElevatedButton.icon(
                      onPressed: count <= 0
                          ? null
                          : () async {
                              await controller.performPayment();
                            },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color(0xFF176DF2),
                        disabledBackgroundColor: const Color(0xFFB9CBE4),
                        foregroundColor: Colors.white,
                        minimumSize: Size.fromHeight(5.8.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      icon: Icon(Icons.payment_rounded, size: 2.5.h),
                      label: Text(
                        'Pay Now',
                        style: TextStyle(
                          fontSize: 10.6.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryTile extends StatelessWidget {
  const _SummaryTile({
    required this.icon,
    required this.label,
    required this.child,
  });

  final IconData icon;
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.2.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF7FAFF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEAF0FA)),
      ),
      child: Row(
        children: [
          _SoftIcon(
            icon: icon,
            color: const Color(0xFF176DF2),
            backgroundColor: const Color(0xFFEAF4FF),
            size: 4.7.h,
          ),
          SizedBox(width: 2.4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: const Color(0xFF667085),
                    fontSize: 8.2.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 0.35.h),
                child,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SoftIcon(
          icon: icon,
          color: iconColor,
          backgroundColor: iconBackground,
        ),
        SizedBox(width: 2.4.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: const Color(0xFF697083),
                  fontSize: 8.4.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 0.35.h),
              Text(
                value,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: const Color(0xFF111D35),
                  fontSize: 9.2.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SoftIcon extends StatelessWidget {
  const _SoftIcon({
    required this.icon,
    required this.color,
    required this.backgroundColor,
    this.size,
  });

  final IconData icon;
  final Color color;
  final Color backgroundColor;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final boxSize = size ?? 5.5.h;
    return Container(
      width: boxSize,
      height: boxSize,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        icon,
        color: color,
        size: boxSize * .48,
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.8.w, vertical: .85.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF0D7),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Text(
        status,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: const Color(0xFFB35C00),
          fontSize: 8.8.sp,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _EmptyUnpaidInvoices extends StatelessWidget {
  const _EmptyUnpaidInvoices();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 13.h),
        Icon(
          Icons.receipt_long_outlined,
          color: const Color(0xFF9FB7D1),
          size: 8.h,
        ),
        SizedBox(height: 1.5.h),
        Text(
          'No unpaid invoices found',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF334155),
            fontSize: 10.5.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

String _amountWithCurrency(dynamic amount) {
  final value = amount?.toString().trim() ?? '';
  if (value.isEmpty) return '0.00 JMD';
  if (value.toUpperCase().contains('JMD')) return value;
  return '$value JMD';
}
