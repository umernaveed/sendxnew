import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/app/core/routes/app_pages.dart';
import 'package:sendx/app/extensions/string_ext.dart';
import 'package:sendx/data/models/get_all_package/get_all_package.dart';
import 'package:sendx/presentation/account/controllers/get_delivery_packages_controller.dart';
import 'package:sendx/presentation/base_screen.dart';
import 'package:sendx/presentation/bottom_nav/controllers/bottom_nav_controller.dart';
import 'package:sendx/presentation/widgets/buttons/download_button.dart';
import 'package:sizer/sizer.dart';

class AccountTrackePackages extends GetView<AllDeliveryPackagesController> {
  const AccountTrackePackages({super.key});

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
            const _PackagesHeader(),
            Padding(
              padding: EdgeInsets.fromLTRB(4.w, 1.5.h, 4.w, 1.8.h),
              child: _PackageSearchField(
                controller: controller.textEditingController,
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                color: const Color(0xFF176DF2),
                onRefresh: () => Future.sync(
                  () => controller.pagingController.refresh(),
                ),
                child: PagedListView<int, GetAllPackage>.separated(
                  pagingController: controller.pagingController,
                  padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 2.4.h),
                  physics: const AlwaysScrollableScrollPhysics(),
                  builderDelegate: PagedChildBuilderDelegate<GetAllPackage>(
                    animateTransitions: true,
                    transitionDuration: 350.milliseconds,
                    firstPageProgressIndicatorBuilder: (_) =>
                        const Center(child: CircularProgressIndicator()),
                    newPageProgressIndicatorBuilder: (_) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                    noItemsFoundIndicatorBuilder: (_) =>
                        const _EmptyPackages(),
                    itemBuilder: (context, item, index) {
                      return _PackageCard(item: item);
                    },
                  ),
                  separatorBuilder: (context, index) => SizedBox(height: 1.8.h),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _PackagesHeader extends StatelessWidget {
  const _PackagesHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 8.8.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              SizedBox(
                width: 12.w,
                child: IconButton(
                  onPressed: _goBackFromPackages,
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
          Positioned(
            right: 4.w,
            bottom: .2.h,
            child: IgnorePointer(
              child: Opacity(
                opacity: .08,
                child: Icon(
                  Icons.local_shipping_rounded,
                  color: const Color(0xFF176DF2),
                  size: 8.5.h,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PackageSearchField extends StatelessWidget {
  const _PackageSearchField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7.3.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
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
            size: 3.5.h,
          ),
          SizedBox(width: 3.2.w),
          Expanded(
            child: TextFormField(
              controller: controller,
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                hintText: 'Search by HAWB / Tracking / Package No.',
                hintStyle: TextStyle(
                  color: const Color(0xFF8E95A3),
                  fontSize: 10.4.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: TextStyle(
                color: const Color(0xFF111D35),
                fontSize: 10.4.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: 2.w),
        ],
      ),
    );
  }
}

class _PackageCard extends GetView<AllDeliveryPackagesController> {
  const _PackageCard({required this.item});

  final GetAllPackage item;

  @override
  Widget build(BuildContext context) {
    final hasInvoice = item.isInvoice == 1;
    return Container(
      padding: EdgeInsets.fromLTRB(3.5.w, 2.2.h, 3.5.w, 1.7.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: const Color(0xFFEEF3FA)),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _PackageLine(
                  icon: Icons.calendar_month_outlined,
                  iconColor: const Color(0xFF8992A3),
                  label: 'Date:',
                  value: item.createdAt.toDDMMYYYY,
                ),
              ),
              SizedBox(width: 4.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _CompactValue(label: 'Quantity:', value: item.quantity.toString()),
                  SizedBox(height: 1.2.h),
                  _CompactValue(label: 'Weight:', value: _weightText(item.weight)),
                ],
              ),
            ],
          ),
          SizedBox(height: 2.h),
          _PackageLine(
            icon: Icons.work_outline_rounded,
            iconColor: const Color(0xFF176DF2),
            label: 'HAWB:',
            value: _firstNonEmpty([item.manifestNo, item.trackingNo]),
          ),
          _Divider(),
          _PackageLine(
            icon: Icons.inventory_2_outlined,
            iconColor: const Color(0xFFD88B2B),
            label: 'Carrier:',
            value: _firstNonEmpty([item.courier, item.merchant]),
          ),
          _Divider(),
          _PackageLine(
            icon: Icons.location_on_outlined,
            iconColor: const Color(0xFF16A8D7),
            label: 'Carrier Tracking No:',
            value: _firstNonEmpty([item.supplierTrackingNo, item.trackingNo]),
          ),
          _Divider(),
          _PackageLine(
            icon: Icons.sell_outlined,
            iconColor: const Color(0xFF344055),
            label: 'Package No:',
            value: item.pkNo.isEmpty ? '-' : item.pkNo,
          ),
          _Divider(),
          _PackageLine(
            icon: Icons.local_shipping_outlined,
            iconColor: const Color(0xFF16A8D7),
            label: 'Shipment Status:',
            customValue: _StatusChip(status: item.statusName),
          ),
          _Divider(),
          _PackageLine(
            icon: Icons.description_outlined,
            iconColor: const Color(0xFF344055),
            label: 'Description:',
            value: item.itemDescription,
          ),
          if (hasInvoice) ...[
            SizedBox(height: 1.7.h),
            SizedBox(
              width: double.infinity,
              height: 5.9.h,
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
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
                child: Row(
                  children: [
                    const Spacer(),
                    Text(
                      'Invoice Detail',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.2.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.chevron_right_rounded, size: 3.4.h),
                  ],
                ),
              ),
            ),
          ],
          SizedBox(height: 1.2.h),
          _InvoiceFileAction(
            item: item,
            onDone: () {
              if (Get.isDialogOpen ?? false) Get.back();
              controller.onUploadingInvoiceDone(item.packegId);
            },
          ),
        ],
      ),
    );
  }
}

class _InvoiceFileAction extends StatelessWidget {
  const _InvoiceFileAction({
    required this.item,
    required this.onDone,
  });

