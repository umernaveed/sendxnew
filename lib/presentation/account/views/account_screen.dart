import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/app/core/routes/app_pages.dart';
import 'package:sendx/app/util/flush_snackbar.dart';
import 'package:sendx/presentation/account/controllers/account_controller.dart';
import 'package:sendx/presentation/auth/widgets/auth_app_bar.dart';
import 'package:sendx/presentation/base_screen.dart';
import 'package:sendx/presentation/bottom_nav/controllers/bottom_nav_controller.dart';
import 'package:sendx/presentation/widgets/cache_image.dart';
import 'package:sendx/presentation/widgets/dialogs/account_delete_dialog.dart';
import 'package:sizer/sizer.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = find<BottomNavController>();
    return BaseScreen(
      backgroundColor: const Color(0xFFFAF4F2).withOpacity(0.4),
      appBar: const AuthCustomAppBar.withSmallAppLogo(backButtonVisible: false),
      showGradients: false,
      bottomGradient: 'assets/images/img_account_bottom.png',
      value: SystemUiOverlayStyle.dark,
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 3.h),
                const UserProfileWidget(),
                SizedBox(height: 3.4.h),
                const AppDivider(),
                _AccountTile(
                  title: 'Dashboard',
                  iconURL: 'assets/svgs/ic_dashboard_account.png',
                  onTap: () {
                    controller.onTabChange(0);
                  },
                  trailingIcon: 'assets/svgs/ic_forward.png',
                  children: const [],
                ),
                const AppDivider(),
                _ExpandableAccountTile(
                  title: 'Authorize User',
                  iconURL: 'assets/svgs/ic_person_account.png',
                  onTap: () {},
                  trailingIcon: 'assets/svgs/ic_forward.png',
                  children: [
                    _TileChildWidgetBuilder(
                      title: 'Create Authorize User',
                      onTap: () {
                        Get.toNamed(AppPages.addAuthorizeUser,
                            id: controller.bottomNavNestedID);
                      },
                    ),
                    _TileChildWidgetBuilder(
                      title: 'Authorize Users',
                      onTap: () {
                        controller.onTabChange(1);
                      },
                    ),
                  ],
                ),
                const AppDivider(),
                _ExpandableAccountTile(
                  title: 'My Account',
                  iconURL: 'assets/svgs/ic_my_account.png',
                  onTap: () {},
                  trailingIcon: 'assets/svgs/ic_forward.png',
                  children: [
                    _TileChildWidgetBuilder(
                      title: 'Add Pre-Alert',
                      onTap: () {
                        Get.toNamed(AppPages.addPreAlertScreen,
                            id: controller.bottomNavNestedID);
                      },
                    ),
                    _TileChildWidgetBuilder(
                      title: 'Track Packages',
                      onTap: () {
                        Get.toNamed(AppPages.trackPackages,
                            id: controller.bottomNavNestedID);
                      },
                    ),
                    _TileChildWidgetBuilder(
                      title: 'Invoices',
                      onTap: () {
                        Get.toNamed(AppPages.invoices,
                            id: controller.bottomNavNestedID);
                      },
                    ),
                    _TileChildWidgetBuilder(
                      title: 'Unpaid Invoices',
                      onTap: () {
                        Get.toNamed(AppPages.unpaidInvoicesScreen,
                            id: controller.bottomNavNestedID);
                      },
                    ),
                  ],
                ),
                const AppDivider(),
                _ExpandableAccountTile(
                  title: 'Delivery System',
                  iconURL: 'assets/svgs/ic_delivery_account.png',
                  onTap: () {},
                  trailingIcon: 'assets/svgs/ic_forward.png',
                  children: [
                    _TileChildWidgetBuilder(
                      title: 'Request Delivery',
                      onTap: () {
                        controller.onTabChange(2);
                      },
                    ),
                    // _TileChildWidgetBuilder(
                    //   title: 'Delivery History',
                    //   onTap: () {
                    //     controller.onTabChange(1);
                    //   },
                    // ),
                  ],
                ),
                const AppDivider(),
                _ExpandableAccountTile(
                  title: 'Purchase Request',
                  iconURL: 'assets/svgs/ic_purchase_account.png',
                  onTap: () {},
                  trailingIcon: 'assets/svgs/ic_forward.png',
                  children: [
                    _TileChildWidgetBuilder(
                      title: 'Create Purchase Request',
                      onTap: () {
                        Get.toNamed(AppPages.addPurchase,
                            id: controller.bottomNavNestedID);
                      },
                    ),
                    _TileChildWidgetBuilder(
                      title: 'Purchase Requests',
                      onTap: () {
                        Get.toNamed(AppPages.purchase,
                            id: controller.bottomNavNestedID);
                        // controller.onTabChange(3);
                      },
                    ),
                  ],
                ),
                const AppDivider(),
                _AccountTile(
                  title: 'Support Tickets',
                  iconURL: 'assets/svgs/ic_purchase_account.png',
                  onTap: () {
                    Get.toNamed(AppPages.supportTickets,
                        id: controller.bottomNavNestedID);
                  },
                  trailingIcon: 'assets/svgs/ic_forward.png',
                  children: const [],
                ),
                const AppDivider(),
                _AccountTile(
                  title: 'View Refferal Users',
                  iconURL: 'assets/svgs/ic_purchase_account.png',
                  onTap: () {
                    Get.toNamed(AppPages.refferalUsers,
                        id: controller.bottomNavNestedID);
                  },
                  trailingIcon: 'assets/svgs/ic_forward.png',
                  children: const [],
                ),
                SizedBox(height: 2.h),
                const _LogoutButton(),
                SizedBox(height: 2.h),
                const _DeleteButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TileChildWidgetBuilder extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const _TileChildWidgetBuilder({
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(top: 0.8.h, bottom: 0.8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 18.5.w),
            Text(
              title,
              textAlign: TextAlign.start,
              style: context.textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF181725),
                fontSize: 9.5.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final c = find<AccountController>();
        c.onLogOut().then((value) {
          final isDone = value.isDone;
          final message = value.message;
          if (isDone) {
            Get.offAllNamed(AppPages.login);
          } else {
            if (message.isEmpty) return;
            FlushSnackbar.showSnackBar(message);
          }
        });
      },
      child: Container(
        width: 364,
        alignment: Alignment.center,
        height: 67,
        margin: EdgeInsets.symmetric(horizontal: 3.w),
        padding: EdgeInsets.symmetric(horizontal: 5.56.w),
        decoration: ShapeDecoration(
          color: const Color(0xFFF2F3F2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(19),
          ),
        ),
        child: Row(
          children: [
            Image.asset('assets/svgs/ic_logout.png'),
            const Spacer(),
            Text(
              'Log Out',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF4791CE),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            SizedBox(width: 10.w),
          ],
        ),
      ),
    );
  }
}

