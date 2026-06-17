import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sendx/app/extensions/string_ext.dart';
import 'package:sendx/data/models/invoice_detail/invoice_detail.dart';
import 'package:sendx/presentation/auth/widgets/auth_app_bar.dart';
import 'package:sendx/presentation/base_screen.dart';
import 'package:sendx/presentation/invoices/controller/invoice_detail_controller.dart';
import 'package:sendx/presentation/widgets/lasco_button.dart';
import 'package:sendx/presentation/widgets/shimmer_widget.dart';
import 'package:sizer/sizer.dart';

class InvoiceDetails extends GetView<InvoiceDetailController> {
  const InvoiceDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    if (args != null) {
      final invoiceNo = Get.arguments as String;
      controller.getInviceDetails(invoiceNo.toString());
    }

    return BaseScreen(
      wrapWithAnnotatedRegion: true,
      backgroundColor: const Color(0xFFFAF4F2).withOpacity(0.4),
      value: SystemUiOverlayStyle.dark,
      appBar: const AuthCustomAppBar.withSmallAppLogo(
        backButtonVisible: true,
        usingNavigator: true,
      ),
      body: SingleChildScrollView(
        child: controller.obx(
          onLoading: const _ShimmerWidget(),
          onError: (error) => SizedBox(
            height: context.height / 1.5,
            width: context.width,
            child: const Center(
              child: Text(
                'Something went wrong try again late',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF181725),
                  fontSize: 16,
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
                Container(
                  alignment: Alignment.topLeft,
                  width: context.width,
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  padding:
                      EdgeInsets.symmetric(horizontal: 3.4.w, vertical: 2.h),
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
                    children: [
                      Text(
                        state.companyName,
                        style: TextStyle(
                          color: const Color(0xFF4791CE),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        state.localAddress,
                        style: TextStyle(
                          color: const Color(0xFF7C7C7C),
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Phone: ${state.phone}',
                        style: TextStyle(
                          color: const Color(0xFF7C7C7C),
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Invoice To:',
                        style: TextStyle(
                          color: const Color(0xFF4791CE),
                          fontSize: 16.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        state.userName,
                        style: TextStyle(
                          color: const Color(0xFF7C7C7C),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        state.address1,
                        style: TextStyle(
                          color: const Color(0xFF7C7C7C),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Account no : ${state.mailboxNo}',
                        style: TextStyle(
                          color: const Color(0xFF7C7C7C),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Email : ${state.email}',
                        style: TextStyle(
                          color: const Color(0xFF7C7C7C),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Invoice  No:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            '#${state.invoiceNo}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Date:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            state.datePaid.toString().toDDMMYYYY,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 2.h),
                      _StorageFeeNotice(data: state),
                      SizedBox(height: 1.h),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: state.invoiceDetail.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final item = state.invoiceDetail[index];
                          return InvoiceItem(
                            detail: item,
                            completeResponse: state,
                          );
                        },
                      ),
                      SizedBox(height: 1.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _SerialRowWidget(
                            title: 'GCT',
                            subTitle: state.gstTotal,
                          ),
                          const SizedBox.shrink()
                        ],
                      ),
                      SizedBox(height: 1.h),
                      _AdditionalFee(data: state),
                      _StorageFeeRow(data: state),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox.shrink(),
                          _SerialRowWidget(
                            title: 'Sub - Total amount',
                            subTitle: '${state.subTotal} JMD',
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox.shrink(),
                          _SerialRowWidget(
                            title: 'Discount',
                            subTitle: '${state.discountPrice} JMD',
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox.shrink(),
                          _SerialRowWidget(
                            title: 'Total',
                            subTitle: '${state.grandTotal} JMD',
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Phone: ${state.phone}\n${state.siteEmail}',
                            style: const TextStyle(
                              color: Color(0xFF7C7C7C),
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      LascoButton(
                        onTap: () async {
                          await controller.startPayment();
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5.h),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _StorageFeeNotice extends StatelessWidget {
  const _StorageFeeNotice({required this.data});

  final InvoiceDetailResponse data;

  double _amount(String value) {
    return double.tryParse(value.replaceAll(',', '')) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final payable = _amount(data.storageFeePayable);
    final waived = _amount(data.storageFeeWaivedAmount);
    if (payable <= 0 && (data.storageFeeWaived != 1 || waived <= 0)) {
      return const SizedBox.shrink();
    }

    final isDue = payable > 0 && data.status == 0;
    return Container(
      width: context.width,
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: isDue ? const Color(0xFFFFF4D8) : const Color(0xFFEAF7EA),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isDue ? const Color(0xFFE0A800) : const Color(0xFF2E7D32),
        ),
      ),
      child: Text(
        isDue
            ? 'Storage fee due: J\$${data.storageFeePayable}\n${data.storageFeeDaysApplied} days @ J\$${data.storageFeeDailyRate}/day after ${data.storageFeeGraceDays} grace days.'
            : 'Storage fee waived: J\$${data.storageFeeWaivedAmount}\n${data.storageFeeWaivedReason}',
        style: TextStyle(
          color: isDue ? const Color(0xFF7A5200) : const Color(0xFF2E7D32),
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _StorageFeeRow extends StatelessWidget {
  const _StorageFeeRow({required this.data});

  final InvoiceDetailResponse data;

  double _amount(String value) {
    return double.tryParse(value.replaceAll(',', '')) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    if (_amount(data.storageFeeTotal) <= 0) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox.shrink(),
          _SerialRowWidget(
            title: 'Storage Fee',
            subTitle: '${data.storageFeePayable} JMD',
          ),
        ],
      ),
    );
  }
}

class _AdditionalFee extends StatelessWidget {
  const _AdditionalFee({super.key, this.data});
  final InvoiceDetailResponse? data;

  @override
  Widget build(BuildContext context) {
    final fee = data?.additionalFee ?? [];
    return Visibility(
      visible: fee.isNotEmpty,
      child: SizedBox(
        width: context.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Additional fee',
              style: TextStyle(
                color: const Color(0xFF4791CE),
                fontSize: 16.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
            SizedBox(height: 1.h),
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: fee.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = fee[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 1.h),
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.name,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.sp,
                        ),
                      ),
                      Text(
                        item.serviceFee,
                        style: TextStyle(
                          color: const Color(0xFF7C7C7C),
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 1.h),
          ],
        ),
      ),
    );
  }
}

class InvoiceItem extends StatelessWidget {
  final InvoiceDetail detail;
  final InvoiceDetailResponse completeResponse;
  const InvoiceItem({
    super.key,
    required this.detail,
    required this.completeResponse,
  });

  @override
  Widget build(BuildContext context) {
    final freight = completeResponse.freightType.toLowerCase() == 'sendx'
        ? 'Regular Air Freight'
        : 'Express Air Freight';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'SR.#: ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: '1',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 0.7.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _SerialRowWidget(
              title: 'HAWB',
              subTitle: detail.manifestNo,
            ),
            _SerialRowWidget(
              title: freight,
              subTitle: '${detail.packagePrice} JMD',
            ),
          ],
        ),
        SizedBox(height: 1.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _SerialRowWidget(
              title: 'Custom Fee',
              subTitle: '${detail.customFee} JMD',
            ),
            _SerialRowWidget(
              title: 'Service Fee',
              subTitle: '${detail.serviceFee} JMD',
            ),
          ],
        ),
        SizedBox(height: 1.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _SerialRowWidget(
              title: 'Description',
              subTitle: detail.packageDescription,
            ),
          ],
        ),
        SizedBox(height: 1.h),
        _SerialRowWidget(
          title: 'Amount',
          subTitle: '${detail.packageTotal} JMD',
        ),
      ],
    );
  }
}

class _SerialRowWidget extends StatelessWidget {
  const _SerialRowWidget({
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '$title :',
          textAlign: TextAlign.start,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          subTitle,
          textAlign: TextAlign.start,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }
}

class _ShimmerWidget extends StatelessWidget {
  const _ShimmerWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 2.h),
        Container(
          alignment: Alignment.topLeft,
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
            children: [
              ShimmerWidget(
                height: 4.h,
                radius: BorderRadius.circular(3),
                width: context.width,
                child: const SizedBox.shrink(),
              ),
              SizedBox(height: 0.5.h),
              ShimmerWidget(
                height: 3.h,
                radius: BorderRadius.circular(3),
                width: context.width,
                child: const SizedBox.shrink(),
              ),
              SizedBox(height: 0.5.h),
              ShimmerWidget(
                height: 3.h,
                radius: BorderRadius.circular(3),
                width: context.width / 2,
                child: const SizedBox.shrink(),
              ),
              SizedBox(height: 1.h),
              ShimmerWidget(
                height: 3.h,
                radius: BorderRadius.circular(3),
                width: context.width / 2,
                child: const SizedBox.shrink(),
              ),
              SizedBox(height: 0.5.h),
              ShimmerWidget(
                height: 3.h,
                radius: BorderRadius.circular(3),
                width: context.width / 2,
                child: const SizedBox.shrink(),
              ),
              SizedBox(height: 0.5.h),
              ShimmerWidget(
                height: 3.h,
                radius: BorderRadius.circular(3),
                width: context.width / 2,
                child: const SizedBox.shrink(),
              ),
              SizedBox(height: 0.5.h),
              ShimmerWidget(
                height: 3.h,
                radius: BorderRadius.circular(3),
                width: context.width / 2,
                child: const SizedBox.shrink(),
              ),
              SizedBox(height: 0.5.h),
              ShimmerWidget(
                height: 3.h,
                radius: BorderRadius.circular(3),
                width: context.width / 2,
                child: const SizedBox.shrink(),
              ),
              SizedBox(height: 1.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ShimmerWidget(
                    height: 2.h,
                    radius: BorderRadius.circular(3),
                    width: context.width / 3,
                    child: const SizedBox.shrink(),
                  ),
                  SizedBox(width: 2.w),
                  ShimmerWidget(
                    height: 2.h,
                    radius: BorderRadius.circular(3),
                    width: context.width / 3,
                    child: const SizedBox.shrink(),
                  ),
                ],
              ),
              SizedBox(height: 0.6.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ShimmerWidget(
                    height: 2.h,
                    radius: BorderRadius.circular(3),
                    width: context.width / 3,
                    child: const SizedBox.shrink(),
                  ),
                  SizedBox(width: 2.w),
                  ShimmerWidget(
                    height: 2.h,
                    radius: BorderRadius.circular(3),
                    width: context.width / 3,
                    child: const SizedBox.shrink(),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              ShimmerWidget(
                height: 3.h,
                radius: BorderRadius.circular(3),
                width: context.width / 3,
                child: const SizedBox.shrink(),
              ),
              SizedBox(height: 0.7.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerWidget(
                    height: 2.h,
                    radius: BorderRadius.circular(3),
                    width: context.width / 3,
                    child: const SizedBox.shrink(),
                  ),
                  ShimmerWidget(
                    height: 2.h,
                    radius: BorderRadius.circular(3),
                    width: context.width / 3,
                    child: const SizedBox.shrink(),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerWidget(
                    height: 2.h,
                    radius: BorderRadius.circular(3),
                    width: context.width / 3,
                    child: const SizedBox.shrink(),
                  ),
                  ShimmerWidget(
                    height: 2.h,
                    radius: BorderRadius.circular(3),
                    width: context.width / 3,
                    child: const SizedBox.shrink(),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerWidget(
                    height: 2.h,
                    radius: BorderRadius.circular(3),
                    width: context.width / 1.5,
                    child: const SizedBox.shrink(),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              ShimmerWidget(
                height: 2.h,
                radius: BorderRadius.circular(3),
                width: context.width / 3,
                child: const SizedBox.shrink(),
              ),
              SizedBox(height: 1.h),
              ShimmerWidget(
                height: 2.h,
                radius: BorderRadius.circular(3),
                width: context.width / 3,
                child: const SizedBox.shrink(),
              ),
              SizedBox(height: 1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerWidget(
                    height: 2.h,
                    radius: BorderRadius.circular(3),
                    width: context.width / 3,
                    child: const SizedBox.shrink(),
                  ),
                  ShimmerWidget(
                    height: 2.h,
                    radius: BorderRadius.circular(3),
                    width: context.width / 3,
                    child: const SizedBox.shrink(),
                  ),
                ],
              ),
              SizedBox(height: 0.5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox.shrink(),
                  ShimmerWidget(
                    height: 2.h,
                    radius: BorderRadius.circular(3),
                    width: context.width / 3,
                    child: const SizedBox.shrink(),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox.shrink(),
                  ShimmerWidget(
                    height: 2.h,
                    radius: BorderRadius.circular(3),
                    width: context.width / 3,
                    child: const SizedBox.shrink(),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ShimmerWidget(
                    height: 4.h,
                    radius: BorderRadius.circular(3),
                    width: context.width / 3,
                    child: const SizedBox.shrink(),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
