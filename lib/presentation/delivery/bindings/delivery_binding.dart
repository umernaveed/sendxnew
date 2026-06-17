import 'package:get/get.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/domain/repositories/remote_repository.dart';
import 'package:sendx/presentation/delivery/controllers/delivery_controller.dart';

class DeliveryBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      DeliveryController(
        remoteRepository: find<RemoteRepository>(),
      ),
    );
  }
}
