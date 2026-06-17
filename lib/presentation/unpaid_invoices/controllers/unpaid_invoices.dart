import 'package:get/get.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/app/core/routes/app_pages.dart';
import 'package:sendx/app/extensions/controller_ext.dart';
import 'package:sendx/app/util/flush_snackbar.dart';
import 'package:sendx/data/models/lasco_mass_pay_invoice_request/lasco_mass_pay_invoice_request.dart';
import 'package:sendx/data/models/unpaid_invoice/unpaid_invoice.dart';
import 'package:sendx/domain/repositories/remote_repository.dart';
import 'package:sendx/presentation/bottom_nav/controllers/bottom_nav_controller.dart';
import 'package:sendx/presentation/mixin/pagination_service.dart';

class UnpaidInvoicesController extends GetxController
    with PaginationService<UnpaidInvoice> {
  final RemoteRepository _remoteRepository;

  UnpaidInvoicesController({required RemoteRepository remoteRepository})
      : _remoteRepository = remoteRepository;

  RxList<UnpaidInvoice> selectedItems = <UnpaidInvoice>[].obs;
  final totalAmount = 0.0.obs;

  @override
  void onInit() {
    initlizieController();
    super.onInit();
  }

  @override
  void onClose() {
    disposeController();
    onClear();
    super.onClose();
  }

  void onItemChecked(UnpaidInvoice item) {
    final valid = item.totalInvoice?.replaceAll(',', '');
    final amount = num.tryParse(valid ?? '0') ?? 0;
    if (selectedItems.contains(item)) {
      selectedItems.remove(item);
      if (totalAmount.value > 0) totalAmount.value = totalAmount.value - amount;
    } else {
      selectedItems.add(item);
      totalAmount.value = totalAmount.value + amount;
    }
  }

  void onClear() {
    selectedItems.clear();
    totalAmount.value = 0.00;
    final items = pagingController.itemList ?? [];
    for (var item in items) {
      item.isToggleOn = false;
    }
    pagingController.itemList = items;
    update(['unpaidInvoices']);
  }

  void onRefresh() {
    onClear();
    return pagingController.refresh();
  }

  @override
  Future<List<UnpaidInvoice>> listener(int pageKey,
      {String keyToSearch = ''}) async {
    final result = await _remoteRepository.getAllUnpaidInvoices();
    return result.data.unPaidInvoices;
  }

  Future<void> performPayment() async {
    final result = await asyncTaskWithResult<String>(() async {
      String ids = selectedItems.map((e) => e.invoiceId).join(',');
      String packageIDs = selectedItems.map((e) => e.trackingNo).join(',');
      final request = LascoMassPayInvoiceRequest(
        invoiceIds: ids,
        packageIds: packageIDs,
        invoiceTotal: '${totalAmount.value}',
      );
      final result = await _remoteRepository.lascoMassPayInvoice(request);
      return result.data;
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
        onRefresh();
        final controller = find<BottomNavController>();
        controller.onTabChange(2);
      }
    }
  }
}
