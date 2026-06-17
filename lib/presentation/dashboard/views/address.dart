import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sendx/app/util/flush_snackbar.dart';
import 'package:sendx/presentation/account/views/account_screen.dart';
import 'package:sendx/presentation/dashboard/controllers/dashboard_address_controller.dart';
import 'package:sendx/presentation/widgets/shimmer_widget.dart';
import 'package:sizer/sizer.dart';

class Address extends GetView<DashboardAddressController> {
  const Address({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.refreshData,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: controller.obx(
          onLoading: const _Shimmerloading(),
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
            return Padding(
              padding: EdgeInsets.only(top: 4.h, bottom: 1.h),
              child: Column(
                children: [
                  AddressItemWidget(
                    mainAddress: 'Your Air Shipping Address',
                    name: state.userInfo.userName,
                    address1: state.setting.packageShippingAddress1,
                    address2: state.userInfo.addressLine2,
                    city: state.setting.city,
                    country: state.setting.country,
                    zipCode: state.setting.zip,
                    state: state.setting.state,
                  ),
                  SizedBox(height: 2.h),
                  AddressItemWidget(
                    mainAddress: 'Your Sea Shipping Address',
                    name: state.userInfo.userName,
                    address1: state.setting.seaShippingAddress1,
                    address2: state.setting.seaShippingAddress2,
                    city: state.setting.seaCity,
                    country: state.setting.seaCountry,
                    zipCode: state.setting.seaZip,
                    state: state.setting.seaState,
                  ),
                  SizedBox(height: 2.h),
                  AddressItemWidget(
                    mainAddress: 'Your Air Express Shipping Address',
                    name: state.userInfo.userName,
                    address1: state.setting.expressShippingAddress1,
                    address2: state.setting.expressShippingAddress2,
                    city: state.setting.expressCity,
                    country: state.setting.expressCountry,
                    zipCode: state.setting.expressZip,
                    state: state.setting.expressState,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Shimmerloading extends StatelessWidget {
  const _Shimmerloading();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4.h, bottom: 2.h),
      child: Column(
        children: [
          const ShimmerAddressItemWidget(),
          SizedBox(height: 5.h),
          const ShimmerAddressItemWidget(),
        ],
      ),
    );
  }
}

class AddressItemWidget extends StatelessWidget {
  final String mainAddress;
  final String name;
  final String address1;
  final String address2;
  final String city;
  final String country;
  final String zipCode;
  final String state;
  const AddressItemWidget({
    super.key,
    required this.mainAddress,
    required this.name,
    required this.address1,
    required this.address2,
    required this.city,
    required this.country,
    required this.zipCode,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.symmetric(horizontal: 3.4.w, vertical: 2.h),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 4,
            offset: Offset(0, 3),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 0.45.h),
          Text(
            mainAddress,
            style: TextStyle(
              color: const Color(0xFF4791CE),
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          _AddressItemKeyValueBuilder(
            title: 'NAME:',
            subTitle: name,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
          ),
          SizedBox(height: 0.5.h),
          _AddressItemKeyValueBuilder(
            title: 'ADDRESS LINE 1:',
            subTitle: address1,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
          ),
          SizedBox(height: 0.5.h),
          _AddressItemKeyValueBuilder(
            title: 'ADDRESS LINE 2:',
            subTitle: address2,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
          ),
          SizedBox(height: 0.5.h),
          _AddressItemKeyValueBuilder(
            title: 'CITY:',
            subTitle: city,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
          ),
          SizedBox(height: 0.5.h),
          Visibility(
            visible: state.isNotEmpty,
            child: _AddressItemKeyValueBuilder(
              title: 'STATE:',
              subTitle: state,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
            ),
          ),
          Visibility(
            visible: state.isNotEmpty,
            child: SizedBox(height: 0.5.h),
          ),
          _AddressItemKeyValueBuilder(
            title: 'COUNTRY:',
            subTitle: country,
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          SizedBox(height: 0.5.h),
          _AddressItemKeyValueBuilder(
            title: 'ZIP:',
            subTitle: zipCode,
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          SizedBox(height: 1.h),
          // const AppDivider(),
          // SizedBox(height: 1.5.h),
          // Align(
          //   alignment: Alignment.topLeft,
          //   child: Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
          //     child: Text(
          //       '*please to ensure your mailbox number is added to address when shipping either beside last or in line 2 of address to prevent delays.',
          //       textAlign: TextAlign.left,
          //       style: TextStyle(
          //         color: const Color(0xFF7C7C7C),
          //         fontSize: 11.sp,
          //         fontWeight: FontWeight.w500,
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}

class _AddressItemKeyValueBuilder extends GetView<DashboardAddressController> {
  final String title;
  final String subTitle;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final double spaceBTW;
  final MainAxisSize mainAxisSize;
  const _AddressItemKeyValueBuilder({
    required this.title,
    required this.subTitle,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.spaceBTW = 0,
    this.mainAxisSize = MainAxisSize.min,
  });

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      onLoading: const _AddressItemKeyValueBuilderShimmer(),
      (state) {
        return Container(
          width: context.width,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: crossAxisAlignment,
                mainAxisAlignment: mainAxisAlignment,
                mainAxisSize: mainAxisSize,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10.5.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: spaceBTW),
                  Text(
                    subTitle,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                      color: const Color(0xFF7C7C7C),
                      fontSize: 10.5.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              _CopyButton(
                () async {
                  final t = ClipboardData(text: subTitle);
                  await Clipboard.setData(t).then((e) {
                    FlushSnackbar.showSnackBar('Copied to Clipboard');
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CopyButton extends StatelessWidget {
  const _CopyButton(this.onTap);
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4.h,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.14),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: onTap,
        icon: Icon(
          Icons.copy,
          size: 1.8.h,
        ),
      ),
    );
  }
}

class _AddressItemKeyValueBuilderShimmer extends StatelessWidget {
  const _AddressItemKeyValueBuilderShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ShimmerWidget(
          radius: BorderRadius.circular(2),
          width: 16.w,
          height: 3.h,
          child: SizedBox(
            width: 6.w,
            height: 3.h,
          ),
        ),
        SizedBox(width: 5.w),
        ShimmerWidget(
          radius: BorderRadius.circular(2),
          width: context.width / 1.7,
          height: 3.h,
          child: SizedBox(
            width: context.width / 1.7,
            height: 3.h,
          ),
        ),
      ],
    );
  }
}

class ShimmerAddressItemWidget extends StatelessWidget {
  const ShimmerAddressItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.symmetric(horizontal: 3.4.w, vertical: 2.h),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 4,
            offset: Offset(0, 3),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 0.45.h),
          ShimmerWidget(
            height: 5.h,
            radius: BorderRadius.circular(4),
            width: context.width,
            child: SizedBox(height: 1.5.h),
          ),
          SizedBox(height: 2.h),
          const _AddressItemKeyValueBuilder(
            title: '_:',
            subTitle: '_',
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
          ),
          SizedBox(height: 0.5.h),
          const _AddressItemKeyValueBuilder(
            title: '_',
            subTitle: '_',
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
          ),
          SizedBox(height: 0.5.h),
          const _AddressItemKeyValueBuilder(
            title: '_',
            subTitle: '_',
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
          ),
          SizedBox(height: 0.5.h),
          const _AddressItemKeyValueBuilder(
            title: '_:',
            subTitle: '_',
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
          ),
          SizedBox(height: 0.5.h),
          const _AddressItemKeyValueBuilder(
            title: '_:',
            subTitle: ' _',
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          SizedBox(height: 0.5.h),
          const _AddressItemKeyValueBuilder(
            title: '_:',
            subTitle: '',
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          SizedBox(height: 3.h),
          const AppDivider(),
          SizedBox(height: 1.5.h),
          const ParagraphShimmer(),
        ],
      ),
    );
  }
}

class ParagraphShimmer extends StatelessWidget {
  const ParagraphShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(3, (index) {
        return Padding(
          padding: EdgeInsets.only(top: 0.5.h),
          child: ShimmerWidget(
            radius: BorderRadius.circular(3),
            height: 3.h,
            width: context.width,
            child: const SizedBox.shrink(),
          ),
        );
      }),
    );
  }
}
