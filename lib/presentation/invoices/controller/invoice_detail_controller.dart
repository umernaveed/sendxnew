import 'package:get/get.dart';
import 'package:sendx/app/core/routes/app_pages.dart';
import 'package:sendx/app/extensions/controller_ext.dart';
import 'package:sendx/app/util/flush_snackbar.dart';
import 'package:sendx/data/models/invoice_detail/invoice_detail.dart';
import 'package:sendx/data/models/requests/invoice_detail_request/invoice_detail_request.dart';
import 'package:sendx/data/models/single_lasco_pay_request/single_lasco_pay_request.dart';
import 'package:sendx/domain/repositories/remote_repository.dart';

class InvoiceDetailController extends GetxController
    with StateMixin<InvoiceDetailResponse> {
  final RemoteRepository _remoteRepository;

  InvoiceDetailController({required RemoteRepository remoteRepository})
      : _remoteRepository = remoteRepository;

  Future<void> getInviceDetails(String invoiceNo) async {
    try {
      change(InvoiceDetailResponse.empty(), status: RxStatus.loading());
      final response = await _remoteRepository.getInvoiceDetails(
        InvoiceDetailRequest(invoiceNo: invoiceNo),
      );
      change(response.data, status: RxStatus.success());
    } catch (e) {
      change(InvoiceDetailResponse.empty(),
          status: RxStatus.error(e.toString()));
    }
  }

  Future<void> startPayment() async {
    final result = await asyncTaskWithResult<String>(() async {
      final request = SingleLascoPayRequest(
        invoiceIds: state?.invoiceId.toString(),
        invoiceTotal: state?.grandTotal.replaceAll(',', ''),
      );
      final response = await _remoteRepository.lascoSinglePayInvoice(request);
      return response.data;
    });
    if (result?.isNotEmpty ?? false) {
      final response = await Get.toNamed(
        AppPages.paymentWebView,
        arguments: {
          'url': result,
        },
      );
      if (response == -1) {
        FlushSnackbar.showSnackBar('Payment has been canceled', isError: true);
      } else if (response == 1) {
        FlushSnackbar.showSnackBar('Payment has been done', isError: false);
      }
    }
  }
}
