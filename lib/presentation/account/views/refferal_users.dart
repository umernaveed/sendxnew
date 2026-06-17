import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/data/models/refferal_user/refferal_user.dart';
import 'package:sendx/presentation/account/controllers/refferal_users_controller.dart';
import 'package:sendx/presentation/account/views/account_screen.dart';
import 'package:sendx/presentation/auth/widgets/auth_app_bar.dart';
import 'package:sendx/presentation/auth/widgets/text_field.dart';
import 'package:sendx/presentation/base_screen.dart';
import 'package:sendx/presentation/bottom_nav/controllers/bottom_nav_controller.dart';
import 'package:sendx/presentation/dashboard/views/packages.dart';
import 'package:sizer/sizer.dart';

class RefferralUsers extends GetView<RefferalUsersController> {
  const RefferralUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      value: SystemUiOverlayStyle.dark,
      appBar: AuthCustomAppBar.withSmallAppLogo(
        backButtonVisible: true,
        backID: find<BottomNavController>().bottomNavNestedID,
      ),
      showGradients: false,
      backgroundColor: const Color(0xFFFAF4F2).withOpacity(0.4),
      body: Container(
        width: context.width,
        margin:
            EdgeInsets.only(left: 4.5.w, right: 4.5.w, top: 4.h, bottom: 2.h),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(3)),
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
                  child: PagedListView<int, RefferalUser>.separated(
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
                        return _RefferalUserItem(user: item);
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
      ),
    );
  }
}

class _RefferalUserItem extends StatelessWidget {
  const _RefferalUserItem({required this.user});
  final RefferalUser user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _RefferalKeyValueBuilder(
              subTitle: user.firstName,
              title: 'User Name:',
              mainAxisAlignment: MainAxisAlignment.start,
              spaceBTW: 1.w,
            ),
            _RefferalKeyValueBuilder(
              subTitle: user.status,
              title: 'Status:',
              mainAxisAlignment: MainAxisAlignment.start,
              spaceBTW: 1.w,
            ),
          ],
        ),
        SizedBox(height: 1.5.h),
        _RefferalKeyValueBuilder(
          subTitle: '\$${user.pendingBalance}',
          title: 'Pending Balance:',
          mainAxisAlignment: MainAxisAlignment.start,
          spaceBTW: 1.w,
        ),
        SizedBox(height: 1.5.h),
        _RefferalKeyValueBuilder(
          subTitle: '\$${user.availableBalance}',
          title: 'Available Balance:',
          mainAxisAlignment: MainAxisAlignment.start,
          spaceBTW: 1.w,
        ),
        SizedBox(height: 1.5.h),
        Row(
          children: [
            Expanded(
              child: DescriptionWidget(
                description: user.description.toString(),
              ),
            )
          ],
        ),
        SizedBox(height: 1.5.h),
      ],
    );
  }
}

class _RefferalKeyValueBuilder extends StatelessWidget {
  final String title;
  final String? subTitle;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final double spaceBTW;
  final MainAxisSize mainAxisSize;
  final Widget? customSubTitle;
  const _RefferalKeyValueBuilder({
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
