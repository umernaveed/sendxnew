import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/app/core/routes/app_pages.dart';
import 'package:sendx/app/extensions/string_ext.dart';
import 'package:sendx/data/models/get_packages_ready_for_pickup_response/get_packages_ready_for_pickup_response.dart';
import 'package:sendx/presentation/account/views/account_screen.dart';
import 'package:sendx/presentation/auth/widgets/text_field.dart';
import 'package:sendx/presentation/authorize/views/authorize_screen.dart';
import 'package:sendx/presentation/bottom_nav/controllers/bottom_nav_controller.dart';
import 'package:sendx/presentation/dashboard/controllers/dashboard_packages_controller.dart';
import 'package:sendx/presentation/widgets/buttons/download_button.dart';
import 'package:sendx/presentation/widgets/shimmer_widget.dart';
import 'package:sizer/sizer.dart';

class Packages extends GetView<DashboardPackagesController> {
  const Packages({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      margin: EdgeInsets.only(left: 4.5.w, right: 4.5.w, top: 4.h, bottom: 2.h),
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
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const PackagesReadyCounterButton(),
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
                child: PagedListView<int, Package>.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const AlwaysScrollableScrollPhysics(),
                  pagingController: controller.pagingController,
                  builderDelegate: PagedChildBuilderDelegate(
                    animateTransitions: true,
                    transitionDuration: 500.milliseconds,
                    firstPageProgressIndicatorBuilder: (context) {
                      return const ShimmerListView();
                    },
                    newPageProgressIndicatorBuilder: (context) {
                      return const ShimmerListView();
                    },
                    itemBuilder: (context, item, index) {
                      return _PackagesItemWidget(item);
                    },
                  ),
                  separatorBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 2.h, bottom: 2.h),
                      child: Column(
                        children: [
                          const AppDivider(),
                          SizedBox(height: 2.h),
                          const AppDivider(),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PackagesItemWidget extends GetView<DashboardPackagesController> {
  const _PackagesItemWidget(this.item);
  final Package item;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _PackagesItemKeyValueBuilder(
                  subTitle: item.createdAt.toDDMMYYYY,
                  //  '08-09-2023',
                  title: 'Date:',
                  mainAxisAlignment: MainAxisAlignment.start,
                  spaceBTW: 1.w,
                ),
                _PackagesItemKeyValueBuilder(
                  subTitle: item.userName,
                  title: 'User Name:',
                  mainAxisAlignment: MainAxisAlignment.start,
                  spaceBTW: 1.w,
                  visible: false,
                ),
              ],
            ),
            SizedBox(height: 1.5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // _PackagesItemKeyValueBuilder(
                //   subTitle: item.manifestNo,
                //   title: 'SPT #:',
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   spaceBTW: 1.w,
                //   visible: false,
                // ),
                _PackagesItemKeyValueBuilder(
                  subTitle: item.courier,
                  title: 'Shipper #:',
                  wrapWithElipsis: true,
                  mainAxisAlignment: MainAxisAlignment.end,
                  spaceBTW: 1.w,
                ),
              ],
            ),
            SizedBox(height: 1.5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // _PackagesItemKeyValueBuilder(
                //   subTitle: item.manifestNo,
                //   title: 'SPT #:',
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   spaceBTW: 1.w,
                //   visible: false,
                // ),
                _PackagesItemKeyValueBuilder(
                  subTitle: item.weight,
                  title: 'Weight :',
                  wrapWithElipsis: true,
                  mainAxisAlignment: MainAxisAlignment.end,
                  spaceBTW: 1.w,
                ),
              ],
            ),
            SizedBox(height: 1.5.h),
            _PackagesItemKeyValueBuilder(
              subTitle: item.supplierTrackingNo,
              title: 'Carrier Tracking:',
              mainAxisAlignment: MainAxisAlignment.start,
              spaceBTW: 1.w,
            ),
            SizedBox(height: 1.5.h),
            _PackagesItemKeyValueBuilder(
              subTitle: item.statusName,
              title: 'Shipment Status:',
              mainAxisAlignment: MainAxisAlignment.start,
              spaceBTW: 1.w,
            ),
            SizedBox(height: 1.h),
            DescriptionWidget(
              description: item.itemDescription,
            ),
            SizedBox(height: 1.h),
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
        ),
        Positioned(
          top: 0.h,
          right: 2.w,
          child: DownloadButton(
            showDownloadButton: item.invoice.isNotEmpty,
            id: item.packegId,
            fileURL: item.invoice,
            onDone: () {
              if (Get.isDialogOpen ?? false) Get.back();
              controller.onUploadingInvoiceDone(item.packegId);
            },
          ),
        )
      ],
    );
  }
}

