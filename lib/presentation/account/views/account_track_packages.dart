import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/app/core/routes/app_pages.dart';
import 'package:sendx/app/extensions/string_ext.dart';
import 'package:sendx/data/models/get_all_package/get_all_package.dart';
import 'package:sendx/presentation/account/controllers/get_delivery_packages_controller.dart';
import 'package:sendx/presentation/account/views/account_screen.dart';
import 'package:sendx/presentation/auth/widgets/auth_app_bar.dart';
import 'package:sendx/presentation/auth/widgets/text_field.dart';
import 'package:sendx/presentation/authorize/views/authorize_screen.dart';
import 'package:sendx/presentation/base_screen.dart';
import 'package:sendx/presentation/bottom_nav/controllers/bottom_nav_controller.dart';
import 'package:sizer/sizer.dart';

/// track packages
class AccountTrackePackages extends GetView<AllDeliveryPackagesController> {
  const AccountTrackePackages({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      wrapWithAnnotatedRegion: true,
      value: SystemUiOverlayStyle.dark,
      backgroundColor: const Color(0xFFFAF4F2).withOpacity(0.4),
      appBar: const AuthCustomAppBar.withSmallAppLogo(
        backButtonVisible: true,
        usingNavigator: true,
      ),
      body: Container(
        width: context.width,
        margin:
            EdgeInsets.only(left: 4.5.w, right: 4.5.w, top: 4.h, bottom: 2.h),
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
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
          child: Column(
            children: [
              SizedBox(height: 2.h),
              SearchField(
                controller: controller.textEditingController,
              ),
              SizedBox(height: 2.h),
              const AppDivider(),
              SizedBox(height: 2.h),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => Future.sync(
                    () => controller.pagingController.refresh(),
                  ),
                  child: PagedListView<int, GetAllPackage>.separated(
                    pagingController: controller.pagingController,
                    padding: EdgeInsets.zero,
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    builderDelegate: PagedChildBuilderDelegate(
                      animateTransitions: true,
                      transitionDuration: 500.milliseconds,
                      itemBuilder: (context, item, index) =>
                          _InvoicesItemWidget(item),
                    ),
                    separatorBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(top: 2.h, bottom: 2.h),
                      child: const AppDivider(),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _InvoicesItemWidget extends StatelessWidget {
  const _InvoicesItemWidget(this.item);
  final GetAllPackage item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _TrackPackagesItemKeyValueBuilder(
                subTitle: item.createdAt.toDDMMYYYY,
                title: 'Date:',
                mainAxisAlignment: MainAxisAlignment.start,
                spaceBTW: 1.w,
              ),
            ),
            Expanded(
              child: _TrackPackagesItemKeyValueBuilder(
                subTitle: item.quantity,
                title: 'Quantity:',
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
                subTitle: item.manifestNo,
                title: 'HAWB:',
                mainAxisAlignment: MainAxisAlignment.start,
                spaceBTW: 1.w,
              ),
            ),
            Expanded(
              child: _TrackPackagesItemKeyValueBuilder(
                subTitle: '${item.weight}  ',
                title: 'Weight:',
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                spaceBTW: 1.w,
              ),
            ),
            // Expanded(
            //   child: _TrackPackagesItemKeyValueBuilder(
            //     subTitle: item.trackingNo,
            //     title: 'Carrier Tracking:',
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     spaceBTW: 1.w,
            //   ),
            // ),
          ],
        ),
        SizedBox(height: 1.5.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _TrackPackagesItemKeyValueBuilder(
                subTitle: item.courier,
                title: 'Carrier:',
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                spaceBTW: 1.w,
              ),
            ),
            // Expanded(
            //   child: _TrackPackagesItemKeyValueBuilder(
            //     subTitle: '${item.weight}  ',
            //     title: 'Weight:',
            //     mainAxisSize: MainAxisSize.max,
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     spaceBTW: 1.w,
            //   ),
            // ),
          ],
        ),
        SizedBox(height: 1.5.h),
        _TrackPackagesItemKeyValueBuilder(
          subTitle: item.trackingNo,
          title: 'Carrier Tracking No:',
          mainAxisAlignment: MainAxisAlignment.start,
          spaceBTW: 1.w,
        ),
        SizedBox(height: 1.5.h),
        _TrackPackagesItemKeyValueBuilder(
          subTitle: item.pkNo,
          title: 'Package No:',
          mainAxisAlignment: MainAxisAlignment.start,
          spaceBTW: 1.w,
        ),
        SizedBox(height: 1.5.h),
        _TrackPackagesItemKeyValueBuilder(
          subTitle: item.statusName,
          title: 'Shipment Status:',
          mainAxisAlignment: MainAxisAlignment.start,
          spaceBTW: 1.w,
        ),
        SizedBox(height: 1.5.h),
        _TrackPackagesItemKeyValueBuilder(
          subTitle: item.itemDescription,
          title: 'Description:',
          mainAxisAlignment: MainAxisAlignment.start,
          spaceBTW: 1.w,
        ),
        SizedBox(height: 1.3.h),
        SizedBox(height: 1.3.h),
        ActionButton(
          title: 'Invoice Detail',
          width: context.width,
          height: 5.h,
          color: item.isInvoice == 1
              ? const Color(0xFF4791CE)
              : Colors.grey.withOpacity(0.4),
          onTap: () {
            if (item.isInvoice == 0) return;
            final bottomNavNestedID =
                find<BottomNavController>().bottomNavNestedID;
            Get.toNamed(
              AppPages.invoiceDetails,
              id: bottomNavNestedID,
              arguments: item.invoiceNo.toString(),
            );
          },
        ),
      ],
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
