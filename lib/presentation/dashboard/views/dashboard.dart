import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sendx/app/core/routes/app_pages.dart';
import 'package:sendx/app/core/theme/app_colors.dart';
import 'package:sendx/app/util/flush_snackbar.dart';
import 'package:sendx/data/models/dashboard_data/dashboard_data.dart';
import 'package:sendx/data/models/user/user.dart';
import 'package:sendx/domain/repositories/local_repository.dart';
import 'package:sendx/presentation/bottom_nav/controllers/bottom_nav_controller.dart';
import 'package:sendx/presentation/dashboard/controllers/dashboard_controller.dart';
import 'package:sendx/presentation/widgets/shimmer_widget.dart';
import 'package:sizer/sizer.dart';

class Dashboard extends GetView<DashboardController> {
  const Dashboard({super.key});

  User get _user {
    if (!Get.isRegistered<LocalRepository>()) return User.empty();
    return Get.find<LocalRepository>().getInstantUser();
  }

  void _openRoute(String route) {
    if (Get.isRegistered<BottomNavController>()) {
      Get.toNamed(route, id: Get.find<BottomNavController>().bottomNavNestedID);
      return;
    }
    Get.toNamed(route);
  }

  void _openTab(int index) {
    if (Get.isRegistered<BottomNavController>()) {
      Get.find<BottomNavController>().onTabChange(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.cyan,
      onRefresh: controller.refreshData,
      child: controller.obx(
        (state) {
          final data = state ?? DashboardData.defaultValues();
          final user = _user;

          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(4.w, 0.4.h, 4.w, 2.5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HeroSummaryCard(
                  data: data,
                  user: user,
                  onCopyAccount: () => _copyText(_accountNumber(user, data)),
                  onInvoices: () => _openRoute(AppPages.invoices),
                  onPackages: () => _openRoute(AppPages.trackPackages),
                ),
                SizedBox(height: 2.h),
                _StatsStrip(
                  data: data,
                  onWarehouse: () => _openRoute(AppPages.trackPackages),
                  onTransit: () => _openRoute(AppPages.trackPackages),
                  onReady: () => _openRoute(AppPages.trackPackages),
                  onBalance: () => _openRoute(AppPages.invoices),
                ),
                SizedBox(height: 2.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _RewardsWalletCard(data: data)),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: _ReferEarnCard(
                        data: data,
                        onShare: () => _copyText(data.referralCode),
                        onQr: () => _showReferralQr(context, data.referralCode),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                _PackageOverviewCard(
                  data: data,
                  onViewAll: () => _openRoute(AppPages.trackPackages),
                ),
                SizedBox(height: 2.h),
                _QuickActionsCard(
                  actions: [
                    _QuickAction(
                      icon: Icons.add_a_photo_outlined,
                      label: 'Add\nPackage',
                      color: AppColors.cyan,
                      onTap: () => _openRoute(AppPages.addPreAlertScreen),
                    ),
                    _QuickAction(
                      icon: Icons.description_outlined,
                      label: 'My\nInvoices',
                      color: const Color(0xFF7568F0),
                      onTap: () => _openRoute(AppPages.invoices),
                    ),
                    _QuickAction(
                      icon: Icons.support_agent_rounded,
                      label: 'Support\nTicket',
                      color: const Color(0xFFFF8A20),
                      onTap: () => _openRoute(AppPages.supportTickets),
                    ),
                    _QuickAction(
                      icon: Icons.location_on_outlined,
                      label: 'Track\nShipment',
                      color: const Color(0xFF24B36B),
                      onTap: () => _openRoute(AppPages.trackPackages),
                    ),
                    _QuickAction(
                      icon: Icons.calculate_outlined,
                      label: 'Rate\nCalculator',
                      color: AppColors.coral,
                      onTap: () => _openTab(2),
                    ),
                  ],
                ),
                if (data.accountManager.trim().isNotEmpty) ...[
                  SizedBox(height: 2.h),
                  _ManagerCard(data: data),
                ],
              ],
            ),
          );
        },
        onLoading: const _DashboardLoading(),
        onError: (error) => _DashboardError(
          message: error ?? 'Unable to load dashboard',
          onRetry: controller.refreshData,
        ),
      ),
    );
  }

  void _copyText(String value) {
    final text = value.trim();
    if (text.isEmpty) return;
    Clipboard.setData(ClipboardData(text: text));
    FlushSnackbar.showSnackBar('Copied to clipboard', isError: false);
  }

