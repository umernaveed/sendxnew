import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/app/core/routes/app_pages.dart';
import 'package:sendx/app/extensions/string_ext.dart';
import 'package:sendx/data/models/get_all_package/get_all_package.dart';
import 'package:sendx/presentation/account/views/account_screen.dart';
import 'package:sendx/presentation/auth/views/login_screen.dart';
import 'package:sendx/presentation/auth/widgets/auth_app_bar.dart';
import 'package:sendx/presentation/auth/widgets/text_field.dart';
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
      backgroundColor: const Color(0xFFFAF4F2).withOpacity(0.4),
      appBar: const AuthCustomAppBar.withSmallAppLogo(backButtonVisible: false),
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
                  child: GetBuilder<DeliveryController>(
                    id: 'delivery',
                    builder: (_) {
                      return PagedListView<int, GetAllPackage>.separated(
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
                            return _DeliveryItem(
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
                          title: 'Create Request',
                          onTap: count <= 0
                              ? null
                              : () {
                                  final bottomNavNestedID =
                                      find<BottomNavController>()
                                          .bottomNavNestedID;
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _DeliveryItem extends StatelessWidget {
  const _DeliveryItem({required this.onChanged, required this.item});
  final void Function(bool?)? onChanged;
  final GetAllPackage item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CheckBoxTitle(
                  subTitle: item.manifestNo,
                  onChanged: onChanged,
                  title: 'HAWB:',
                  item: item,
                ),
              ],
            ),
            Expanded(
              child: _DeliveryItemKeyValueBuilder(
                subTitle: item.createdAt.toDDMMYYYY,
                title: 'Date:',
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
              child: _DeliveryItemKeyValueBuilder(
                subTitle: item.userName,
                title: 'Name:',
                mainAxisAlignment: MainAxisAlignment.start,
                spaceBTW: 1.w,
              ),
            ),
            Expanded(
              child: _DeliveryItemKeyValueBuilder(
                subTitle: item.courier,
                title: 'Supplier:',
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
              child: _DeliveryItemKeyValueBuilder(
                subTitle: item.supplierTrackingNo,
                title: 'Supplier Tracking: ',
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
            Expanded(
              child: _DeliveryItemKeyValueBuilder(
                subTitle: item.itemDescription,
                title: 'Description:',
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
            Expanded(
              child: _DeliveryItemKeyValueBuilder(
                subTitle: item.packageInvoice,
                title: 'Package Amount:',
                mainAxisAlignment: MainAxisAlignment.start,
                spaceBTW: 1.w,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _TotalAmount extends StatelessWidget {
  const _TotalAmount();

  @override
  Widget build(BuildContext context) {
    final controller = find<DeliveryController>();
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
    final controller = find<DeliveryController>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Text(
              'No. of Packages',
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

class _DeliveryItemKeyValueBuilder extends StatelessWidget {
  final String title;
  final String? subTitle;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final double spaceBTW;
  final MainAxisSize mainAxisSize;
  final Widget? customSubTitle;
  const _DeliveryItemKeyValueBuilder({
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
          textAlign: TextAlign.start,
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
              textAlign: TextAlign.end,
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

class CheckBoxTitle extends StatelessWidget {
  const CheckBoxTitle({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onChanged,
    required this.item,
  });
  final String title;
  final String subTitle;
  final void Function(bool?)? onChanged;
  final GetAllPackage item;

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
        SizedBox(width: 2.w),
        _DeliveryItemKeyValueBuilder(
          title: title,
          subTitle: subTitle,
          spaceBTW: 1.w,
        ),
      ],
    );
  }
}
