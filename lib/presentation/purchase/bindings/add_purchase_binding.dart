import 'package:get/get.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/domain/repositories/remote_repository.dart';
import 'package:sendx/presentation/purchase/controllers/add_purchase_controller.dart';
import 'package:sendx/presentation/purchase/controllers/purchase_controller.dart';

class AddPurchaseBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      AddPurchaseController(
        remoteRepository: find<RemoteRepository>(),
        purchaseController: find<PurchaseController>(),
      ),
    );
  }
}
