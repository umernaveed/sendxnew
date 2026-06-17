import 'package:get/get.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/domain/repositories/local_repository.dart';
import 'package:sendx/domain/repositories/remote_repository.dart';
import 'package:sendx/presentation/delivery/controllers/manage_pickup_request_controller.dart';

class ManagePickUpRequestBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      ManagePickUpRequestController(
        remoteRepository: find<RemoteRepository>(),
        localRepository: find<LocalRepository>(),
      ),
    );
  }
}
