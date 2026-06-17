import 'package:get/get.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/domain/repositories/remote_repository.dart';
import 'package:sendx/presentation/unpaid_invoices/controllers/unpaid_invoices.dart';

class UnpaidInvoicesBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      UnpaidInvoicesController(
        remoteRepository: find<RemoteRepository>(),
      ),
    );
  }
}
