import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardTabBarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  RxInt index = 0.obs;

  bool get isDashboardSelected => index.value == 0;
  bool get isPackagesSelected => index.value == 1;
  bool get isAddressSelected => index.value == 2;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(onTabChange);
  }

  void onTabChange() {
    final e = tabController.index;
    if (index.value == e) return;
    index.value = e;
  }

  @override
  void onClose() {
    tabController.removeListener(onTabChange);
    tabController.dispose();
    super.onClose();
  }
}
