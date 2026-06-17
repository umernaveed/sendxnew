import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/app/core/routes/app_pages.dart';
import 'package:sendx/app/extensions/string_ext.dart';
import 'package:sendx/data/models/invoice/invoice.dart';
import 'package:sendx/presentation/account/views/account_screen.dart';
import 'package:sendx/presentation/auth/widgets/auth_app_bar.dart';
import 'package:sendx/presentation/auth/widgets/text_field.dart';
import 'package:sendx/presentation/authorize/views/authorize_screen.dart';
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
      backgroundColor: const Color(0xFFFAF4F2).withOpacity(0.4),
      value: SystemUiOverlayStyle.dark,
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
                  child: PagedListView<int, Invoice>.separated(
                    pagingController: controller.pagingController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    builderDelegate: PagedChildBuilderDelegate(
                      animateTransitions: true,
                      transitionDuration: 500.milliseconds,
                      itemBuilder: (context, item, index) {
                        return _TrackPackagesItemWidget(
                          invoice: item,
                        );
                      },
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

class _TrackPackagesItemWidget extends StatelessWidget {
  const _TrackPackagesItemWidget({required this.invoice});
  final Invoice invoice;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _TrackPackagesItemKeyValueBuilder(
                subTitle: invoice.createdAt.toDDMMYYYY,
                title: 'Date created:',
                mainAxisAlignment: MainAxisAlignment.start,
                spaceBTW: 1.w,
              ),
            ),
            Expanded(
              child: _TrackPackagesItemKeyValueBuilder(
                subTitle: invoice.datePaid.toDDMMYYYY,
                title: 'Date Paid:',
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
                subTitle: invoice.invoiceNo.toString(),
                title: 'Invoice#:',
                mainAxisAlignment: MainAxisAlignment.start,
                spaceBTW: 1.w,
              ),
            ),
            Expanded(
              child: _TrackPackagesItemKeyValueBuilder(
                subTitle: invoice.userName,
                title: 'User Name:',
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
                subTitle: '${invoice.totalPaid} JMD',
                title: 'Invoice Paid:',
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                spaceBTW: 1.w,
              ),
            ),
            Expanded(
              child: _TrackPackagesItemKeyValueBuilder(
                subTitle: invoice.totalInvoice.toString(),
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
                customSubTitle: _Status(
                  title: invoice.status,
                  iconURL: 'assets/svgs/ic_paid.svg',
                ),
                title: 'Paid Status:',
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                spaceBTW: 1.w,
              ),
            ),
          ],
        ),
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
              arguments: invoice.invoiceNo.toString(),
            );
          },
        ),
        // SizedBox(height: 1.3.h),
        // const LascoButton(),
        SizedBox(height: 1.3.h),
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

class _Status extends StatelessWidget {
  const _Status({
    required this.title,
    this.iconURL,
    this.isUnpaid = false,
  });
  final String? iconURL;
  final String title;
  final bool isUnpaid;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2.9.h,
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        color: isUnpaid ? const Color(0xFFE94B4E) : const Color(0xFF4791CE),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if ((iconURL?.isNotEmpty ?? false) && !isUnpaid) ...[
            SvgPicture.asset(iconURL!),
            SizedBox(width: 1.w)
          ] else ...[
            if (isUnpaid) ...[
              Icon(
                Icons.close,
                color: Colors.white,
                size: 2.h,
              ),
              SizedBox(width: 1.w)
            ]
          ],
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
