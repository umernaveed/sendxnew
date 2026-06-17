import 'dart:math';

import 'package:get/get.dart';
import 'package:sendx/app/core/routes/app_pages.dart';

class BottomNavController extends GetxController {
  final bottomNavNestedID = Random().nextInt(999);

  var currentIndex = 0.obs;

  void onTabChange(int e) {
    if (currentIndex.value == e) return;
    currentIndex.value = e;
    switch (e) {
      case 0:
        Get.toNamed(AppPages.dashboard, id: bottomNavNestedID);
        break;
      case 1:
        Get.toNamed(AppPages.authorizeUser, id: bottomNavNestedID);
        break;
      case 2:
        Get.toNamed(AppPages.deliveryScreen, id: bottomNavNestedID);
        break;
      case 3:
        Get.toNamed(AppPages.newsScreen, id: bottomNavNestedID);
        break;
      case 4:
        Get.toNamed(AppPages.account, id: bottomNavNestedID);
        break;
    }
  }

  void onPageChanged(e) => currentIndex.value = e;
}