class _PackagesItemKeyValueBuilder extends StatelessWidget {
  final String title;
  final String subTitle;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final bool wrapWithElipsis;
  final double spaceBTW;
  final bool visible;
  const _PackagesItemKeyValueBuilder({
    required this.title,
    required this.subTitle,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.spaceBTW = 0,
    this.wrapWithElipsis = false,
    this.visible = true,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Row(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: mainAxisAlignment,
        children: [
          Text(
            wrapWithElipsis ? title.toElipsis : title,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 9.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: spaceBTW),
          Text(
            wrapWithElipsis ? subTitle.toElipsis : subTitle,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 9.sp,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}

class PackagesReadyCounterButton extends StatelessWidget {
  const PackagesReadyCounterButton({super.key});

  @override
  Widget build(BuildContext context) {
    // final bottomNavNestedID = find<BottomNavController>().bottomNavNestedID;
    return Container(
      width: 220,
      height: 42,
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        color: const Color(0xFF4791CE),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: const Text(
        'Packages Ready at Counter',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class ShimmerListView extends StatelessWidget {
  const ShimmerListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 2,
      itemBuilder: (context, index) {
        return const PackagesShimmer();
      },
      separatorBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(top: 2.h, bottom: 2.h),
          child: Column(
            children: [
              const AppDivider(),
              SizedBox(height: 2.h),
              const AppDivider(),
            ],
          ),
        );
      },
    );
  }
}

class PackagesShimmer extends StatelessWidget {
  const PackagesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShimmerWidget(
              height: 4.h,
              width: 25.w,
              radius: BorderRadius.circular(3),
              child: _PackagesItemKeyValueBuilder(
                subTitle: '_',
                title: '_',
                mainAxisAlignment: MainAxisAlignment.start,
                spaceBTW: 1.w,
              ),
            ),
            ShimmerWidget(
              height: 4.h,
              width: 25.w,
              radius: BorderRadius.circular(3),
              child: _PackagesItemKeyValueBuilder(
                subTitle: '_',
                title: '_',
                mainAxisAlignment: MainAxisAlignment.start,
                spaceBTW: 1.w,
              ),
            ),
          ],
        ),
        SizedBox(height: 1.5.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShimmerWidget(
              height: 4.h,
              width: 25.w,
              radius: BorderRadius.circular(3),
              child: _PackagesItemKeyValueBuilder(
                subTitle: '_',
                title: '_',
                mainAxisAlignment: MainAxisAlignment.start,
                spaceBTW: 1.w,
              ),
            ),
            ShimmerWidget(
              height: 4.h,
              width: 25.w,
              radius: BorderRadius.circular(3),
              child: _PackagesItemKeyValueBuilder(
                subTitle: '_',
                title: '_',
                mainAxisAlignment: MainAxisAlignment.start,
                spaceBTW: 1.w,
              ),
            ),
          ],
        ),
        SizedBox(height: 1.5.h),
        ShimmerWidget(
          height: 4.h,
          width: context.width,
          radius: BorderRadius.circular(3),
          child: _PackagesItemKeyValueBuilder(
            subTitle: '_',
            title: '_',
            mainAxisAlignment: MainAxisAlignment.start,
            spaceBTW: 1.w,
          ),
        ),
        SizedBox(height: 1.5.h),
        ShimmerWidget(
          height: 4.h,
          width: context.width,
          radius: BorderRadius.circular(3),
          child: _PackagesItemKeyValueBuilder(
            subTitle: '_',
            title: '_',
            mainAxisAlignment: MainAxisAlignment.start,
            spaceBTW: 1.w,
          ),
        ),
        SizedBox(height: 1.5.h),
        ShimmerWidget(
          height: 4.h,
          width: context.width,
          radius: BorderRadius.circular(3),
          child: _PackagesItemKeyValueBuilder(
            subTitle: '_',
            title: '_',
            mainAxisAlignment: MainAxisAlignment.start,
            spaceBTW: 1.w,
          ),
        ),
        SizedBox(height: 1.3.h),
      ],
    );
  }
}

class DescriptionWidget extends StatelessWidget {
  final String description;
  final String? title;
  final TextStyle? descStyle;

  const DescriptionWidget(
      {super.key, required this.description, this.title, this.descStyle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title ?? 'Description:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 9.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          description,
          softWrap: true,
          textAlign: TextAlign.start,
          style: descStyle ??
              TextStyle(
                color: Colors.black,
                fontSize: 9.sp,
                fontWeight: FontWeight.w400,
              ),
        ),
      ],
    );
  }
}
