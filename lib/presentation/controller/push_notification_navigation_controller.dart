import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/app/core/routes/app_pages.dart';
import 'package:sendx/presentation/bottom_nav/controllers/bottom_nav_controller.dart';

class PushNotificationNavigationController extends GetxController {
  @override
  void onReady() {
    Future.delayed(500.milliseconds, _getInitMessage);
    super.onReady();
  }

  Future<void> _getInitMessage() async {
    final message = await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      final data = message.data;
      redirectToScreen(data['type1']);
    }
  }

  void redirectToScreen(String type) {
    final bottomC = find<BottomNavController>();
    if (type == 'news') {
      bottomC.onTabChange(3);
    } else if (type == 'package') {
      Get.toNamed(AppPages.trackPackages, id: bottomC.bottomNavNestedID);
    } else if (type == 'invoice') {
      Get.toNamed(AppPages.invoices, id: bottomC.bottomNavNestedID);
    }
  }
}
