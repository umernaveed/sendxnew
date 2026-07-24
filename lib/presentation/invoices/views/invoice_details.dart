import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/app/core/routes/app_pages.dart';
import 'package:sendx/app/extensions/string_ext.dart';
import 'package:sendx/app/util/flush_snackbar.dart';
import 'package:sendx/data/models/invoice_detail/invoice_detail.dart';
import 'package:sendx/presentation/base_screen.dart';
import 'package:sendx/presentation/bottom_nav/controllers/bottom_nav_controller.dart';
import 'package:sendx/presentation/invoices/controller/invoice_detail_controller.dart';
import 'package:sendx/presentation/widgets/shimmer_widget.dart';
import 'package:sizer/sizer.dart';

class InvoiceDetails extends GetView<InvoiceDetailController> {
  const InvoiceDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    if (args != null) {
      controller.getInviceDetails(args.toString());
    }

    return BaseScreen(
      wrapWithAnnotatedRegion: true,
      value: SystemUiOverlayStyle.dark,
      showGradients: false,
      backgroundColor: const Color(0xFFF8FBFF),
      body: SafeArea(
        bottom: false,
        child: controller.obx(
          onLoading: const _InvoiceDetailsLoading(),
          onError: (_) => const _InvoiceError(),
          (state) {
            if (state == null) return const SizedBox.shrink();
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.fromLTRB(4.w, 0.4.h, 4.w, 2.5.h),
              child: Column(
                children: [
                  const _InvoiceHeader(),
                  SizedBox(height: 1.3.h),
                  _InvoiceHero(data: state),
                  SizedBox(height: 1.6.h),
                  _BillToCard(data: state),
                  SizedBox(height: 1.5.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _CompanyCard(data: state)),
                      SizedBox(width: 3.w),
                      Expanded(child: _ShipmentCard(data: state)),
                    ],
                  ),
                  SizedBox(height: 1.5.h),
                  _ChargesBreakdownCard(data: state),
                  SizedBox(height: 1.5.h),
                  _StorageFeeNotice(data: state),
                  SizedBox(height: 1.5.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _TimelineCard(data: state)),
                      SizedBox(width: 3.w),
                      Expanded(child: _PaymentCard(data: state)),
                    ],
                  ),
                  SizedBox(height: 1.5.h),
                  _InvoiceActions(data: state),
                ],
              ),
            );
          },
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
      height: 8.2.h,
      child: Row(
        children: [
          SizedBox(
            width: 12.w,
            child: IconButton(
              onPressed: _goBackFromInvoice,
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

class _InvoiceHero extends StatelessWidget {
  const _InvoiceHero({required this.data});

  final InvoiceDetailResponse data;

  @override
  Widget build(BuildContext context) {
    final unpaid = data.status == 0;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(4.2.w, 2.h, 4.2.w, 2.2.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0A73D9), Color(0xFF004A95)],
        ),
        borderRadius: BorderRadius.circular(17),
        boxShadow: const [
          BoxShadow(
            color: Color(0x220A73D9),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.receipt_long_outlined,
                      color: Colors.white.withOpacity(.82),
                      size: 2.6.h,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Invoice Details',
                      style: TextStyle(
                        color: Colors.white.withOpacity(.9),
                        fontSize: 9.6.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Text(
                  '#${data.invoiceNo}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.8.sp,
                    fontWeight: FontWeight.w900,
                    height: 1,
                  ),
                ),
                SizedBox(height: 1.h),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.white.withOpacity(.88),
                      size: 2.4.h,
                    ),
                    SizedBox(width: 1.4.w),
                    Text(
                      data.datePaid.toDDMMYYYY,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9.3.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.2.h),
                _HeroStatusChip(unpaid: unpaid),
                SizedBox(height: 1.4.h),
                Text(
                  'Total Amount',
                  style: TextStyle(
                    color: Colors.white.withOpacity(.9),
                    fontSize: 10.2.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: .4.h),
                Text(
                  _amountWithCurrency(data.grandTotal),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.2.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 3.w),
          Opacity(
            opacity: .32,
            child: Icon(
              Icons.assignment_turned_in_rounded,
              color: Colors.white,
              size: 13.h,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroStatusChip extends StatelessWidget {
  const _HeroStatusChip({required this.unpaid});

  final bool unpaid;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: .8.h),
      decoration: BoxDecoration(
        color: unpaid ? const Color(0xFFFFC943) : const Color(0xFF19C477),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        unpaid ? 'UNPAID' : 'PAID',
        style: TextStyle(
          color: unpaid ? const Color(0xFF151515) : Colors.white,
          fontSize: 8.4.sp,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _BillToCard extends StatelessWidget {
  const _BillToCard({required this.data});

  final InvoiceDetailResponse data;

  @override
  Widget build(BuildContext context) {
    return _SoftCard(
      padding: EdgeInsets.all(4.w),
      child: Row(
        children: [
          Icon(
            Icons.person_outline_rounded,
            color: const Color(0xFF0B6EDB),
            size: 3.4.h,
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SmallLabel('Bill To'),
                SizedBox(height: .8.h),
                Text(
                  data.userName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: const Color(0xFF111D35),
                    fontSize: 11.4.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: .5.h),
                Text(
                  'Account No: ${data.mailboxNo}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: _mutedStyle(context),
                ),
                SizedBox(height: .5.h),
                Text(
                  data.email,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: _mutedStyle(context),
                ),
              ],
            ),
          ),
          Container(
            width: 7.h,
            height: 7.h,
            decoration: const BoxDecoration(
              color: Color(0xFFF2F6FF),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.mail_outline_rounded,
              color: const Color(0xFF0B6EDB),
              size: 3.h,
            ),
          ),
        ],
      ),
    );
  }
}

class _CompanyCard extends StatelessWidget {
  const _CompanyCard({required this.data});

  final InvoiceDetailResponse data;

  @override
  Widget build(BuildContext context) {
    return _SoftCard(
      padding: EdgeInsets.all(3.6.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(
            icon: Icons.business_outlined,
            title: 'Company Details',
          ),
          SizedBox(height: 1.5.h),
          Text(
            data.companyName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: const Color(0xFF0B63BF),
              fontSize: 10.2.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 1.2.h),
          Text(
            data.localAddress,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: _mutedStyle(context),
          ),
          SizedBox(height: 1.2.h),
          Row(
            children: [
              Icon(
                Icons.phone_outlined,
                color: const Color(0xFF0B6EDB),
                size: 2.2.h,
              ),
              SizedBox(width: 1.4.w),
              Expanded(
                child: Text(
                  data.phone,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: _mutedStyle(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ShipmentCard extends StatelessWidget {
  const _ShipmentCard({required this.data});

  final InvoiceDetailResponse data;

  @override
  Widget build(BuildContext context) {
    final first = data.invoiceDetail.isNotEmpty ? data.invoiceDetail.first : null;
    return _SoftCard(
      padding: EdgeInsets.all(3.6.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(
            icon: Icons.inventory_2_outlined,
            title: 'Shipment Details',
          ),
          SizedBox(height: 1.4.h),
          _KeyValueLine(label: 'HAWB', value: first?.manifestNo ?? '-'),
          _KeyValueLine(label: 'Weight', value: _weightText(first?.packageWeight ?? 0)),
          _KeyValueLine(label: 'Freight Type', value: _freightLabel(data.freightType)),
          _KeyValueLine(label: 'Description', value: first?.packageDescription ?? '-'),
        ],
      ),
    );
  }
}

class _ChargesBreakdownCard extends StatelessWidget {
  const _ChargesBreakdownCard({required this.data});

  final InvoiceDetailResponse data;

  @override
  Widget build(BuildContext context) {
    final details = data.invoiceDetail;
    final freight = details.fold<double>(0, (sum, item) => sum + _amount(item.packagePrice));
    final service = details.fold<double>(0, (sum, item) => sum + _amount(item.serviceFee));
    final custom = details.fold<double>(0, (sum, item) => sum + _amount(item.customFee));
    final storage = _storageDisplayAmount(data);
    final discount = _amount(data.discountPrice);

    return _SoftCard(
      padding: EdgeInsets.fromLTRB(3.6.w, 1.7.h, 3.6.w, 1.2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(
            icon: Icons.attach_money_rounded,
            title: 'Charges Breakdown',
            filledIcon: true,
          ),
          SizedBox(height: 1.4.h),
          _ChargeRow(label: _freightLabel(data.freightType), amount: freight),
          _ChargeRow(label: 'Service Fee', amount: service),
          _ChargeRow(label: 'Custom Fee', amount: custom),
          _ChargeRow(label: 'GCT', amountText: _amountWithCurrency(data.gstTotal)),
          if (storage > 0)
            _ChargeRow(label: 'Storage Fee', amount: storage),
          for (final fee in data.additionalFee ?? [])
            _ChargeRow(label: fee.name, amountText: _amountWithCurrency(fee.serviceFee)),
          if (discount > 0)
            _ChargeRow(label: 'Discount', amount: -discount),
          SizedBox(height: 1.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.3.h),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF4FF),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Total Amount',
                    style: TextStyle(
                      color: const Color(0xFF0B63BF),
                      fontSize: 10.5.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Text(
                  _amountWithCurrency(data.grandTotal),
                  style: TextStyle(
                    color: const Color(0xFF0B63BF),
                    fontSize: 11.8.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StorageFeeNotice extends StatelessWidget {
  const _StorageFeeNotice({required this.data});

  final InvoiceDetailResponse data;

  @override
  Widget build(BuildContext context) {
    final payable = _amount(data.storageFeePayable);
    final waived = _amount(data.storageFeeWaivedAmount);
    final total = _amount(data.storageFeeTotal);
    final show = payable > 0 || total > 0 || (data.storageFeeWaived == 1 && waived > 0);
    if (!show) return const SizedBox.shrink();

    final due = payable > 0 && data.status == 0;
    final title = due
        ? 'Storage Fee Due'
        : data.storageFeeWaived == 1
            ? 'Storage Fee Waived'
            : 'Storage Fee';
    final amount = due
        ? data.storageFeePayable
        : data.storageFeeWaived == 1
            ? data.storageFeeWaivedAmount
            : data.storageFeeTotal;
    final message = due
        ? '${data.storageFeeDaysApplied} days at ${_amountWithCurrency(data.storageFeeDailyRate)} per day after ${data.storageFeeGraceDays} grace days.'
        : data.storageFeeWaived == 1
            ? data.storageFeeWaivedReason
            : 'Storage fee is included in this invoice.';

    return _SoftCard(
      padding: EdgeInsets.all(3.4.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            due ? Icons.warning_amber_rounded : Icons.check_circle_outline_rounded,
            color: due ? const Color(0xFFE09A00) : const Color(0xFF10A66B),
            size: 3.h,
          ),
          SizedBox(width: 2.5.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$title: ${_amountWithCurrency(amount)}',
                  style: TextStyle(
                    color: due ? const Color(0xFF8C6000) : const Color(0xFF0A7C4D),
                    fontSize: 9.8.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                if (message.trim().isNotEmpty) ...[
                  SizedBox(height: .6.h),
                  Text(
                    message,
                    style: TextStyle(
                      color: const Color(0xFF586274),
                      fontSize: 8.8.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineCard extends StatelessWidget {
  const _TimelineCard({required this.data});

  final InvoiceDetailResponse data;

  @override
  Widget build(BuildContext context) {
    final paid = data.status != 0;
    return _SoftCard(
      padding: EdgeInsets.all(3.5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(icon: Icons.access_time_rounded, title: 'Invoice Timeline'),
          SizedBox(height: 1.7.h),
          _TimelineStep(title: 'Invoice Created', subtitle: data.datePaid.toDDMMYYYY, active: true),
          _TimelineStep(title: paid ? 'Payment Completed' : 'Payment Pending', active: paid),
          _TimelineStep(title: 'Package Released', active: paid),
        ],
      ),
    );
  }
}

class _PaymentCard extends GetView<InvoiceDetailController> {
  const _PaymentCard({required this.data});

  final InvoiceDetailResponse data;

  @override
  Widget build(BuildContext context) {
    final unpaid = data.status == 0;
    return Container(
      padding: EdgeInsets.all(3.5.w),
      decoration: BoxDecoration(
        color: const Color(0xFFEAFBF2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD7F4E4)),
      ),
      child: Column(
        children: [
          Text(
            unpaid ? 'Amount Due' : 'Amount Paid',
            style: TextStyle(
              color: const Color(0xFF0A9E69),
              fontSize: 9.5.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 1.4.h),
          Text(
            _amountWithCurrency(data.grandTotal),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: const Color(0xFF111D35),
              fontSize: 12.8.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 2.h),
          SizedBox(
            width: double.infinity,
            height: 6.h,
            child: ElevatedButton(
              onPressed: unpaid ? () => controller.startPayment() : null,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color(0xFF19B956),
                disabledBackgroundColor: const Color(0xFFB9C8DA),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    unpaid ? 'Pay Now' : 'Paid',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.8.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Icon(Icons.arrow_forward_rounded, size: 3.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InvoiceActions extends StatelessWidget {
  const _InvoiceActions({required this.data});

  final InvoiceDetailResponse data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _BottomAction(
            icon: Icons.download_rounded,
            label: 'Download PDF',
            onTap: () => FlushSnackbar.showSnackBar('PDF download is not available in app yet'),
          ),
        ),
        SizedBox(width: 2.w),
        Expanded(
          child: _BottomAction(
            icon: Icons.share_outlined,
            label: 'Share Invoice',
            onTap: () async {
              await Clipboard.setData(
                ClipboardData(text: 'Invoice #${data.invoiceNo} - ${_amountWithCurrency(data.grandTotal)}'),
              );
              FlushSnackbar.showSnackBar('Invoice details copied');
            },
          ),
        ),
        SizedBox(width: 2.w),
        Expanded(
          child: _BottomAction(
            icon: Icons.headset_mic_outlined,
            label: 'Contact Support',
            onTap: () {
              final bottomNavNestedID = find<BottomNavController>().bottomNavNestedID;
              Get.toNamed(AppPages.supportTickets, id: bottomNavNestedID);
            },
          ),
        ),
      ],
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

class _CardTitle extends StatelessWidget {
  const _CardTitle({
    required this.icon,
    required this.title,
    this.filledIcon = false,
  });

  final IconData icon;
  final String title;
  final bool filledIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: filledIcon ? 3.8.h : 3.h,
          height: filledIcon ? 3.8.h : 3.h,
          decoration: filledIcon
              ? const BoxDecoration(
                  color: Color(0xFF0B6EDB),
                  shape: BoxShape.circle,
                )
              : null,
          child: Icon(
            icon,
            color: filledIcon ? Colors.white : const Color(0xFF0B6EDB),
            size: filledIcon ? 2.2.h : 2.8.h,
          ),
        ),
        SizedBox(width: 2.w),
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: const Color(0xFF111D35),
              fontSize: 9.6.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}

class _SmallLabel extends StatelessWidget {
  const _SmallLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        color: const Color(0xFF111D35),
        fontSize: 9.5.sp,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _KeyValueLine extends StatelessWidget {
  const _KeyValueLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.2.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: const Color(0xFF151A27),
                fontSize: 8.5.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(width: 1.w),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: const Color(0xFF151A27),
                fontSize: 8.5.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChargeRow extends StatelessWidget {
  const _ChargeRow({
    required this.label,
    this.amount,
    this.amountText,
  });

  final String label;
  final double? amount;
  final String? amountText;

  @override
  Widget build(BuildContext context) {
    final text = amountText ?? _amountWithCurrency((amount ?? 0).toStringAsFixed(2));
    return Padding(
      padding: EdgeInsets.symmetric(vertical: .7.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: const Color(0xFF151A27),
                fontSize: 8.8.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: 2.w),
          Text(
            text,
            style: TextStyle(
              color: const Color(0xFF151A27),
              fontSize: 8.8.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineStep extends StatelessWidget {
  const _TimelineStep({
    required this.title,
    this.subtitle,
    required this.active,
  });

  final String title;
  final String? subtitle;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 1.9.h,
            height: 1.9.h,
            margin: EdgeInsets.only(top: .2.h),
            decoration: BoxDecoration(
              color: active ? const Color(0xFF0B6EDB) : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: active ? const Color(0xFF0B6EDB) : const Color(0xFFB9C4D3),
                width: 2,
              ),
            ),
          ),
          SizedBox(width: 2.2.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: const Color(0xFF111D35),
                    fontSize: 8.6.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                if (subtitle != null) ...[
                  SizedBox(height: .25.h),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      color: const Color(0xFF586274),
                      fontSize: 8.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _BottomAction extends StatelessWidget {
  const _BottomAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 6.3.h,
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF0B63BF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Color(0xFFEEF3FA)),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 2.4.h),
            SizedBox(height: .35.h),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: const Color(0xFF111D35),
                fontSize: 8.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InvoiceDetailsLoading extends StatelessWidget {
  const _InvoiceDetailsLoading();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(4.w, 1.h, 4.w, 2.h),
      child: Column(
        children: [
          for (final height in [7.8.h, 27.h, 12.h, 14.h, 24.h, 15.h])
            Padding(
              padding: EdgeInsets.only(bottom: 1.5.h),
              child: ShimmerWidget(
                radius: BorderRadius.circular(16),
                child: SizedBox(width: double.infinity, height: height),
              ),
            ),
        ],
      ),
    );
  }
}

class _InvoiceError extends StatelessWidget {
  const _InvoiceError();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Text(
          'Something went wrong try again later',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF181725),
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

TextStyle _mutedStyle(BuildContext context) {
  return TextStyle(
    color: const Color(0xFF586274),
    fontSize: 9.1.sp,
    fontWeight: FontWeight.w500,
    height: 1.25,
  );
}

String _amountWithCurrency(String value) {
  final clean = value.trim();
  if (clean.isEmpty) return 'JMD 0.00';
  if (clean.toUpperCase().contains('JMD')) return clean;
  return 'JMD $clean';
}

double _amount(String value) {
  final normalized = value
      .replaceAll(',', '')
      .replaceAll(RegExp('jmd', caseSensitive: false), '')
      .trim();
  return double.tryParse(normalized) ?? 0;
}

double _storageDisplayAmount(InvoiceDetailResponse data) {
  final payable = _amount(data.storageFeePayable);
  if (payable > 0) return payable;
  final total = _amount(data.storageFeeTotal);
  if (total > 0) return total;
  if (data.storageFeeWaived == 1) return _amount(data.storageFeeWaivedAmount);
  return 0;
}

String _freightLabel(String freightType) {
  return freightType.toLowerCase() == 'sendx'
      ? 'Regular Air Freight'
      : 'Express Air Freight';
}

String _weightText(int weight) {
  if (weight <= 0) return '-';
  return '$weight lbs';
}

void _goBackFromInvoice() {
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
