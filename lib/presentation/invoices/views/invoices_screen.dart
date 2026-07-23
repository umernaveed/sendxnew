import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/app/core/routes/app_pages.dart';
import 'package:sendx/app/extensions/string_ext.dart';
import 'package:sendx/data/models/invoice/invoice.dart';
import 'package:sendx/presentation/base_screen.dart';
import 'package:sendx/presentation/bottom_nav/controllers/bottom_nav_controller.dart';
import 'package:sendx/presentation/invoices/controller/invoices_controller.dart';
import 'package:sizer/sizer.dart';

class InvoicesScreen extends GetView<InvoicesController> {
  const InvoicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      wrapWithAnnotatedRegion: true,
      value: SystemUiOverlayStyle.dark,
      showGradients: false,
      backgroundColor: const Color(0xFFF8FBFF),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const _InvoiceHeader(),
            Padding(
              padding: EdgeInsets.fromLTRB(4.2.w, 2.1.h, 4.2.w, 1.2.h),
              child: _InvoiceSearchField(
                controller: controller.textEditingController,
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                color: const Color(0xFF0C73DF),
                onRefresh: () => Future.sync(
                  () => controller.pagingController.refresh(),
                ),
                child: PagedListView<int, Invoice>.separated(
                  pagingController: controller.pagingController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(4.2.w, 0.8.h, 4.2.w, 2.5.h),
                  builderDelegate: PagedChildBuilderDelegate<Invoice>(
                    animateTransitions: true,
                    transitionDuration: 350.milliseconds,
                    itemBuilder: (context, item, index) {
                      return _InvoiceCard(invoice: item);
                    },
                    firstPageProgressIndicatorBuilder: (_) =>
                        const Center(child: CircularProgressIndicator()),
                    newPageProgressIndicatorBuilder: (_) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                    noItemsFoundIndicatorBuilder: (_) => const _EmptyInvoices(),
                  ),
                  separatorBuilder: (context, index) => SizedBox(height: 2.h),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InvoiceHeader extends StatelessWidget {
  const _InvoiceHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 1.2.w,
            top: 1.2.h,
            child: IconButton(
              onPressed: () {
                final bottomNavNestedID =
                    find<BottomNavController>().bottomNavNestedID;
                Get.back(id: bottomNavNestedID);
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: const Color(0xFF07152B),
                size: 2.8.h,
              ),
            ),
          ),
          SvgPicture.asset(
            'assets/svgs/app_logo_sendx.svg',
            fit: BoxFit.contain,
            width: 22.w,
            height: 6.2.h,
          ),
        ],
      ),
    );
  }
}

class _InvoiceSearchField extends StatelessWidget {
  const _InvoiceSearchField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7.4.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEAF0F8)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F0A2E57),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(width: 2.8.w),
          Icon(
            Icons.search_rounded,
            color: const Color(0xFF076AD8),
            size: 3.4.h,
          ),
          SizedBox(width: 2.2.w),
          Expanded(
            child: TextFormField(
              controller: controller,
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                hintText: 'Search by invoice no, user name...',
                hintStyle: TextStyle(
                  color: const Color(0xFF7C8291),
                  fontSize: 11.2.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              style: TextStyle(
                color: const Color(0xFF111D35),
                fontSize: 11.2.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            width: 1,
            height: 4.3.h,
            color: const Color(0xFFE1E7F0),
          ),
          SizedBox(width: 2.5.w),
          Container(
            width: 10.6.w,
            height: 5.3.h,
            decoration: BoxDecoration(
              color: const Color(0xFFF4F8FF),
              borderRadius: BorderRadius.circular(13),
              border: Border.all(color: const Color(0xFFE0EBFA)),
            ),
            child: Icon(
              Icons.filter_alt_outlined,
              color: const Color(0xFF086DDC),
              size: 3.2.h,
            ),
          ),
          SizedBox(width: 2.5.w),
        ],
      ),
    );
  }
}

class _InvoiceCard extends StatelessWidget {
  const _InvoiceCard({required this.invoice});

  final Invoice invoice;

