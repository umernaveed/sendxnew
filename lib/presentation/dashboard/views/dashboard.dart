import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sendx/app/util/flush_snackbar.dart';
import 'package:sendx/data/models/dashboard_data/dashboard_data.dart';
import 'package:sendx/presentation/dashboard/controllers/dashboard_controller.dart';
import 'package:sendx/presentation/widgets/lasco_button.dart';
import 'package:sendx/presentation/widgets/shimmer_widget.dart';
import 'package:sizer/sizer.dart';

class Dashboard extends GetView<DashboardController> {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.refreshData,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: controller.obx(
          onLoading: const _ShimmerWidget(),
          onEmpty: const Center(
            child: Text(
              'No data found',
              style: TextStyle(
                color: Color(0xFF181725),
                fontSize: 26,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          onError: (error) => SizedBox(
            height: context.height / 1.5,
            width: context.width,
            child: const Center(
              child: Text(
                'Something went wrong try again late',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF181725),
                  fontSize: 26,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          (state) {
            if (state == null) return const SizedBox.shrink();
            return Column(
              children: [
                SizedBox(height: 2.h),
                ManagerWidget(
                  manager: state.accountManager,
                  managerPhone: state.managerPhone,
                ),
                LascoButton(
                  onTap: () async {
                    await controller.startPayment(
                      packageIDs: state.packageIds,
                      invoiceIDs: state.invoiceIds,
                      balance: state.outstandingBalance,
                    );
                  },
                  margin: EdgeInsets.symmetric(
                    vertical: 1.h,
                    horizontal: 3.w,
                  ),
                ),
                SizedBox(height: 1.h),
                _QRWidget(state.referralCode),
                SizedBox(height: 1.8.h),
                _ReferralBonusWidget(state),
                SizedBox(height: 1.8.h),
                _RewardBalanceWidget(state),
                SizedBox(height: 1.8.h),
                _InfoBuilderWidget(data: state),
                SizedBox(height: 1.8.h),
                _DashboardCard(
                  title: state.wherehouse.toString(),
                  subTitle: 'TOTAL PACKAGES AT MIAMI WAREHOUSE',
                ),
                SizedBox(height: 1.8.h),
                _DashboardCard(
                  title: state.inTransit.toString(),
                  subTitle: 'TOTAL PACKAGES IN TRANSIT',
                ),
                SizedBox(height: 1.8.h),
                _DashboardCard(
                  title: state.outstandingPackage.toString(),
                  subTitle: 'TOTAL PACKAGE READY FOR PICK UP',
                ),
                SizedBox(height: 1.8.h),
                _DashboardCard(
                  title: state.outstandingBalance,
                  subTitle: 'TOTAL  OUTSTANDING BALANCE',
                ),
                SizedBox(height: 2.8.h),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ShimmerWidget extends StatelessWidget {
  const _ShimmerWidget();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 4,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 4.h),
      separatorBuilder: (context, index) => SizedBox(height: 1.8.h),
      itemBuilder: (context, index) {
        return const _DashboardShimmerCard();
      },
    );
  }
}

class _RewardBalanceWidget extends StatelessWidget {
  const _RewardBalanceWidget(this.data);
  final DashboardData data;

  @override
  Widget build(BuildContext context) {
    final points = data.memberPoints;
    final rate = data.setting.usRate;
    final validRate = num.tryParse(rate) ?? 0;
    final jmdPoints = points * validRate;
    return Container(
      width: context.width,
      padding: EdgeInsets.all(2.h),
      margin: EdgeInsets.only(left: 3.2.w, right: 3.2.w),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 4,
            offset: Offset(0, 3),
            spreadRadius: 1.8,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Rewarded Balance",
            style: TextStyle(
              color: const Color(0xFF181725),
              fontSize: 24.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 1.h),
          _BalanceWidget(
            title: "Rewards Balance of : ",
            balance: '$points USD',
          ),
          SizedBox(height: 0.5.h),
          _BalanceWidget(
            title: "Rewards Balance of : ",
            balance: '$jmdPoints JMD',
          ),
        ],
      ),
    );
  }
}

class _ReferralBonusWidget extends StatelessWidget {
  const _ReferralBonusWidget(this.data);
  final DashboardData data;

  @override
  Widget build(BuildContext context) {
    final balance = data.availableBalance;
    final rate = data.setting.usRate;
    final validRate = num.tryParse(rate) ?? 0;
    final jmdBalance = balance * validRate;
    return Container(
      width: context.width,
      padding: EdgeInsets.all(2.h),
      margin: EdgeInsets.only(left: 3.2.w, right: 3.2.w),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 4,
            offset: Offset(0, 3),
            spreadRadius: 1.8,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Referral Bonus",
            style: TextStyle(
              color: const Color(0xFF181725),
              fontSize: 24.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 1.h),
          _BalanceWidget(
            title: "Referral Balance: ",
            balance: '$balance USD',
          ),
          SizedBox(height: 0.5.h),
          _BalanceWidget(
            title: "Referral Balance: ",
            balance: '$jmdBalance JMD',
          ),
        ],
      ),
    );
  }
}

class _BalanceWidget extends StatelessWidget {
  const _BalanceWidget({required this.balance, required this.title});
  final String balance;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: const Color(0xFF181725),
            fontSize: 10.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          balance,
          style: TextStyle(
            color: const Color(0xFF181725),
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _DashboardCard extends StatelessWidget {
  const _DashboardCard({required this.title, required this.subTitle});
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: 14.h,
      margin: EdgeInsets.only(left: 3.2.w, right: 3.2.w),
      decoration: const BoxDecoration(
        color: Colors.white,
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
        padding: EdgeInsets.all(2.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: const Color(0xFF181725),
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              subTitle,
              style: TextStyle(
                color: const Color(0xFF181725),
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _DashboardShimmerCard extends StatelessWidget {
  const _DashboardShimmerCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: 14.h,
      margin: EdgeInsets.only(left: 3.2.w, right: 3.2.w),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 4,
            offset: Offset(0, 3),
            spreadRadius: 1.8,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(2.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShimmerWidget(
              radius: BorderRadius.circular(4),
              width: 15.w,
              child: SizedBox(
                width: context.width,
                height: 3.h,
              ),
            ),
            SizedBox(height: 1.h),
            ShimmerWidget(
              height: 3.h,
              width: context.width,
              radius: BorderRadius.circular(4),
              child: SizedBox(
                width: context.width,
                height: 2.6.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoBuilderWidget extends StatelessWidget {
  const _InfoBuilderWidget({required this.data});
  final DashboardData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      padding: EdgeInsets.all(2.h),
      margin: EdgeInsets.only(left: 3.2.w, right: 3.2.w),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 4,
            offset: Offset(0, 3),
            spreadRadius: 1.8,
          )
        ],
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "You can earn ",
              style: TextStyle(
                color: const Color(0xFF181725),
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: "${data.setting.rewardAmount}USD",
              style: TextStyle(
                color: const Color(0xFF181725),
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: " on ",
              style: TextStyle(
                color: const Color(0xFF181725),
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: data.setting.rewardPackages,
              style: TextStyle(
                color: const Color(0xFF181725),
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: " packages shipped or reach ",
              style: TextStyle(
                color: const Color(0xFF181725),
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: "${data.setting.rewardWeight}lb",
              style: TextStyle(
                color: const Color(0xFF181725),
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: " weight for shipped packages, currently you shipped ",
              style: TextStyle(
                color: const Color(0xFF181725),
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: "${data.packageCount}",
              style: TextStyle(
                color: const Color(0xFF181725),
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: " packages weight ",
              style: TextStyle(
                color: const Color(0xFF181725),
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: "${data.packageWeight}lbs",
              style: TextStyle(
                color: const Color(0xFF181725),
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QRWidget extends StatelessWidget {
  const _QRWidget(this.dataKey);
  final String dataKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _RefferalLink(dataKey),
        Container(
          alignment: Alignment.center,
          width: context.width,
          padding: EdgeInsets.all(2.h),
          margin: EdgeInsets.only(left: 3.2.w, right: 3.2.w),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0x19000000),
                blurRadius: 4,
                offset: Offset(0, 3),
                spreadRadius: 1.8,
              )
            ],
          ),
          child: QrImageView(
            data: dataKey,
            version: QrVersions.auto,
            size: 25.h,
          ),
        ),
      ],
    );
  }
}

class _RefferalLink extends StatelessWidget {
  const _RefferalLink(this.link);
  final String link;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      margin: EdgeInsets.only(left: 3.2.w, right: 3.2.w, bottom: 1.h),
      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 4,
            offset: Offset(0, 3),
            spreadRadius: 1.8,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Refferal Link',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            width: context.width,
            margin: EdgeInsets.only(top: 1.h),
            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.grey.withOpacity(0.15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    link,
                    style: TextStyle(color: Colors.black, fontSize: 11.sp),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: link)).then(
                      (e) {
                        FlushSnackbar.showSnackBar(
                            'Link Has been copied to clipboard');
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ManagerWidget extends StatelessWidget {
  const ManagerWidget({
    super.key,
    required this.manager,
    required this.managerPhone,
  });
  final String manager;
  final String managerPhone;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: manager.isNotEmpty,
      child: Container(
        width: context.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 4,
              offset: Offset(0, 3),
              spreadRadius: 1.8,
            )
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
        margin: EdgeInsets.symmetric(
          vertical: 2.h,
          horizontal: 3.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Manager:',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(manager),
            SizedBox(height: 1.h),
            Text(
              'Manager Phone:',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(managerPhone),
          ],
        ),
      ),
    );
  }
}
