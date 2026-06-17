import 'package:get/get.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/domain/repositories/remote_repository.dart';
import 'package:sendx/presentation/invoices/controller/invoices_controller.dart';

class InvoicesBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      InvoicesController(remoteRepository: find<RemoteRepository>()),
    );
  }
}
