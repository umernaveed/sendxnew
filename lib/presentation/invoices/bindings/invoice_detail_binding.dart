import 'package:get/get.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/domain/repositories/remote_repository.dart';
import 'package:sendx/presentation/invoices/controller/invoice_detail_controller.dart';

class InvoiceDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      InvoiceDetailController(remoteRepository: find<RemoteRepository>()),
    );
  }
}
