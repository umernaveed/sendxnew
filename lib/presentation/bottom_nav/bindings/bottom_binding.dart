import 'package:get/get.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/domain/repositories/local_repository.dart';
import 'package:sendx/domain/repositories/remote_repository.dart';
import 'package:sendx/presentation/account/controllers/account_controller.dart';
import 'package:sendx/presentation/authorize/controllers/authorize_controller.dart';
import 'package:sendx/presentation/bottom_nav/controllers/bottom_nav_controller.dart';
import 'package:sendx/presentation/dashboard/controllers/dashboard_tabbar_controller.dart';
import 'package:sendx/presentation/delivery/controllers/delivery_controller.dart';
import 'package:sendx/presentation/purchase/controllers/purchase_controller.dart';

class BottomNavBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavController());
    Get.put(DashboardTabBarController());
    Get.put(
      AuthorizeController(remoteRepository: find<RemoteRepository>()),
    );
    Get.put(
      DeliveryController(remoteRepository: find<RemoteRepository>()),
    );
    Get.put(PurchaseController(remoteRepository: find<RemoteRepository>()));
    Get.put(
      AccountController(
          remoteRepository: find<RemoteRepository>(),
          localRepository: find<LocalRepository>()),
    );
  }
}