  void _showReferralQr(BuildContext context, String code) {
    if (code.trim().isEmpty) {
      FlushSnackbar.showSnackBar('Referral code is not available',
          isError: true);
      return;
    }
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          margin: EdgeInsets.all(4.w),
          padding: EdgeInsets.all(6.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Referral QR Code',
                style: TextStyle(
                  color: AppColors.ink,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 2.h),
              QrImageView(
                data: code,
                version: QrVersions.auto,
                size: 52.w,
              ),
              SizedBox(height: 1.5.h),
              Text(
                code,
                style: const TextStyle(
                  color: AppColors.muted,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _HeroSummaryCard extends StatelessWidget {
  final DashboardData data;
  final User user;
  final VoidCallback onCopyAccount;
  final VoidCallback onInvoices;
  final VoidCallback onPackages;

  const _HeroSummaryCard({
    required this.data,
    required this.user,
    required this.onCopyAccount,
    required this.onInvoices,
    required this.onPackages,
  });

  @override
  Widget build(BuildContext context) {
    final firstName =
        user.firstName.trim().isEmpty ? 'Customer' : user.firstName;
    final account = _accountNumber(user, data);
    final memberLabel =
        user.userType.trim().isEmpty ? 'SendX Member' : user.userType.trim();

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF176CFF),
            Color(0xFF7B39D8),
            AppColors.coral,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.coral.withOpacity(0.22),
            blurRadius: 26,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              _InitialsAvatar(name: user.completeName),
              SizedBox(width: 3.5.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, $firstName',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 0.7.h),
                    InkWell(
                      onTap: onCopyAccount,
                      borderRadius: BorderRadius.circular(10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              'Account ID: $account',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.86),
                                fontSize: 12.5.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: 1.4.w),
                          Icon(
                            Icons.copy_rounded,
                            size: 15,
                            color: Colors.white.withOpacity(0.82),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                constraints: BoxConstraints(maxWidth: 35.w),
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.13),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white.withOpacity(0.25)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star_rounded,
                        color: Color(0xFFFFD64D), size: 18),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        memberLabel,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 2.6.h),
          Row(
            children: [
              Expanded(
                child: _HeroMetric(
                  label: 'Outstanding Balance',
                  value: _money(data.outstandingBalance),
                  trailing: Icons.visibility_outlined,
                  buttonText: 'View Invoices',
                  buttonIcon: Icons.receipt_long_outlined,
                  onTap: onInvoices,
                ),
              ),
              Container(
                height: 10.h,
                width: 1,
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                color: Colors.white.withOpacity(0.25),
              ),
              Expanded(
                child: _HeroMetric(
                  label: 'Packages Ready',
                  value: '${_safeInt(data.outstandingPackage)}',
                  valueSuffix: ' For Pickup',
                  trailing: Icons.inventory_2_outlined,
                  buttonText: 'View Packages',
                  buttonIcon: Icons.chevron_right_rounded,
                  onTap: onPackages,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroMetric extends StatelessWidget {
  final String label;
  final String value;
  final String? valueSuffix;
  final IconData trailing;
  final String buttonText;
  final IconData buttonIcon;
  final VoidCallback onTap;

  const _HeroMetric({
    required this.label,
    required this.value,
    required this.trailing,
    required this.buttonText,
    required this.buttonIcon,
    required this.onTap,
    this.valueSuffix,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.88),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(width: 1.w),
            Icon(trailing, color: Colors.white.withOpacity(0.8), size: 16),
          ],
        ),
        SizedBox(height: 0.8.h),
        RichText(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            children: [
              TextSpan(
                text: value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
              if (valueSuffix != null)
                TextSpan(
                  text: valueSuffix,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.88),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 1.8.h),
        _GlassButton(
          text: buttonText,
          icon: buttonIcon,
          onTap: onTap,
        ),
      ],
    );
  }
}

class _StatsStrip extends StatelessWidget {
  final DashboardData data;
  final VoidCallback onWarehouse;
  final VoidCallback onTransit;
  final VoidCallback onReady;
  final VoidCallback onBalance;

  const _StatsStrip({
    required this.data,
    required this.onWarehouse,
    required this.onTransit,
    required this.onReady,
    required this.onBalance,
  });

  @override
  Widget build(BuildContext context) {
    return _ModernCard(
      padding: EdgeInsets.symmetric(vertical: 2.2.h),
      child: Row(
        children: [
          _StatTile(
            icon: Icons.warehouse_outlined,
            iconColor: const Color(0xFF176CFF),
            value: '${_safeInt(data.wherehouse)}',
            label: 'Miami Warehouse',
            onTap: onWarehouse,
          ),
          _DividerLine(),
          _StatTile(
            icon: Icons.local_shipping_outlined,
            iconColor: const Color(0xFF8E37D7),
            value: '${_safeInt(data.inTransit)}',
            label: 'In Transit',
            onTap: onTransit,
          ),
          _DividerLine(),
          _StatTile(
            icon: Icons.check_circle_rounded,
            iconColor: const Color(0xFF15BF4E),
            value: '${_safeInt(data.outstandingPackage)}',
            label: 'Ready for Pickup',
            onTap: onReady,
          ),
          _DividerLine(),
          _StatTile(
            icon: Icons.account_balance_wallet_outlined,
            iconColor: const Color(0xFFFF8A20),
            value: _money(data.outstandingBalance),
            label: 'Outstanding Balance',
            onTap: onBalance,
          ),
        ],
      ),
    );
  }
}

class _RewardsWalletCard extends StatelessWidget {
  final DashboardData data;

  const _RewardsWalletCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final usdRate = _toNum(data.setting.usRate);
    final rewardPackages = math.max(_toInt(data.setting.rewardPackages), 1);
    final shipped = math.min(_safeInt(data.packageCount), rewardPackages);
    final remaining = math.max(rewardPackages - shipped, 0);
    final progress = (shipped / rewardPackages).clamp(0.0, 1.0).toDouble();
    final usd = _toNum(data.memberPoints);
    final jmd = usd * usdRate;

    return _ModernCard(
      tint: const Color(0xFFF3FFF7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle(
            icon: Icons.card_giftcard_rounded,
            title: 'Rewards Wallet',
            color: Color(0xFF128846),
          ),
          SizedBox(height: 2.h),
          _AmountLine(value: '${usd.toStringAsFixed(2)} USD'),
          Text('Rewards Balance', style: _mutedSmall),
          SizedBox(height: 1.3.h),
          _AmountLine(value: '${jmd.toStringAsFixed(2)} JMD'),
          Text('Rewards Balance', style: _mutedSmall),
          SizedBox(height: 2.h),
          const Divider(color: AppColors.border),
          SizedBox(height: 1.h),
          Row(
            children: [
              Expanded(
                child: Text(
                  '$shipped / $rewardPackages packages',
                  style: _smallBold,
                ),
              ),
              Text(
                '${(progress * 100).round()}%',
                style: _smallBold,
              ),
            ],
          ),
          SizedBox(height: 0.9.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              minHeight: 8,
              value: progress,
              color: AppColors.cyan,
              backgroundColor: const Color(0xFFE3E7EA),
            ),
          ),
          SizedBox(height: 1.2.h),
          Text(
            remaining == 0
                ? 'Reward target reached.'
                : 'Ship $remaining more packages to earn ${data.setting.rewardAmount} USD',
            style: TextStyle(
              color: AppColors.ink.withOpacity(0.74),
              fontSize: 11.sp,
              height: 1.25,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReferEarnCard extends StatelessWidget {
  final DashboardData data;
  final VoidCallback onShare;
  final VoidCallback onQr;

  const _ReferEarnCard({
    required this.data,
    required this.onShare,
    required this.onQr,
  });

  @override
  Widget build(BuildContext context) {
    final amount = _toNum(data.setting.referralAmount).toStringAsFixed(2);
    final packages = data.setting.reffralPackages.toString().trim();
    final weight = data.setting.reffralWeight.toString().trim();

    return _ModernCard(
      tint: const Color(0xFFFEF7FF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle(
            icon: Icons.group_rounded,
            title: 'Refer & Earn',
            color: Color(0xFF5812A4),
          ),
          SizedBox(height: 2.h),
          Text(
            'Earn $amount USD on $packages packages shipped or reach ${weight}lb weight.',
            style: TextStyle(
              color: AppColors.ink,
              fontSize: 12.sp,
              height: 1.35,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 1.7.h),
          Center(
            child: Container(
              width: 18.w,
              height: 8.h,
              decoration: BoxDecoration(
                color: const Color(0xFFEDE3FF),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(
                Icons.card_giftcard_rounded,
                color: Color(0xFF7568F0),
                size: 42,
              ),
            ),
          ),
          SizedBox(height: 1.7.h),
          Row(
            children: [
              Expanded(
                child: _SoftActionButton(
                  text: 'Share Link',
                  icon: Icons.link_rounded,
                  color: const Color(0xFF176CFF),
                  onTap: onShare,
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: _SoftActionButton(
                  text: 'Show QR',
                  icon: Icons.qr_code_2_rounded,
                  color: const Color(0xFF8E37D7),
                  onTap: onQr,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PackageOverviewCard extends StatelessWidget {
  final DashboardData data;
  final VoidCallback onViewAll;

  const _PackageOverviewCard({
    required this.data,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return _ModernCard(
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.inventory_2_outlined, color: AppColors.ink),
              SizedBox(width: 3.w),
              Expanded(
                child: Text(
                  'Package Overview',
                  style: TextStyle(
                    color: AppColors.ink,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              TextButton(
                onPressed: onViewAll,
                child: const Text(
                  'View All',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: AppColors.cyan),
            ],
          ),
          const Divider(color: AppColors.border),
          _OverviewRow(
            icon: Icons.warehouse_outlined,
            iconColor: const Color(0xFF176CFF),
            title: 'Miami Warehouse',
            subtitle: '${_safeInt(data.wherehouse)} packages',
            chip: 'Warehouse',
            chipColor: const Color(0xFF176CFF),
          ),
          const Divider(color: AppColors.border),
          _OverviewRow(
            icon: Icons.local_shipping_outlined,
            iconColor: const Color(0xFF8E37D7),
            title: 'In Transit',
            subtitle: '${_safeInt(data.inTransit)} packages moving',
            chip: 'In Transit',
            chipColor: const Color(0xFF8E37D7),
          ),
          const Divider(color: AppColors.border),
          _OverviewRow(
            icon: Icons.check_circle_outline_rounded,
            iconColor: const Color(0xFF15BF4E),
            title: 'Ready for Pickup',
            subtitle: '${_safeInt(data.outstandingPackage)} packages ready',
            chip: 'Ready',
            chipColor: const Color(0xFF15BF4E),
          ),
        ],
      ),
    );
  }
}

class _QuickActionsCard extends StatelessWidget {
  final List<_QuickAction> actions;

  const _QuickActionsCard({required this.actions});

  @override
  Widget build(BuildContext context) {
    return _ModernCard(
      padding: EdgeInsets.fromLTRB(2.5.w, 2.h, 2.5.w, 1.4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            child: Text(
              'Quick Actions',
              style: TextStyle(
                color: AppColors.ink,
                fontSize: 13.sp,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          SizedBox(height: 1.4.h),
          Row(
            children: actions
                .map(
                  (action) => Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.8.w),
                      child: _QuickActionTile(action: action),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _ManagerCard extends StatelessWidget {
  final DashboardData data;

  const _ManagerCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return _ModernCard(
      child: Row(
        children: [
          Container(
            width: 12.w,
            height: 12.w,
            decoration: const BoxDecoration(
              color: AppColors.cyan.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.support_agent_rounded, color: AppColors.cyan),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Account Manager',
                  style: TextStyle(
                    color: AppColors.muted,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  data.accountManager,
                  style: TextStyle(
                    color: AppColors.ink,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                if (data.managerPhone.trim().isNotEmpty)
                  Text(
                    data.managerPhone,
                    style: const TextStyle(
                      color: AppColors.cyan,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InitialsAvatar extends StatelessWidget {
  final String name;

  const _InitialsAvatar({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14.w,
      height: 14.w,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.35), width: 2),
      ),
      child: Center(
        child: Text(
          _initials(name),
          style: TextStyle(
            color: Colors.white,
            fontSize: 17.sp,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

class _GlassButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  const _GlassButton({
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0.16),
      borderRadius: BorderRadius.circular(11),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(11),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.2.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 18),
              SizedBox(width: 2.w),
              Flexible(
                child: Text(
                  text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
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

class _ModernCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? tint;

  const _ModernCard({
    required this.child,
    this.padding,
    this.tint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: tint ?? Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.ink.withOpacity(0.06),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _StatTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;
  final VoidCallback onTap;

  const _StatTile({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.w),
          child: Column(
            children: [
              Container(
                width: 10.5.w,
                height: 10.5.w,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 26),
              ),
              SizedBox(height: 1.h),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.ink,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 0.3.h),
              Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.ink.withOpacity(0.72),
                  fontSize: 9.8.sp,
                  height: 1.1,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DividerLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 12.h,
      color: AppColors.border,
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const _SectionTitle({
    required this.icon,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 22),
        SizedBox(width: 2.5.w),
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: color,
              fontSize: 13.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}

class _AmountLine extends StatelessWidget {
  final String value;

  const _AmountLine({required this.value});

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: AppColors.ink,
        fontSize: 14.sp,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}

class _SoftActionButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _SoftActionButton({
    required this.text,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withOpacity(0.09),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 1.2.h),
          child: Column(
            children: [
              Icon(icon, color: color, size: 22),
              SizedBox(height: 0.4.h),
              Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: color,
                  fontSize: 9.5.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OverviewRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String chip;
  final Color chipColor;

  const _OverviewRow({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.chip,
    required this.chipColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.1.h),
      child: Row(
        children: [
          Container(
            width: 11.w,
            height: 11.w,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor),
          ),
          SizedBox(width: 3.5.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.ink,
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 0.4.h),
                Text(
                  subtitle,
                  style: _mutedSmall,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 2.4.w, vertical: 0.8.h),
            decoration: BoxDecoration(
              color: chipColor.withOpacity(0.09),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              chip,
              style: TextStyle(
                color: chipColor,
                fontSize: 10.sp,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          SizedBox(width: 1.w),
          const Icon(Icons.chevron_right_rounded, color: AppColors.ink),
        ],
      ),
    );
  }
}

class _QuickAction {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
}

class _QuickActionTile extends StatelessWidget {
  final _QuickAction action;

  const _QuickActionTile({required this.action});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: action.onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 10.5.h,
          padding: EdgeInsets.symmetric(horizontal: 1.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(action.icon, color: action.color, size: 28),
              SizedBox(height: 0.8.h),
              Text(
                action.label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.ink,
                  fontSize: 9.5.sp,
                  height: 1.05,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashboardLoading extends StatelessWidget {
  const _DashboardLoading();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(4.w, 0.4.h, 4.w, 2.5.h),
      child: Column(
        children: [
          ShimmerWidget(
            height: 31.h,
            width: 100.w,
            radius: BorderRadius.circular(24),
            child: const SizedBox.shrink(),
          ),
          SizedBox(height: 2.h),
          ShimmerWidget(
            height: 16.h,
            width: 100.w,
            radius: BorderRadius.circular(22),
            child: const SizedBox.shrink(),
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              Expanded(
                child: ShimmerWidget(
                  height: 30.h,
                  radius: BorderRadius.circular(22),
                  child: const SizedBox.shrink(),
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: ShimmerWidget(
                  height: 30.h,
                  radius: BorderRadius.circular(22),
                  child: const SizedBox.shrink(),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          ShimmerWidget(
            height: 26.h,
            width: 100.w,
            radius: BorderRadius.circular(22),
            child: const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class _DashboardError extends StatelessWidget {
  final String message;
  final Future<void> Function() onRetry;

  const _DashboardError({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(6.w),
      children: [
        SizedBox(height: 8.h),
        Icon(Icons.cloud_off_rounded, color: AppColors.coral, size: 60),
        SizedBox(height: 2.h),
        Text(
          'Dashboard unavailable',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.ink,
            fontSize: 18.sp,
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColors.muted),
        ),
        SizedBox(height: 3.h),
        ElevatedButton(
          onPressed: () => onRetry(),
          child: const Text('Try Again'),
        ),
      ],
    );
  }
}

String _accountNumber(User user, DashboardData data) {
  if (user.mailbox.trim().isNotEmpty) return user.mailbox.trim();
  if (user.outletId.trim().isNotEmpty && user.outletId != '-1') {
    return 'SX-${user.outletId.trim()}';
  }
  if (data.outletId.trim().isNotEmpty && data.outletId != '-1') {
    return 'SX-${data.outletId.trim()}';
  }
  return 'SendX';
}

String _initials(String name) {
  final parts = name
      .trim()
      .split(RegExp(r'\s+'))
      .where((part) => part.trim().isNotEmpty)
      .toList();
  if (parts.isEmpty) return 'SX';
  if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
  return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
}

String _money(String value) {
  final clean = value.trim();
  if (clean.isEmpty || clean == '-1') return '0.00 JMD';
  return clean.toUpperCase().contains('JMD') ? clean : '$clean JMD';
}

int _safeInt(num value) {
  if (value < 0) return 0;
  return value.toInt();
}

int _toInt(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value.toString()) ?? 0;
}

num _toNum(dynamic value) {
  if (value is num) return value;
  return num.tryParse(value.toString().replaceAll(',', '')) ?? 0;
}

final TextStyle _mutedSmall = TextStyle(
  color: AppColors.muted,
  fontSize: 10.8.sp,
  height: 1.2,
  fontWeight: FontWeight.w600,
);

final TextStyle _smallBold = TextStyle(
  color: AppColors.ink,
  fontSize: 10.5.sp,
  fontWeight: FontWeight.w900,
);
