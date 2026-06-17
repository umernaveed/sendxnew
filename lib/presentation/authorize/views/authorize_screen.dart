import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/app/core/routes/app_pages.dart';
import 'package:sendx/app/extensions/string_ext.dart';
import 'package:sendx/data/models/all_authorize_users_response/all_authorize_users_response.dart';
import 'package:sendx/presentation/account/views/account_screen.dart';
import 'package:sendx/presentation/auth/widgets/auth_app_bar.dart';
import 'package:sendx/presentation/auth/widgets/text_field.dart';
import 'package:sendx/presentation/authorize/controllers/authorize_controller.dart';
import 'package:sendx/presentation/base_screen.dart';
import 'package:sendx/presentation/bottom_nav/controllers/bottom_nav_controller.dart';
import 'package:sizer/sizer.dart';

class AuthorizeScreen extends GetView<AuthorizeController> {
  const AuthorizeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      showGradients: false,
      value: SystemUiOverlayStyle.dark,
      backgroundColor: const Color(0xFFFAF4F2).withOpacity(0.4),
      appBar: const AuthCustomAppBar.withSmallAppLogo(backButtonVisible: false),
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
                  child: PagedListView<int, AuthorizeUsersResponse>.separated(
                    padding: EdgeInsets.zero,
                    pagingController: controller.pagingController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    builderDelegate: PagedChildBuilderDelegate(
                      animateTransitions: true,
                      transitionDuration: 500.milliseconds,
                      itemBuilder: (context, item, index) =>
                          _AuthorizeItemWidget(item),
                    ),
                    separatorBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(top: 2.h, bottom: 2.h),
                      child: const AppDivider(),
                    ),
                  ),
                ),
              ),
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
      onTap: () =>
          Get.toNamed(AppPages.addAuthorizeUser, id: bottomNavNestedID),
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

class _AuthorizeItemWidget extends StatelessWidget {
  const _AuthorizeItemWidget(this.item);
  final AuthorizeUsersResponse item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _AuthorizeItemKeyValueBuilder(
              subTitle: item.createdAt.toDDMMYYYY,
              title: 'Created:',
            ),
          ],
        ),
        SizedBox(height: 1.5.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _AuthorizeItemKeyValueBuilder(
              subTitle: item.name,
              title: 'Name:',
              mainAxisAlignment: MainAxisAlignment.start,
              spaceBTW: 1.w,
            ),
          ],
        ),
        SizedBox(height: 1.5.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _AuthorizeItemKeyValueBuilder(
              subTitle: item.phone,
              title: 'Phone #:',
              mainAxisAlignment: MainAxisAlignment.start,
              spaceBTW: 1.w,
            ),
          ],
        ),
        SizedBox(height: 1.3.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _AuthorizeItemKeyValueBuilder(
              subTitle: item.proof,
              title: 'ID/Proof:',
              mainAxisAlignment: MainAxisAlignment.start,
              spaceBTW: 1.w,
            ),
            const SizedBox.shrink()
          ],
        ),
        SizedBox(height: 2.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ActionButton(
              title: 'Edit',
              width: context.width / 2.7,
              height: 5.h,
              onTap: () {
                final bottomNavNestedID =
                    find<BottomNavController>().bottomNavNestedID;
                Get.toNamed(
                  AppPages.addAuthorizeUser,
                  id: bottomNavNestedID,
                  arguments: item,
                );
              },
            ),
            SizedBox(height: 0.5.h),
            ActionButton(
              title: 'Delete',
              onTap: () {
                final controller = find<AuthorizeController>();
                controller.deleteAuthorizeUser(id: item.id.toString());
              },
              height: 5.h,
              width: context.width / 2.7,
              color: const Color(0xFFE94B4E),
            ),
          ],
        ),
      ],
    );
  }
}

class ActionButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color color;
  final double width;
  final double height;
  const ActionButton({
    super.key,
    required this.title,
    required this.onTap,
    this.color = const Color(0xFF4791CE),
    this.width = 57.76,
    this.height = 25.80,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        decoration: ShapeDecoration(
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 10.5.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _AuthorizeItemKeyValueBuilder extends StatelessWidget {
  final String title;
  final String subTitle;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final double spaceBTW;
  const _AuthorizeItemKeyValueBuilder({
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
