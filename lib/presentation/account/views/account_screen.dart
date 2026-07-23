import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/app/core/routes/app_pages.dart';
import 'package:sendx/app/util/flush_snackbar.dart';
import 'package:sendx/presentation/account/controllers/account_controller.dart';
import 'package:sendx/presentation/base_screen.dart';
import 'package:sendx/presentation/bottom_nav/controllers/bottom_nav_controller.dart';
import 'package:sendx/presentation/widgets/dialogs/account_delete_dialog.dart';
import 'package:sizer/sizer.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      showGradients: false,
      value: SystemUiOverlayStyle.dark,
      backgroundColor: const Color(0xFFF8FBFF),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.fromLTRB(3.8.w, 0.4.h, 3.8.w, 2.5.h),
          child: Column(
            children: [
              const _AccountHeader(),
              SizedBox(height: 1.h),
              const _ProfileHero(),
              SizedBox(height: 1.8.h),
              const _MenuCard(),
              SizedBox(height: 1.8.h),
              const _AccountActionsCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class _AccountHeader extends StatelessWidget {
  const _AccountHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 9.5.h,
      child: Center(
        child: SvgPicture.asset(
          'assets/svgs/app_logo_sendx.svg',
          width: 23.w,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class _ProfileHero extends StatelessWidget {
  const _ProfileHero();

  @override
  Widget build(BuildContext context) {
    final controller = find<AccountController>();
    final bottomNav = find<BottomNavController>();
    return Obx(
      () {
        final user = controller.user.value;
        final name = user.completeName.trim().isNotEmpty
            ? user.completeName.trim()
            : user.userName.trim();
        return InkWell(
          borderRadius: BorderRadius.circular(17),
          onTap: () {
            Get.toNamed(
              AppPages.updateProfile,
              id: bottomNav.bottomNavNestedID,
            );
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(4.2.w, 2.6.h, 4.2.w, 2.6.h),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF0B3C9D),
                  Color(0xFF066CE8),
                ],
              ),
              borderRadius: BorderRadius.circular(17),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x22066CE8),
                  blurRadius: 22,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 8.6.h,
                  height: 8.6.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE92031),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                  ),
                  child: Icon(
                    Icons.priority_high_rounded,
                    color: Colors.white,
                    size: 5.4.h,
                  ),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              name.isEmpty ? 'SendX Customer' : name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.edit_outlined,
                            color: Colors.white,
                            size: 2.8.h,
                          ),
                        ],
                      ),
                      SizedBox(height: .6.h),
                      Text(
                        user.email,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white.withOpacity(.9),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 2.w),
                Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.white,
                  size: 4.h,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _MenuCard extends StatelessWidget {
  const _MenuCard();

  @override
  Widget build(BuildContext context) {
    final bottomNav = find<BottomNavController>();
    return _CardShell(
      child: Column(
        children: [
          _AccountNavTile(
            title: 'Dashboard',
            icon: Icons.home_outlined,
            color: const Color(0xFF176DF2),
            onTap: () => bottomNav.onTabChange(0),
          ),
          _Divider(),
          _ExpandableNavTile(
            title: 'Authorize User',
            icon: Icons.person_outline_rounded,
            color: const Color(0xFF19AAA0),
            children: [
              _ChildTile(
                title: 'Create Authorize User',
                onTap: () => Get.toNamed(
                  AppPages.addAuthorizeUser,
                  id: bottomNav.bottomNavNestedID,
                ),
              ),
              _ChildTile(
                title: 'Authorize Users',
                onTap: () => bottomNav.onTabChange(1),
              ),
            ],
          ),
          _Divider(),
          _ExpandableNavTile(
            title: 'My Account',
            icon: Icons.credit_card_rounded,
            color: const Color(0xFF8F45C8),
            children: [
              _ChildTile(
                title: 'Add Pre-Alert',
                onTap: () => Get.toNamed(
                  AppPages.addPreAlertScreen,
                  id: bottomNav.bottomNavNestedID,
                ),
              ),
              _ChildTile(
                title: 'Track Packages',
                onTap: () => Get.toNamed(
                  AppPages.trackPackages,
                  id: bottomNav.bottomNavNestedID,
                ),
              ),
              _ChildTile(
                title: 'Invoices',
                onTap: () => Get.toNamed(
                  AppPages.invoices,
                  id: bottomNav.bottomNavNestedID,
                ),
              ),
              _ChildTile(
                title: 'Unpaid Invoices',
                onTap: () => Get.toNamed(
                  AppPages.unpaidInvoicesScreen,
                  id: bottomNav.bottomNavNestedID,
                ),
              ),
            ],
          ),
          _Divider(),
          _ExpandableNavTile(
            title: 'Delivery System',
            icon: Icons.location_on_outlined,
            color: const Color(0xFFE0A10B),
            children: [
              _ChildTile(
                title: 'Request Delivery',
                onTap: () => bottomNav.onTabChange(2),
              ),
            ],
          ),
          _Divider(),
          _ExpandableNavTile(
            title: 'Purchase Request',
            icon: Icons.shopping_cart_outlined,
            color: const Color(0xFF16B86A),
            children: [
              _ChildTile(
                title: 'Create Purchase Request',
                onTap: () => Get.toNamed(
                  AppPages.addPurchase,
                  id: bottomNav.bottomNavNestedID,
                ),
              ),
              _ChildTile(
                title: 'Purchase Requests',
                onTap: () => Get.toNamed(
                  AppPages.purchase,
                  id: bottomNav.bottomNavNestedID,
                ),
              ),
            ],
          ),
          _Divider(),
          _AccountNavTile(
            title: 'Support Tickets',
            icon: Icons.headset_mic_outlined,
            color: const Color(0xFF176DF2),
            onTap: () => Get.toNamed(
              AppPages.supportTickets,
              id: bottomNav.bottomNavNestedID,
            ),
          ),
          _Divider(),
          _AccountNavTile(
            title: 'View Referral Users',
            icon: Icons.groups_outlined,
            color: const Color(0xFF8F45C8),
            onTap: () => Get.toNamed(
              AppPages.refferalUsers,
              id: bottomNav.bottomNavNestedID,
            ),
          ),
        ],
      ),
    );
  }
}

class _AccountActionsCard extends StatelessWidget {
  const _AccountActionsCard();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        children: const [
          _LogoutButton(),
          _Divider(),
          _DeleteButton(),
        ],
      ),
    );
  }
}

