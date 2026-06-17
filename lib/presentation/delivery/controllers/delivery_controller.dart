import 'package:get/get.dart';
import 'package:sendx/data/models/get_all_package/get_all_package.dart';
import 'package:sendx/domain/repositories/remote_repository.dart';
import 'package:sendx/presentation/mixin/pagination_service.dart';

class DeliveryController extends GetxController
    with PaginationService<GetAllPackage> {
  final RemoteRepository _remoteRepository;

  DeliveryController({required RemoteRepository remoteRepository})
      : _remoteRepository = remoteRepository;

  RxList<GetAllPackage> selectedItems = <GetAllPackage>[].obs;
  final totalAmount = 0.0.obs;

  String get packageIds {
    return selectedItems.map((e) => e.trackingNo).toList().join(',');
  }

  String get invoiceIds {
    return selectedItems.map((item) => item.invoice).join(',');
  }

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

  void onItemChecked(GetAllPackage item) {
    final amount = num.tryParse(item.packageInvoice ?? '0') ?? 0;
    if (selectedItems.contains(item)) {
      selectedItems.remove(item);
      totalAmount.value = totalAmount.value - amount;
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
    update(['delivery']);
  }

  void onRefresh() {
    onClear();
    return pagingController.refresh();
  }

  @override
  Future<List<GetAllPackage>> listener(int pageKey,
      {String keyToSearch = ''}) async {
    final result = await _remoteRepository.getAllDeliveryPackage();
    return result.data.packages;
  }
}