  @override
  Widget build(BuildContext context) {
    final status = invoice.status.trim().isEmpty ? 'Unpaid' : invoice.status;
    final isPaid = status.toLowerCase() == 'paid';
    final totalPaid = _amountWithCurrency(invoice.totalPaid);
    final totalUnpaid = _amountWithCurrency(invoice.totalInvoice);

    return Container(
      padding: EdgeInsets.fromLTRB(3.2.w, 2.2.h, 3.2.w, 1.9.h),
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
      child: Column(
        children: [
          Row(
            children: [
              _SoftIcon(
                icon: Icons.receipt_long_outlined,
                color: const Color(0xFF0C73DF),
              ),
              SizedBox(width: 3.5.w),
              Expanded(
                child: Text(
                  'Invoice #${invoice.invoiceNo}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: const Color(0xFF111D35),
                    fontSize: 12.8.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              _TopStatusChip(title: status, isPaid: isPaid),
            ],
          ),
          SizedBox(height: 1.9.h),
          const Divider(height: 1, color: Color(0xFFEFF2F7)),
          SizedBox(height: 2.2.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    _InvoiceInfoRow(
                      icon: Icons.calendar_month_outlined,
                      iconColor: const Color(0xFF0C73DF),
                      iconBackground: const Color(0xFFEAF4FF),
                      label: 'Date Created',
                      value: invoice.createdAt.toDDMMYYYY,
                    ),
                    SizedBox(height: 1.9.h),
                    _InvoiceInfoRow(
                      icon: Icons.request_quote_outlined,
                      iconColor: const Color(0xFF7456E8),
                      iconBackground: const Color(0xFFF0ECFF),
                      label: 'Invoice Paid',
                      value: totalPaid,
                    ),
                    SizedBox(height: 1.9.h),
                    _InvoiceInfoRow(
                      icon: Icons.account_balance_wallet_outlined,
                      iconColor: const Color(0xFF16B86A),
                      iconBackground: const Color(0xFFEAFBF2),
                      label: 'Invoice Unpaid',
                      value: totalUnpaid,
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 16.5.h,
                margin: EdgeInsets.symmetric(horizontal: 2.2.w),
                color: const Color(0xFFE8EDF5),
              ),
              Expanded(
                child: Column(
                  children: [
                    _InvoiceInfoRow(
                      icon: Icons.event_available_outlined,
                      iconColor: const Color(0xFF18B96E),
                      iconBackground: const Color(0xFFEAFBF2),
                      label: 'Date Paid',
                      value: invoice.datePaid.toDDMMYYYY,
                    ),
                    SizedBox(height: 1.9.h),
                    _InvoiceInfoRow(
                      icon: Icons.person_outline_rounded,
                      iconColor: const Color(0xFF7456E8),
                      iconBackground: const Color(0xFFF0ECFF),
                      label: 'User Name',
                      value: invoice.userName,
                    ),
                    SizedBox(height: 1.9.h),
                    _InvoiceInfoRow(
                      icon: Icons.check_circle_outline_rounded,
                      iconColor: const Color(0xFF0C73DF),
                      iconBackground: const Color(0xFFEAF4FF),
                      label: 'Paid Status',
                      customValue: _PaidStatusChip(title: status, isPaid: isPaid),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 2.2.h),
          SizedBox(
            width: double.infinity,
            height: 6.2.h,
            child: ElevatedButton(
              onPressed: () {
                final bottomNavNestedID =
                    find<BottomNavController>().bottomNavNestedID;
                Get.toNamed(
                  AppPages.invoiceDetails,
                  id: bottomNavNestedID,
                  arguments: invoice.invoiceNo.toString(),
                );
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color(0xFF0B6EDB),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Invoice Detail',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.4.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 3.4.h,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _amountWithCurrency(dynamic amount) {
    final value = amount.toString().trim();
    if (value.isEmpty) return '0.00 JMD';
    if (value.toUpperCase().contains('JMD')) return value;
    return '$value JMD';
  }
}

class _InvoiceInfoRow extends StatelessWidget {
  const _InvoiceInfoRow({
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.label,
    this.value,
    this.customValue,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String label;
  final String? value;
  final Widget? customValue;

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
        SizedBox(width: 2.7.w),
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
                  fontSize: 9.7.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 0.45.h),
              customValue ??
                  Text(
                    value ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: const Color(0xFF111D35),
                      fontSize: 10.8.sp,
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
    this.backgroundColor = const Color(0xFFEAF4FF),
  });

  final IconData icon;
  final Color color;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6.1.h,
      height: 6.1.h,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Icon(
        icon,
        color: color,
        size: 3.h,
      ),
    );
  }
}

class _TopStatusChip extends StatelessWidget {
  const _TopStatusChip({required this.title, required this.isPaid});

  final String title;
  final bool isPaid;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.6.w, vertical: 0.9.h),
      decoration: BoxDecoration(
        color: isPaid ? const Color(0xFFE9F9F1) : const Color(0xFFEAF4FF),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isPaid ? const Color(0xFF11985A) : const Color(0xFF0B63BF),
          fontSize: 10.2.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _PaidStatusChip extends StatelessWidget {
  const _PaidStatusChip({required this.title, required this.isPaid});

  final String title;
  final bool isPaid;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.4.w, vertical: 0.55.h),
      decoration: BoxDecoration(
        color: isPaid ? const Color(0xFF16B86A) : const Color(0xFF0B6EDB),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isPaid ? Icons.check_rounded : Icons.check_rounded,
            color: Colors.white,
            size: 1.9.h,
          ),
          SizedBox(width: 0.7.w),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontSize: 9.7.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyInvoices extends StatelessWidget {
  const _EmptyInvoices();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 14.h),
        Icon(
          Icons.receipt_long_outlined,
          color: const Color(0xFF9FB7D1),
          size: 8.h,
        ),
        SizedBox(height: 1.5.h),
        Text(
          'No invoices found',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF334155),
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
