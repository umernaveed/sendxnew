import 'package:get/get.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/domain/repositories/remote_repository.dart';
import 'package:sendx/presentation/account/controllers/get_delivery_packages_controller.dart';

class AllDeliveryPackagesBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      AllDeliveryPackagesController(remoteRepository: find<RemoteRepository>()),
    );
  }
}