class AppDivider extends StatelessWidget {
  const AppDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 0,
      thickness: 1,
      color: Color(0xffE2E2E2),
    );
  }
}

class _ExpandableAccountTile extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final String iconURL;
  final String trailingIcon;
  final VoidCallback onTap;
  const _ExpandableAccountTile({
    required this.title,
    required this.children,
    required this.iconURL,
    required this.trailingIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        unselectedWidgetColor: Colors.black,
        colorScheme: const ColorScheme.light(primary: Colors.black),
        dividerColor: Colors.transparent,
      ),
      child: GestureDetector(
        onTap: () {
          onTap.call();
        },
        child: ExpansionTile(
          expandedAlignment: Alignment.centerLeft,
          leading: Image.asset(
            iconURL,
            width: 5.5.w,
            height: 5.5.h,
            fit: BoxFit.contain,
          ),
          // trailing: children.isEmpty ? const SizedBox.shrink() : null,
          title: Text(
            title,
            style: context.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF181725),
              fontSize: 10.5.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          children: [
            ...children,
            if (children.isNotEmpty) SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }
}

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = find<AccountController>();
    return Obx(
      () => Row(
        children: [
          SizedBox(width: 6.w),
          CachedImage(
            imageUrl: controller.user.value.image,
            width: 7.h,
            height: 7.h,
            circular: true,
          ),
          SizedBox(width: 4.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    controller.user.value.completeName,
                    style: TextStyle(
                      color: const Color(0xFF181725),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppPages.updateProfile);
                    },
                    child: SvgPicture.asset(
                      'assets/svgs/ic_edit.svg',
                      height: 1.8.h,
                      width: 1.9.w,
                    ),
                  )
                ],
              ),
              Text(
                controller.user.value.email,
                style: TextStyle(
                  color: const Color(0xFF7C7C7C),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _DeleteButton extends StatelessWidget {
  const _DeleteButton();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final result =
            await Get.dialog<bool>(const AccountDeleteConfirmationDialog());
        if (!(result ?? false)) return;
        final c = find<AccountController>();
        await c.deleteAccount();
      },
      child: Container(
        width: 364,
        alignment: Alignment.center,
        height: 67,
        margin: EdgeInsets.symmetric(horizontal: 3.w),
        padding: EdgeInsets.symmetric(horizontal: 5.56.w),
        decoration: ShapeDecoration(
          color: const Color(0xFFF2F3F2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.delete,
              color: Colors.red,
              size: 3.h,
            ),
            const Spacer(),
            Text(
              'Delete Account',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            SizedBox(width: 10.w),
          ],
        ),
      ),
    );
  }
}

class _AccountTile extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final String iconURL;
  final String trailingIcon;
  final VoidCallback onTap;

  const _AccountTile({
    required this.title,
    required this.children,
    required this.iconURL,
    required this.trailingIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        unselectedWidgetColor: Colors.black,
        colorScheme: const ColorScheme.light(primary: Colors.black),
        dividerColor: Colors.transparent,
      ),
      child: GestureDetector(
        onTap: () {
          onTap.call();
        },
        child: ListTile(
          leading: Image.asset(
            iconURL,
            width: 5.5.w,
            height: 5.5.h,
            fit: BoxFit.contain,
          ),
          title: Text(
            title,
            style: context.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF181725),
              fontSize: 10.5.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: children.isEmpty ? null : const Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}
