import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/app/core/routes/app_pages.dart';
import 'package:sendx/app/extensions/string_ext.dart';
import 'package:sendx/data/models/unpaid_invoice/unpaid_invoice.dart';
import 'package:sendx/presentation/account/views/account_screen.dart';
import 'package:sendx/presentation/auth/views/login_screen.dart';
import 'package:sendx/presentation/auth/widgets/auth_app_bar.dart';
import 'package:sendx/presentation/auth/widgets/text_field.dart';
import 'package:sendx/presentation/authorize/views/authorize_screen.dart';
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
      value: SystemUiOverlayStyle.dark,
      backgroundColor: const Color(0xFFFAF4F2).withOpacity(0.4),
      appBar: const AuthCustomAppBar.withSmallAppLogo(
        backButtonVisible: true,
        usingNavigator: true,
      ),
      body: Container(
        width: context.width,
        margin:
            EdgeInsets.only(left: 4.5.w, right: 4.5.w, top: 1.h, bottom: 2.h),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(3),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 4,
              offset: Offset(0, 3),
              spreadRadius: 1.8,
            )
          ],
        ),
        child: Padding(
          padding:
              EdgeInsets.only(left: 5.w, right: 5.w, top: 3.h, bottom: 1.4.h),
          child: Column(
            children: [
              const SearchField(),
              SizedBox(height: 2.h),
              const AppDivider(),
              SizedBox(height: 2.h),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => Future.sync(
                    () => controller.onRefresh(),
                  ),
                  child: GetBuilder<UnpaidInvoicesController>(
                    id: 'unpaidInvoices',
                    builder: (_) {
                      return PagedListView<int, UnpaidInvoice>.separated(
                        pagingController: controller.pagingController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        restorationId: '1',
                        addAutomaticKeepAlives: true,
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        shrinkWrap: true,
                        builderDelegate: PagedChildBuilderDelegate(
                          itemBuilder: (context, item, index) {
                            return _UnpaidItem(
                              item: item,
                              onChanged: (e) {
                                controller.onItemChecked(item);
                              },
                            );
                          },
                        ),
                        separatorBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(top: 2.h, bottom: 2.h),
                          child: Column(
                            children: [
                              const AppDivider(),
                              SizedBox(height: 2.h),
                              const AppDivider(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              const AppDivider(),
              const _NoOfPackages(),
              const AppDivider(),
              const _TotalAmount(),
              const AppDivider(),
              SizedBox(height: 1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: AppButton(
                      title: 'Clear',
                      onTap: () => controller.onClear(),
                      backgroundColor: Colors.white,
                      side: BorderSide(
                        width: 1,
                        color: Colors.black.withOpacity(0.30000001192092896),
                      ),
                      textColor: const Color(0xFF7C7C7C),
                    ),
                  ),
                  SizedBox(width: 6.2.w),
                  Expanded(
                    flex: 2,
                    child: Obx(
                      () {
                        final count = controller.selectedItems.length;
                        return AppButton(
                          title: 'Pay Now',
                          onTap: count <= 0
                              ? null
                              : () async {
                                  final result =
                                      await controller.performPayment();
                                },
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _UnpaidItem extends StatelessWidget {
  const _UnpaidItem({required this.onChanged, required this.item});
  final void Function(bool?)? onChanged;
  final UnpaidInvoice item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 1.h),
        _CheckBoxTitle(
          item: item,
          onChanged: onChanged,
        ),
        SizedBox(height: 1.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: _TrackPackagesItemKeyValueBuilder(
                subTitle: item.createdAt?.toDDMMYYYY,
                title: 'Date created:',
                mainAxisAlignment: MainAxisAlignment.start,
                spaceBTW: 1.w,
              ),
            ),
            Expanded(
              child: _TrackPackagesItemKeyValueBuilder(
                subTitle: item.totalInvoice.toString(),
                title: 'Invoice Unpaid:',
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                spaceBTW: 1.w,
              ),
            ),
          ],
        ),
        SizedBox(height: 1.5.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _TrackPackagesItemKeyValueBuilder(
                subTitle: item.invoiceNo.toString(),
                title: 'Invoice#:',
                mainAxisAlignment: MainAxisAlignment.start,
                spaceBTW: 1.w,
              ),
            ),
            Expanded(
              child: _TrackPackagesItemKeyValueBuilder(
                subTitle: item.userName,
                title: 'User Name:',
                mainAxisAlignment: MainAxisAlignment.end,
                spaceBTW: 1.w,
              ),
            ),
          ],
        ),
        SizedBox(height: 1.5.h),
        SizedBox(height: 1.3.h),
        ActionButton(
          title: 'Invoice Detail',
          width: context.width,
          height: 5.h,
          onTap: () {
            final bottomNavNestedID =
                find<BottomNavController>().bottomNavNestedID;
            Get.toNamed(
              AppPages.invoiceDetails,
              id: bottomNavNestedID,
              arguments: item.invoiceNo.toString(),
            );
          },
        ),
        SizedBox(height: 1.3.h),
      ],
    );
  }
}

class _TotalAmount extends StatelessWidget {
  const _TotalAmount();

  @override
  Widget build(BuildContext context) {
    final controller = find<UnpaidInvoicesController>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Text(
              'Total Amount Due',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => Text(
                controller.totalAmount.toString(),
                style: const TextStyle(
                  color: Color(0xFF7C7C7C),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _NoOfPackages extends StatelessWidget {
  const _NoOfPackages();

  @override
  Widget build(BuildContext context) {
    final controller = find<UnpaidInvoicesController>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Text(
              'Total Invoices',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => Text(
                controller.selectedItems.length.toString(),
                style: const TextStyle(
                  color: Color(0xFF7C7C7C),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _TrackPackagesItemKeyValueBuilder extends StatelessWidget {
  final String title;
  final String? subTitle;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final double spaceBTW;
  final MainAxisSize mainAxisSize;
  final Widget? customSubTitle;
  const _TrackPackagesItemKeyValueBuilder({
    required this.title,
    this.subTitle,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.spaceBTW = 0,
    this.mainAxisSize = MainAxisSize.max,
    this.customSubTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: [
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.black,
            fontSize: 9.sp,
            fontWeight: FontWeight.w600,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: spaceBTW),
        customSubTitle ??
            Text(
              subTitle ?? '',
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 9.sp,
                fontWeight: FontWeight.w400,
                overflow: TextOverflow.ellipsis,
              ),
            )
      ],
    );
  }
}

class _CheckBoxTitle extends StatelessWidget {
  const _CheckBoxTitle({
    required this.onChanged,
    required this.item,
  });

  final void Function(bool?)? onChanged;
  final UnpaidInvoice item;

  @override
  Widget build(BuildContext context) {
    bool? isChecked = item.isToggleOn;
    return Row(
      children: [
        StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(
              height: 2.h,
              width: 4.w,
              child: Checkbox(
                value: isChecked,
                onChanged: (e) {
                  item.isToggleOn = e ?? false;
                  onChanged?.call(e);
                  setState(() {
                    isChecked = e;
                  });
                },
                activeColor: Colors.black,
                tristate: false,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                visualDensity: const VisualDensity(
                  horizontal: -4,
                  vertical: -4,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
