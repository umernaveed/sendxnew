import 'package:get/get.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/domain/repositories/remote_repository.dart';
import 'package:sendx/presentation/purchase/controllers/purchase_controller.dart';

class PurchaseBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PurchaseController(remoteRepository: find<RemoteRepository>()));
  }
}
