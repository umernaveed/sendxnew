import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/app/core/routes/app_pages.dart';
import 'package:sendx/app/extensions/string_ext.dart';
import 'package:sendx/data/models/purchase/purchase.dart';
import 'package:sendx/presentation/account/views/account_screen.dart';
import 'package:sendx/presentation/auth/widgets/auth_app_bar.dart';
import 'package:sendx/presentation/auth/widgets/text_field.dart';
import 'package:sendx/presentation/base_screen.dart';
import 'package:sendx/presentation/bottom_nav/controllers/bottom_nav_controller.dart';
import 'package:sendx/presentation/dashboard/views/packages.dart';
import 'package:sendx/presentation/purchase/controllers/purchase_controller.dart';
import 'package:sizer/sizer.dart';

class PurchasesScreen extends GetView<PurchaseController> {
  const PurchasesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      showGradients: false,
      value: SystemUiOverlayStyle.dark,
      backgroundColor: const Color(0xFFFAF4F2).withOpacity(0.4),
      appBar: AuthCustomAppBar.withSmallAppLogo(
        backButtonVisible: true,
        backID: find<BottomNavController>().bottomNavNestedID,
      ),
      body: Container(
        width: context.width,
        margin: EdgeInsets.only(left: 6.w, right: 6.w, top: 5.h, bottom: 2.h),
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
              const AddNew(),
              SizedBox(height: 2.h),
              const SearchField(),
              SizedBox(height: 2.h),
              const AppDivider(),
              SizedBox(height: 2.h),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => Future.sync(
                    () => controller.pagingController.refresh(),
                  ),
                  child: PagedListView<int, Purchase>.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    pagingController: controller.pagingController,
                    padding: EdgeInsets.zero,
                    builderDelegate: PagedChildBuilderDelegate(
                      animateTransitions: true,
                      transitionDuration: 500.milliseconds,
                      itemBuilder: (context, item, index) =>
                          _PurchasedItemWidget(item),
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

class AddNew extends StatelessWidget {
  const AddNew({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavNestedID = find<BottomNavController>().bottomNavNestedID;
    return InkWell(
      onTap: () {
        Get.toNamed(
          AppPages.addPurchase,
          id: bottomNavNestedID,
        );
      },
      child: Container(
        width: 109,
        height: 42,
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          color: const Color(0xFF4791CE),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Add New',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
            SizedBox(width: 2.w),
            SvgPicture.asset('assets/svgs/ic_add_new_plus.svg')
          ],
        ),
      ),
    );
  }
}

class _PurchasedItemWidget extends StatelessWidget {
  const _PurchasedItemWidget(this.item);
  final Purchase item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PurchasedItemKeyValueBuilder(
          subTitle: item.createdAt.toDDMMYYYY,
          title: 'Created:',
        ),
        SizedBox(height: 2.2.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _PurchasedItemKeyValueBuilder(
              subTitle: item.name,
              title: 'Name:',
              mainAxisAlignment: MainAxisAlignment.start,
              spaceBTW: 1.w,
            ),
            _PurchasedItemKeyValueBuilder(
              subTitle: item.qty.toString(),
              title: 'Quantity:',
              mainAxisAlignment: MainAxisAlignment.start,
              spaceBTW: 1.w,
            ),
          ],
        ),
        SizedBox(height: 1.5.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _PurchasedItemKeyValueBuilder(
              subTitle: item.link,
              title: 'Link:',
              mainAxisAlignment: MainAxisAlignment.start,
              spaceBTW: 1.w,
            ),
            // _PurchasedItemKeyValueBuilder(
            //   subTitle: '',
            //   title: 'Action',
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   spaceBTW: 1.w,
            // ),
          ],
        ),
        SizedBox(height: 1.3.h),
        DescriptionWidget(
          description: item.notes,
          title: 'Notes',
          descStyle: TextStyle(
            color: Colors.black,
            fontSize: 9.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        _EditButton(item),
      ],
    );
  }
}

class _EditButton extends StatelessWidget {
  const _EditButton(this.item);
  final Purchase item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final bottomNavNestedID = find<BottomNavController>().bottomNavNestedID;
        Get.toNamed(AppPages.addPurchase,
            id: bottomNavNestedID, arguments: item);
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 1.h),
        width: context.width,
        height: 4.5.h,
        decoration: ShapeDecoration(
          color: const Color(0xFF4791CE),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: Text(
          'Edit',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _PurchasedItemKeyValueBuilder extends StatelessWidget {
  final String title;
  final String subTitle;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final double spaceBTW;
  const _PurchasedItemKeyValueBuilder({
    required this.title,
    required this.subTitle,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.spaceBTW = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      children: [
        _TitleBuilder(title: title),
        SizedBox(width: spaceBTW),
        Text(
          subTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 9.sp,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }
}

class _TitleBuilder extends StatelessWidget {
  final String title;
  const _TitleBuilder({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black,
        fontSize: 9.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
