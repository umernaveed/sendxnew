import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/app/core/routes/app_pages.dart';
import 'package:sendx/app/extensions/string_ext.dart';
import 'package:sendx/data/models/get_all_package/get_all_package.dart';
import 'package:sendx/presentation/base_screen.dart';
import 'package:sendx/presentation/bottom_nav/controllers/bottom_nav_controller.dart';
import 'package:sendx/presentation/delivery/controllers/delivery_controller.dart';
import 'package:sizer/sizer.dart';

class DeliveryScreen extends GetView<DeliveryController> {
  const DeliveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      showGradients: false,
      value: SystemUiOverlayStyle.dark,
      backgroundColor: const Color(0xFFF8FBFF),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const _DeliveryHeader(),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(3.8.w, 1.1.h, 3.8.w, 1.2.h),
                padding: EdgeInsets.fromLTRB(2.8.w, 1.8.h, 2.8.w, 1.5.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
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
                    _DeliverySearchField(
                      controller: controller.textEditingController,
                    ),
                    SizedBox(height: 1.8.h),
                    Expanded(
                      child: RefreshIndicator(
                        color: const Color(0xFF0B6EDB),
                        onRefresh: () => Future.sync(
                          () => controller.onRefresh(),
                        ),
                        child: GetBuilder<DeliveryController>(
                          id: 'delivery',
                          builder: (_) {
                            return PagedListView<int, GetAllPackage>.separated(
                              pagingController: controller.pagingController,
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              restorationId: 'delivery',
                              addAutomaticKeepAlives: true,
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              builderDelegate:
                                  PagedChildBuilderDelegate<GetAllPackage>(
                                itemBuilder: (context, item, index) {
                                  return _DeliveryPackageCard(
                                    item: item,
                                    onChanged: (_) {
                                      controller.onItemChecked(item);
                                    },
                                  );
                                },
                                firstPageProgressIndicatorBuilder: (_) =>
                                    const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                newPageProgressIndicatorBuilder: (_) => Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.h),
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                                noItemsFoundIndicatorBuilder: (_) =>
                                    const _EmptyDelivery(),
                              ),
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 1.6.h),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 1.6.h),
                    const _DeliveryTotalsCard(),
                    SizedBox(height: 1.7.h),
                    const _DeliveryActions(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DeliveryHeader extends StatelessWidget {
  const _DeliveryHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 8.2.h,
      child: Row(
        children: [
          SizedBox(
            width: 12.w,
            child: IconButton(
              onPressed: _goBackFromDelivery,
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

class _DeliverySearchField extends StatelessWidget {
  const _DeliverySearchField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 6.6.h,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFE),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFEEF3FA)),
            ),
            child: Row(
              children: [
                SizedBox(width: 3.w),
                Icon(
                  Icons.search_rounded,
                  color: const Color(0xFF0B63BF),
                  size: 3.3.h,
                ),
                SizedBox(width: 2.7.w),
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      hintText: 'Search by HAWB, name, supplier or tracking...',
                      hintStyle: TextStyle(
                        color: const Color(0xFF8B919D),
                        fontSize: 10.2.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    style: TextStyle(
                      color: const Color(0xFF111D35),
                      fontSize: 10.2.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 2.7.w),
        Container(
          width: 13.5.w,
          height: 6.6.h,
          decoration: BoxDecoration(
            color: const Color(0xFFF2F8FF),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            Icons.filter_alt_outlined,
            color: const Color(0xFF0B63BF),
            size: 3.4.h,
          ),
        ),
      ],
    );
  }
}

class _DeliveryPackageCard extends StatefulWidget {
  const _DeliveryPackageCard({
    required this.item,
    required this.onChanged,
  });

  final GetAllPackage item;
  final ValueChanged<bool?> onChanged;

  @override
  State<_DeliveryPackageCard> createState() => _DeliveryPackageCardState();
}

class _DeliveryPackageCardState extends State<_DeliveryPackageCard> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.item.isToggleOn;
  }

  @override
  void didUpdateWidget(covariant _DeliveryPackageCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.item.isToggleOn != widget.item.isToggleOn) {
      isChecked = widget.item.isToggleOn;
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final hawb = item.manifestNo.isNotEmpty ? item.manifestNo : item.trackingNo;

    return Container(
      padding: EdgeInsets.fromLTRB(2.8.w, 1.6.h, 2.8.w, 1.5.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEEF3FA)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A092341),
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 4.8.w,
                height: 4.8.w,
                child: Checkbox(
                  value: isChecked,
                  onChanged: (value) {
                    widget.item.isToggleOn = value ?? false;
                    setState(() => isChecked = value ?? false);
                    widget.onChanged(value);
                  },
                  side: const BorderSide(
                    color: Color(0xFF344055),
                    width: 1.8,
                  ),
                  activeColor: const Color(0xFF0B6EDB),
                  checkColor: Colors.white,
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              SizedBox(width: 2.8.w),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'HAWB: ',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      TextSpan(text: hawb),
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: const Color(0xFF111D35),
                    fontSize: 11.2.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(
                Icons.calendar_month_outlined,
                color: const Color(0xFF0B6EDB),
                size: 2.8.h,
              ),
              SizedBox(width: 1.7.w),
              Text(
                item.createdAt.toDDMMYYYY,
                style: TextStyle(
                  color: const Color(0xFF111D35),
                  fontSize: 9.8.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.1.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    _PackageInfoRow(
                      icon: Icons.person_outline_rounded,
                      iconColor: const Color(0xFF0B6EDB),
                      iconBg: const Color(0xFFEAF4FF),
                      label: 'Name',
                      value: item.userName,
                    ),
                    SizedBox(height: 1.7.h),
                    _PackageInfoRow(
                      icon: Icons.local_shipping_outlined,
                      iconColor: const Color(0xFF6D35D9),
                      iconBg: const Color(0xFFF2ECFF),
                      label: 'Supplier Tracking',
                      value: item.supplierTrackingNo,
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 12.5.h,
                margin: EdgeInsets.symmetric(horizontal: 3.w),
                color: const Color(0xFFE9EEF6),
              ),
              Expanded(
                child: Column(
                  children: [
                    _PackageInfoRow(
                      icon: Icons.business_outlined,
                      iconColor: const Color(0xFF10A861),
                      iconBg: const Color(0xFFEAFBF2),
                      label: 'Supplier',
                      value: item.courier.isNotEmpty ? item.courier : item.merchant,
                    ),
                    SizedBox(height: 1.7.h),
                    _PackageInfoRow(
                      icon: Icons.description_outlined,
                      iconColor: const Color(0xFFF18A12),
                      iconBg: const Color(0xFFFFF6E8),
                      label: 'Description',
                      value: item.itemDescription,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 1.8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.2.h),
            decoration: BoxDecoration(
              color: const Color(0xFFEFFBF7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Text(
                  'Package Amount',
                  style: TextStyle(
                  color: const Color(0xFF0A9E69),
                    fontSize: 10.3.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Spacer(),
                Text(
                  _amountWithCurrency(item.packageInvoice),
                  style: TextStyle(
                  color: const Color(0xFF0A9E69),
                    fontSize: 11.5.sp,
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

class _PackageInfoRow extends StatelessWidget {
  const _PackageInfoRow({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 5.5.h,
          height: 5.5.h,
          decoration: BoxDecoration(
            color: iconBg,
            borderRadius: BorderRadius.circular(9),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 2.9.h,
          ),
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
                  color: const Color(0xFF586274),
                  fontSize: 9.2.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: .45.h),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: const Color(0xFF111D35),
                  fontSize: 10.sp,
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

class _DeliveryTotalsCard extends StatelessWidget {
  const _DeliveryTotalsCard();

  @override
  Widget build(BuildContext context) {
    final controller = find<DeliveryController>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.3.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEEF3FA)),
      ),
      child: Obx(
        () => Column(
          children: [
            _SummaryRow(
              icon: Icons.inventory_2_outlined,
              iconColor: const Color(0xFF0B6EDB),
              iconBg: const Color(0xFFEAF4FF),
              label: 'No. of Packages',
              value: controller.selectedItems.length.toString(),
              valueColor: const Color(0xFF0B63BF),
            ),
            const Divider(color: Color(0xFFE9EEF6), height: 18),
            _SummaryRow(
              icon: Icons.account_balance_wallet_outlined,
              iconColor: const Color(0xFF0A9E69),
              iconBg: const Color(0xFFEAFBF2),
              label: 'Total Amount Due',
              value: _amountWithCurrency(controller.totalAmount.value.toStringAsFixed(2)),
              valueColor: const Color(0xFF0A9E69),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.label,
    required this.value,
    required this.valueColor,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4.9.h,
          height: 4.9.h,
          decoration: BoxDecoration(
            color: iconBg,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 2.7.h),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: const Color(0xFF111D35),
              fontSize: 10.4.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: valueColor,
            fontSize: 11.2.sp,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

class _DeliveryActions extends StatelessWidget {
  const _DeliveryActions();

  @override
  Widget build(BuildContext context) {
    final controller = find<DeliveryController>();
    return Row(
      children: [
        Expanded(
          child: _OutlinedActionButton(
            title: 'Clear',
            icon: Icons.refresh_rounded,
            onTap: () => controller.onClear(),
          ),
        ),
        SizedBox(width: 3.w),
        Expanded(
          flex: 2,
          child: Obx(
            () {
              final count = controller.selectedItems.length;
              return _PrimaryActionButton(
                title: 'Create Request',
                icon: Icons.add_circle_outline_rounded,
                onTap: count <= 0
                    ? null
                    : () {
                        final bottomNavNestedID =
                            find<BottomNavController>().bottomNavNestedID;
                        Get.toNamed(
                          AppPages.managePickupRequest,
                          id: bottomNavNestedID,
                        );
                      },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _OutlinedActionButton extends StatelessWidget {
  const _OutlinedActionButton({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 6.4.h,
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFF111D35),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
            side: const BorderSide(color: Color(0xFFE5EBF4)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 2.9.h),
            SizedBox(width: 2.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 10.8.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrimaryActionButton extends StatelessWidget {
  const _PrimaryActionButton({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 6.4.h,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor:
              onTap == null ? const Color(0xFFB9C8DA) : const Color(0xFF0B6EDB),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 2.9.h),
            SizedBox(width: 2.w),
            Flexible(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 10.8.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyDelivery extends StatelessWidget {
  const _EmptyDelivery();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 12.h),
        Icon(
          Icons.local_shipping_outlined,
          color: const Color(0xFF9FB7D1),
          size: 8.h,
        ),
        SizedBox(height: 1.5.h),
        Text(
          'No delivery packages found',
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
  if (value.isEmpty) return 'JMD 0.00';
  if (value.toUpperCase().contains('JMD')) return value;
  return 'JMD $value';
}

void _goBackFromDelivery() {
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
