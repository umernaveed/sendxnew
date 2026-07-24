import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/app/core/routes/app_pages.dart';
import 'package:sendx/app/core/theme/app_colors.dart';
import 'package:sendx/app/extensions/string_ext.dart';
import 'package:sendx/app/services/push_notifications_service.dart';
import 'package:sendx/app/util/flush_snackbar.dart';
import 'package:sendx/data/models/dashboard_data/dashboard_data.dart';
import 'package:sendx/data/models/get_packages_ready_for_pickup_response/get_packages_ready_for_pickup_response.dart';
import 'package:sendx/domain/repositories/local_repository.dart';
import 'package:sendx/presentation/bottom_nav/controllers/bottom_nav_controller.dart';
import 'package:sendx/presentation/dashboard/controllers/dashboard_controller.dart';
import 'package:sendx/presentation/dashboard/controllers/dashboard_packages_controller.dart';
import 'package:sendx/presentation/widgets/shimmer_widget.dart';
import 'package:sizer/sizer.dart';

class Dashboard extends GetView<DashboardController> {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.refreshData,
      child: SafeArea(
        child: controller.obx(
          onLoading: const _DashboardLoading(),
          onEmpty: const _DashboardEmpty(),
          onError: (error) => const _DashboardEmpty(
            message: 'Something went wrong try again later',
          ),
          (state) {
            if (state == null) return const SizedBox.shrink();
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.fromLTRB(4.w, 0.2.h, 4.w, 1.2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _DashboardTopBar(),
                  SizedBox(height: 0.9.h),
                  _HeroAccountCard(data: state),
                  SizedBox(height: 1.3.h),
                  _StatsStrip(data: state),
                  SizedBox(height: 1.5.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _RewardsWalletCard(data: state)),
                      SizedBox(width: 3.w),
                      Expanded(child: _ReferEarnCard(data: state)),
                    ],
                  ),
                  SizedBox(height: 1.5.h),
                  const _RecentPackagesCard(),
                  SizedBox(height: 1.5.h),
                  const _QuickActionsCard(),
                  if (state.accountManager.isNotEmpty) ...[
                    SizedBox(height: 1.5.h),
                    _ManagerCard(
                      manager: state.accountManager,
                      managerPhone: state.managerPhone,
                    ),
                  ],
                  SizedBox(height: 1.5.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _DashboardTopBar extends StatelessWidget {
  const _DashboardTopBar();

  @override
  Widget build(BuildContext context) {
    final badger = find<FlutterAppNotificationBadger>();
    return Row(
      children: [
        IconButton(
          onPressed: () => _goToNested(AppPages.account),
          icon: const Icon(Icons.menu_rounded, color: Color(0xFF07132D)),
          iconSize: 28,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 38, minHeight: 38),
        ),
        const Spacer(),
        SvgPicture.asset(
          'assets/svgs/app_logo_sendx.svg',
          width: 21.w,
          fit: BoxFit.contain,
        ),
        const Spacer(),
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              onPressed: () {
                badger.clearBadge();
                _goToNested(AppPages.newsScreen);
              },
              icon: const Icon(
                Icons.notifications_none_rounded,
                color: Color(0xFF07132D),
              ),
              iconSize: 29,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 38, minHeight: 38),
            ),
            Positioned(
              right: -1,
              top: -2,
              child: Obx(
                () {
                  final count = badger.notificationCount.value;
                  if (count <= 0) return const SizedBox.shrink();
                  return Container(
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.coral,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      count > 99 ? '99+' : count.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ],
    );
  }
}

class _HeroAccountCard extends GetView<DashboardController> {
  const _HeroAccountCard({required this.data});

  final DashboardData data;

  @override
  Widget build(BuildContext context) {
    final user = find<LocalRepository>().getInstantUser();
    final name = user.firstName.trim().isNotEmpty ? user.firstName.trim() : 'User';
    final initials = _initials(user.firstName, user.lastName);
    final accountId = user.mailbox.isNotEmpty ? 'SX-${user.mailbox}' : data.referralCode;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(4.3.w, 2.15.h, 4.1.w, 2.15.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF176DF2),
            Color(0xFF8F45C8),
            Color(0xFFFF315B),
          ],
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: AppColors.cyan.withOpacity(0.18),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withOpacity(0.35), width: 2),
                ),
                child: Text(
                  initials,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(width: 3.5.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, $name',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        height: 1.05,
                      ),
                    ),
                    SizedBox(height: .55.h),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            'Account ID: $accountId',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.86),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(width: 1.5.w),
                        InkWell(
                          onTap: () async {
                            await Clipboard.setData(ClipboardData(text: accountId));
                            FlushSnackbar.showSnackBar('Account ID copied');
                          },
                          child: Icon(
                            Icons.copy_rounded,
                            color: Colors.white.withOpacity(0.85),
                            size: 17,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.more_vert_rounded,
                color: Colors.white.withOpacity(0.9),
                size: 27,
              ),
            ],
          ),
          SizedBox(height: 1.55.h),
          Divider(color: Colors.white.withOpacity(0.14), height: 1),
          SizedBox(height: 1.55.h),
          Row(
            children: [
              Expanded(
                child: _HeroMetric(
                  label: 'Outstanding Balance',
                  value: _balanceOnly(data.outstandingBalance),
                  suffix: 'JMD',
                  icon: Icons.visibility_outlined,
                  buttonLabel: 'View Invoices',
                  buttonIcon: Icons.description_outlined,
                  onTap: () => _goToNested(AppPages.unpaidInvoicesScreen),
                ),
              ),
              Container(
                width: 1,
                height: 9.8.h,
                margin: EdgeInsets.symmetric(horizontal: 2.5.w),
                color: Colors.white.withOpacity(0.22),
              ),
              Expanded(
                child: _HeroMetric(
                  label: 'Packages Ready',
                  value: data.outstandingPackage.toString(),
                  suffix: 'For Pickup',
                  icon: Icons.inventory_2_outlined,
                  buttonLabel: 'View Packages',
                  buttonIcon: Icons.chevron_right_rounded,
                  onTap: () => _goToNested(AppPages.trackPackages),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _HeroMetric extends StatelessWidget {
  const _HeroMetric({
    required this.label,
    required this.value,
    required this.suffix,
    required this.icon,
    required this.buttonLabel,
    required this.buttonIcon,
    required this.onTap,
  });

  final String label;
  final String value;
  final String suffix;
  final IconData icon;
  final String buttonLabel;
  final IconData buttonIcon;
  final VoidCallback onTap;

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
                  color: Colors.white.withOpacity(0.85),
                  fontSize: 11.2,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(width: 1.w),
            Icon(icon, color: Colors.white.withOpacity(0.75), size: 17),
          ],
        ),
        SizedBox(height: .6.h),
        RichText(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            children: [
              TextSpan(
                text: value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
              TextSpan(
                text: ' $suffix',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 1.35.h),
        InkWell(
          borderRadius: BorderRadius.circular(9),
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 2.3.w, vertical: 1.0.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(buttonIcon, color: Colors.white, size: 18),
                SizedBox(width: 1.2.w),
                Flexible(
                  child: Text(
                    buttonLabel,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _StatsStrip extends StatelessWidget {
  const _StatsStrip({required this.data});

  final DashboardData data;

  @override
  Widget build(BuildContext context) {
    return _SoftCard(
      padding: EdgeInsets.symmetric(vertical: 1.8.h, horizontal: 2.1.w),
      child: Row(
        children: [
          _StatItem(
            icon: Icons.warehouse_outlined,
            iconColor: const Color(0xFF157BE7),
            iconBg: const Color(0xFFEAF3FF),
            value: data.wherehouse.toString(),
            label: 'Miami Warehouse',
          ),
          _ThinDivider(),
          _StatItem(
            icon: Icons.local_shipping_rounded,
            iconColor: const Color(0xFF8D37DE),
            iconBg: const Color(0xFFF3E9FF),
            value: data.inTransit.toString(),
            label: 'In Transit',
          ),
          _ThinDivider(),
          _StatItem(
            icon: Icons.check_circle,
            iconColor: const Color(0xFF09B83E),
            iconBg: const Color(0xFFEAFCEB),
            value: data.outstandingPackage.toString(),
            label: 'Ready for Pickup',
          ),
          _ThinDivider(),
          _StatItem(
            icon: Icons.account_balance_wallet_rounded,
            iconColor: const Color(0xFFFF8A00),
            iconBg: const Color(0xFFFFF3E5),
            value: _balanceOnly(data.outstandingBalance),
            label: 'Outstanding Balance',
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(icon, color: iconColor, size: 28),
          ),
          SizedBox(height: 0.9.h),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF07132D),
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: .3.h),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF222538),
              fontSize: 10,
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _RewardsWalletCard extends StatelessWidget {
  const _RewardsWalletCard({required this.data});

  final DashboardData data;

  @override
  Widget build(BuildContext context) {
    final rate = num.tryParse(data.setting.usRate) ?? 0;
    final rewardJmd = data.memberPoints * rate;
    final targetPackages = int.tryParse(data.setting.rewardPackages) ?? 0;
    final progress = targetPackages == 0
        ? 0.0
        : (data.packageCount / targetPackages).clamp(0.0, 1.0).toDouble();
    final percent = (progress * 100).round();
    final remainingPackages =
        (targetPackages - data.packageCount).clamp(0, targetPackages).toInt();

    return _SoftCard(
      padding: EdgeInsets.all(2.8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(
            icon: Icons.card_giftcard_rounded,
            title: 'Rewards Wallet',
            color: const Color(0xFF078A39),
          ),
          SizedBox(height: 1.7.h),
          _AmountLine(amount: '${data.memberPoints.toStringAsFixed(2)} USD', label: 'Rewards Balance'),
          SizedBox(height: 1.1.h),
          _AmountLine(amount: '${rewardJmd.toStringAsFixed(2)} JMD', label: 'Rewards Balance'),
          SizedBox(height: 1.5.h),
          Divider(color: AppColors.border.withOpacity(.8)),
          SizedBox(height: .9.h),
          Row(
            children: [
              Text(
                '${data.packageCount} / $targetPackages packages',
                style: const TextStyle(
                  color: Color(0xFF222538),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                '$percent%',
                style: const TextStyle(
                  color: Color(0xFF222538),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: .65.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              minHeight: 7,
              value: progress,
              color: const Color(0xFF139EF2),
              backgroundColor: const Color(0xFFE6E8EC),
            ),
          ),
          SizedBox(height: .9.h),
          Text(
            'Ship $remainingPackages more packages to earn ${data.setting.rewardAmount} USD',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF555967),
              fontSize: 11,
              fontWeight: FontWeight.w500,
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReferEarnCard extends StatelessWidget {
  const _ReferEarnCard({required this.data});

  final DashboardData data;

  @override
  Widget build(BuildContext context) {
    return _SoftCard(
      padding: EdgeInsets.all(2.8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(
            icon: Icons.group_rounded,
            title: 'Refer & Earn',
            color: const Color(0xFF4E1499),
          ),
          SizedBox(height: 1.8.h),
          Text(
            'Earn ${data.setting.referralAmount.toStringAsFixed(2)} USD on ${data.setting.reffralPackages} packages shipped or reach ${data.setting.reffralWeight}lb weight.',
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF222538),
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 1.25,
            ),
          ),
          SizedBox(height: 1.7.h),
          Row(
            children: [
              Expanded(
                child: _MiniActionButton(
                  icon: Icons.link_rounded,
                  label: 'Share Link',
                  color: const Color(0xFF137EEA),
                  onTap: () async {
                    await Clipboard.setData(ClipboardData(text: data.referralCode));
                    FlushSnackbar.showSnackBar('Referral link copied');
                  },
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: _MiniActionButton(
                  icon: Icons.qr_code_2_rounded,
                  label: 'Show QR Code',
                  color: const Color(0xFF8D37DE),
                  onTap: () => _showQrDialog(data.referralCode),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RecentPackagesCard extends StatelessWidget {
  const _RecentPackagesCard();

  @override
  Widget build(BuildContext context) {
    final packagesController = Get.find<DashboardPackagesController>();
    return _SoftCard(
      padding: EdgeInsets.fromLTRB(3.5.w, 1.6.h, 3.5.w, 1.h),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.inventory_2_outlined, color: Color(0xFF07132D), size: 25),
              SizedBox(width: 2.5.w),
              const Text(
                'Recent Packages',
                style: TextStyle(
                  color: Color(0xFF07132D),
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => _goToNested(AppPages.trackPackages),
                child: const Text(
                  'View All',
                  style: TextStyle(
                    color: Color(0xFF146FE3),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: Color(0xFF146FE3)),
            ],
          ),
          FutureBuilder<List<Package>>(
            future: packagesController.listener(0),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
              padding: EdgeInsets.symmetric(vertical: 1.1.h),
                  child: const ShimmerWidget(
                    child: SizedBox(height: 95, width: double.infinity),
                  ),
                );
              }

              final packages = (snapshot.data ?? []).take(2).toList();
              if (packages.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 18),
                  child: Text(
                    'No recent packages found',
                    style: TextStyle(
                      color: AppColors.muted,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }

              return Column(
                children: [
                  for (int i = 0; i < packages.length; i++) ...[
                    if (i > 0) Divider(color: AppColors.border.withOpacity(.9)),
                    _RecentPackageRow(package: packages[i], tintIndex: i),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _RecentPackageRow extends StatelessWidget {
  const _RecentPackageRow({required this.package, required this.tintIndex});

  final Package package;
  final int tintIndex;

  @override
  Widget build(BuildContext context) {
    final ready = package.statusName.toLowerCase().contains('ready');
    final color = ready ? const Color(0xFF0FBF43) : const Color(0xFF7B2DE2);
    final bg = ready ? const Color(0xFFE9FBEF) : const Color(0xFFF4E9FF);

    return InkWell(
      onTap: package.isInvoice == 1
          ? () => _goToNested(AppPages.invoiceDetails, arguments: package.invoiceNo.toString())
          : null,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: .85.h),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(11),
              ),
              child: Icon(Icons.inventory_2_outlined, color: color, size: 26),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'HAWB: ${package.supplierTrackingNo.isNotEmpty ? package.supplierTrackingNo : package.trackingNo}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF07132D),
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: .4.h),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          package.courier.isNotEmpty ? package.courier : package.merchant,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFF666A76),
                            fontSize: 10.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(width: 2.5.w),
                      const Icon(Icons.calendar_today_outlined, size: 13, color: Color(0xFF666A76)),
                      SizedBox(width: 1.w),
                      Text(
                        package.createdAt.toDDMMYYYY,
                        style: const TextStyle(
                          color: Color(0xFF666A76),
                          fontSize: 10.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 2.2.w, vertical: .7.h),
              decoration: BoxDecoration(
                color: ready ? const Color(0xFFE9FBEF) : const Color(0xFFEFF4FF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                package.statusName.isNotEmpty ? package.statusName : 'In Transit',
                style: TextStyle(
                  color: ready ? const Color(0xFF0DAA3B) : const Color(0xFF146FE3),
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: Color(0xFF07132D)),
          ],
        ),
      ),
    );
  }
}

class _QuickActionsCard extends StatelessWidget {
  const _QuickActionsCard();

  @override
  Widget build(BuildContext context) {
    final actions = [
      _QuickAction('Add Package', Icons.add_a_photo_outlined, const Color(0xFF139EF2), AppPages.addPreAlertScreen),
      _QuickAction('My Invoices', Icons.description_rounded, const Color(0xFF8766E8), AppPages.invoices),
      _QuickAction('Support Ticket', Icons.headset_mic_rounded, const Color(0xFFFF8A00), AppPages.supportTickets),
      _QuickAction('Track Shipment', Icons.location_on_rounded, const Color(0xFF20A85B), AppPages.trackPackages),
    ];

    return _SoftCard(
      padding: EdgeInsets.fromLTRB(3.w, 2.h, 3.w, 1.3.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 4),
            child: Text(
              'Quick Actions',
              style: TextStyle(
                color: Color(0xFF07132D),
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(height: 1.4.h),
          Row(
            children: [
              for (int i = 0; i < actions.length; i++) ...[
                Expanded(child: _QuickActionTile(action: actions[i])),
                if (i != actions.length - 1) SizedBox(width: 2.w),
              ],
            ],
          )
        ],
      ),
    );
  }
}

class _QuickAction {
  const _QuickAction(this.label, this.icon, this.color, this.route);

  final String label;
  final IconData icon;
  final Color color;
  final String route;
}

class _QuickActionTile extends StatelessWidget {
  const _QuickActionTile({required this.action});

  final _QuickAction action;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(13),
      onTap: () => _goToNested(action.route),
      child: Container(
        height: 11.8.h,
        padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.3.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(action.icon, color: action.color, size: 28),
            SizedBox(height: 1.h),
            Text(
              action.label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF07132D),
                fontSize: 10.5,
                fontWeight: FontWeight.w600,
                height: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ManagerCard extends StatelessWidget {
  const _ManagerCard({required this.manager, required this.managerPhone});

  final String manager;
  final String managerPhone;

  @override
  Widget build(BuildContext context) {
    return _SoftCard(
      padding: EdgeInsets.all(4.w),
      child: Row(
        children: [
          const Icon(Icons.support_agent_rounded, color: AppColors.cyan),
          SizedBox(width: 3.w),
          Expanded(
            child: Text(
              managerPhone.isEmpty
                  ? 'Your Manager: $manager'
                  : 'Your Manager: $manager - $managerPhone',
              style: const TextStyle(
                color: Color(0xFF07132D),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SoftCard extends StatelessWidget {
  const _SoftCard({required this.child, required this.padding});

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.border.withOpacity(.85)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB7DDF5).withOpacity(.18),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _ThinDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 11.h,
      color: AppColors.border,
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.icon,
    required this.title,
    required this.color,
  });

  final IconData icon;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 24),
        SizedBox(width: 2.w),
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: color,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}

class _AmountLine extends StatelessWidget {
  const _AmountLine({required this.amount, required this.label});

  final String amount;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          amount,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color(0xFF07132D),
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color(0xFF666A76),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _MiniActionButton extends StatelessWidget {
  const _MiniActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        height: 8.5.h,
        decoration: BoxDecoration(
          color: color.withOpacity(.10),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 25),
            SizedBox(height: .8.h),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: color,
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
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
      padding: EdgeInsets.fromLTRB(3.8.w, 2.h, 3.8.w, 2.h),
      child: Column(
        children: [
          for (final height in [38.h, 16.h, 20.h, 18.h, 15.h])
            Padding(
              padding: EdgeInsets.only(bottom: 1.6.h),
              child: ShimmerWidget(
                radius: BorderRadius.circular(22),
                child: SizedBox(width: double.infinity, height: height),
              ),
            ),
        ],
      ),
    );
  }
}

class _DashboardEmpty extends StatelessWidget {
  const _DashboardEmpty({this.message = 'No data found'});

  final String message;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 34.h),
        Center(
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF07132D),
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }
}

String _initials(String firstName, String lastName) {
  final first = firstName.trim().isNotEmpty ? firstName.trim()[0] : '';
  final last = lastName.trim().isNotEmpty ? lastName.trim()[0] : '';
  final value = '$first$last'.toUpperCase();
  return value.isEmpty ? 'SX' : value;
}

String _balanceOnly(String balance) {
  return balance.replaceAll('JMD', '').trim();
}

void _goToNested(String route, {dynamic arguments}) {
  final bottomNavNestedID = find<BottomNavController>().bottomNavNestedID;
  Get.toNamed(route, id: bottomNavNestedID, arguments: arguments);
}

void _showQrDialog(String code) {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Referral QR Code',
              style: TextStyle(
                color: Color(0xFF07132D),
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 18),
            QrImageView(
              data: code,
              version: QrVersions.auto,
              size: 220,
            ),
          ],
        ),
      ),
    ),
  );
}