  final GetAllPackage item;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final hasFile = item.invoice.trim().isNotEmpty;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.2.w, vertical: 1.05.h),
      decoration: BoxDecoration(
        color: hasFile ? const Color(0xFFEAF4FF) : const Color(0xFFFFF6E8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: hasFile ? const Color(0xFFD4E6FF) : const Color(0xFFFFE2B8),
        ),
      ),
      child: Row(
        children: [
          DownloadButton(
            showDownloadButton: hasFile,
            id: item.packegId,
            fileURL: item.invoice,
            onDone: onDone,
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hasFile ? 'Invoice File' : 'Upload Invoice File',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: const Color(0xFF111D35),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 0.2.h),
                Text(
                  hasFile
                      ? 'Tap the icon to download the uploaded file.'
                      : 'Tap the icon to attach a file for this package.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: const Color(0xFF667085),
                    fontSize: 8.6.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
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

class _PackageLine extends StatelessWidget {
  const _PackageLine({
    required this.icon,
    required this.iconColor,
    required this.label,
    this.value,
    this.customValue,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final String? value;
  final Widget? customValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 7.2.w,
          child: Icon(
            icon,
            color: iconColor,
            size: 2.8.h,
          ),
        ),
        SizedBox(width: 2.2.w),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: customValue == null ? 46.w : 44.w,
          ),
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: const Color(0xFF111D35),
              fontSize: 10.2.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        SizedBox(width: 1.7.w),
        customValue ??
            Expanded(
              child: Text(
                value ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: const Color(0xFF176DF2),
                  fontSize: 10.4.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
      ],
    );
  }
}

class _CompactValue extends StatelessWidget {
  const _CompactValue({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$label  ',
            style: const TextStyle(
              color: Color(0xFF111D35),
              fontWeight: FontWeight.w800,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: Color(0xFF176DF2),
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 10.sp),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final normalized = status.trim().isEmpty ? 'Ready for Pickup' : status.trim();
    final isPaid = normalized.toLowerCase().contains('paid');
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: .8.h),
      decoration: BoxDecoration(
        color: isPaid ? const Color(0xFFE7F8F1) : const Color(0xFFEAF4FF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        normalized,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: isPaid ? const Color(0xFF10A66B) : const Color(0xFF176DF2),
          fontSize: 9.8.sp,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 9.4.w, top: 1.35.h, bottom: 1.35.h),
      child: const Divider(
        color: Color(0xFFE5EBF4),
        height: 1,
      ),
    );
  }
}

class _EmptyPackages extends StatelessWidget {
  const _EmptyPackages();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 14.h),
        Icon(
          Icons.inventory_2_outlined,
          color: const Color(0xFF9FB7D1),
          size: 8.h,
        ),
        SizedBox(height: 1.5.h),
        Text(
          'No packages found',
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

String _firstNonEmpty(List<String> values) {
  for (final value in values) {
    if (value.trim().isNotEmpty) return value.trim();
  }
  return '-';
}

String _weightText(String weight) {
  final clean = weight.trim();
  if (clean.isEmpty) return '-';
  if (clean.toLowerCase().contains('lb')) return clean;
  return '$clean lb';
}

void _goBackFromPackages() {
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