class _AccountNavTile extends StatelessWidget {
  const _AccountNavTile({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.75.h),
        child: Row(
          children: [
            _MenuIcon(icon: icon, color: color),
            SizedBox(width: 4.w),
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: const Color(0xFF111D35),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: const Color(0xFF253143),
              size: 3.h,
            ),
          ],
        ),
      ),
    );
  }
}

class _ExpandableNavTile extends StatelessWidget {
  const _ExpandableNavTile({
    required this.title,
    required this.icon,
    required this.color,
    required this.children,
  });

  final String title;
  final IconData icon;
  final Color color;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 4.w),
        childrenPadding: EdgeInsets.only(left: 17.w, right: 4.w, bottom: 1.2.h),
        leading: _MenuIcon(icon: icon, color: color),
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: const Color(0xFF111D35),
            fontSize: 13.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        iconColor: const Color(0xFF253143),
        collapsedIconColor: const Color(0xFF253143),
        children: children,
      ),
    );
  }
}

class _ChildTile extends StatelessWidget {
  const _ChildTile({
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: .9.h),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: const Color(0xFF586274),
                  fontSize: 10.5.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: const Color(0xFF8B95A5),
              size: 2.3.h,
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
    return _ActionTile(
      title: 'Log Out',
      subtitle: 'Securely log out from your account',
      icon: Icons.logout_rounded,
      color: const Color(0xFF176DF2),
      background: const Color(0xFFF4F8FF),
      onTap: () {
        final c = find<AccountController>();
        c.onLogOut().then((value) {
          if (value.isDone) {
            Get.offAllNamed(AppPages.login);
          } else if (value.message.isNotEmpty) {
            FlushSnackbar.showSnackBar(value.message);
          }
        });
      },
    );
  }
}

class _DeleteButton extends StatelessWidget {
  const _DeleteButton();

  @override
  Widget build(BuildContext context) {
    return _ActionTile(
      title: 'Delete Account',
      subtitle: 'Permanently delete your account',
      icon: Icons.delete_rounded,
      color: const Color(0xFFE92031),
      background: const Color(0xFFFFF1F3),
      onTap: () async {
        final result =
            await Get.dialog<bool>(const AccountDeleteConfirmationDialog());
        if (!(result ?? false)) return;
        final c = find<AccountController>();
        await c.deleteAccount();
      },
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.background,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Color background;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.7.h),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            _MenuIcon(icon: icon, color: color, bg: Colors.white),
            SizedBox(width: 4.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: color,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: .25.h),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: const Color(0xFF586274),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: const Color(0xFF253143),
              size: 3.h,
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuIcon extends StatelessWidget {
  const _MenuIcon({
    required this.icon,
    required this.color,
    this.bg,
  });

  final IconData icon;
  final Color color;
  final Color? bg;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 5.7.h,
      height: 5.7.h,
      decoration: BoxDecoration(
        color: bg ?? color.withOpacity(.12),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Icon(
        icon,
        color: color,
        size: 3.h,
      ),
    );
  }
}

class _CardShell extends StatelessWidget {
  const _CardShell({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(1.3.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: const Color(0xFFEEF3FA)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F092341),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1,
      color: Color(0xFFE9EEF6),
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
