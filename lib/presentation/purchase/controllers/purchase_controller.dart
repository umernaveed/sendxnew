import 'dart:math';

import 'package:get/get.dart';
import 'package:sendx/data/models/purchase/purchase.dart';
import 'package:sendx/data/models/requests/offset_request/offset_request.dart';
import 'package:sendx/domain/repositories/remote_repository.dart';
import 'package:sendx/presentation/mixin/pagination_service.dart';

class PurchaseController extends GetxController
    with PaginationService<Purchase> {
  final purchaseNestedID = Random().nextInt(999);

  final RemoteRepository _remoteRepository;

  PurchaseController({required RemoteRepository remoteRepository})
      : _remoteRepository = remoteRepository;

  @override
  void onInit() {
    initlizieController();
    super.onInit();
  }

  @override
  void onClose() {
    disposeController();
    super.onClose();
  }

  void refreshPurchases() => pagingController.refresh();

  @override
  Future<List<Purchase>> listener(int pageKey,
      {String keyToSearch = ''}) async {
    final res = await _remoteRepository.getAllPurchase(OffsetRequest(
      offset: pageKey.toString(),
      keyword: keyToSearch,
    ));
    return res.data.purchases;
  }
}
