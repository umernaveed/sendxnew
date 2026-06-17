import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/presentation/auth/views/login_screen.dart';
import 'package:sendx/presentation/delivery/controllers/delivery_controller.dart';
import 'package:sendx/presentation/delivery/controllers/manage_pickup_request_controller.dart';
import 'package:sendx/presentation/widgets/lasco_button.dart';

class DeliveryRequestConfirmation extends StatelessWidget {
  const DeliveryRequestConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = find<ManagePickUpRequestController>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Text(
                  'Confirmation',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 50),
                Text(
                  'For pre pick up delivery request you have to pay through our LASCO PAY.Please click on pay now button below to continue your pre pickup delivery request',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 100),
                Spacer(),
                LascoButton(
                  onTap: () async {
                    Get.back();
                    final deliveryController = find<DeliveryController>();
                    controller.startPayment(
                      packageIDs: deliveryController.packageIds,
                      invoiceIDs: deliveryController.invoiceIds,
                      balance: deliveryController.totalAmount.value.toString(),
                    );
                  },
                ),
                SizedBox(height: 20),
                AppButton(
                  title: 'Cancel',
                  buttonBorderRadius: 10,
                  backgroundColor: Colors.transparent,
                  textColor: Colors.black,
                  side: const BorderSide(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  onTap: () => Get.back(),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.withValues(alpha: 0.2),
              ),
              child: Icon(
                Icons.close,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
