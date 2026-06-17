import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sendx/app/extensions/controller_ext.dart';
import 'package:sendx/data/models/requests/add_purchas_request/add_purchas_request.dart';
import 'package:sendx/data/models/requests/update_purchase_request/update_purchase_request.dart';
import 'package:sendx/domain/repositories/remote_repository.dart';
import 'package:sendx/presentation/purchase/controllers/purchase_controller.dart';

class AddPurchaseController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();

  final RemoteRepository _remoteRepository;
  final PurchaseController _purchaseController;
  AddPurchaseController({
    required RemoteRepository remoteRepository,
    required PurchaseController purchaseController,
  })  : _remoteRepository = remoteRepository,
        _purchaseController = purchaseController;

  Future<({bool isDone, String message})> _addPurchase(
      AddPurchasRequest request) async {
    bool result = false;
    String message = '';
    await asyncTask(() async {
      final res = await _remoteRepository.addPurchase(request);
      result = res.status;
      message = res.message;
      if (result) _purchaseController.refreshPurchases();
    });
    return (isDone: result, message: message);
  }

  Future<({bool isDone, String message})> _updatePurchase(
      UpdatePurchaseRequest request) async {
    bool result = false;
    String message = '';
    await asyncTask(() async {
      final res = await _remoteRepository.updatePurchase(request);
      result = res.status;
      message = res.message;
      if (result) _purchaseController.refreshPurchases();
    });
    return (isDone: result, message: message);
  }

  Future<({bool isDone, String message})> onSubmit({
    bool isUpdating = false,
    int? updateID,
  }) async {
    formKey.currentState?.save();
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return (isDone: false, message: '');
    final formData = formKey.currentState?.value ?? {};
    final name = formData['name'].toString();
    final link = formData['link'].toString();
    final notes = formData['notes'].toString();
    final qty = num.parse(formData['qty']).toInt();
    if (isUpdating) {
      final request = UpdatePurchaseRequest(
        id: updateID,
        link: link,
        name: name,
        notes: notes,
        qty: qty,
      );
      return await _updatePurchase(request);
    } else {
      final request = AddPurchasRequest(
        name: name,
        link: link,
        notes: notes,
        qty: qty,
      );
      return await _addPurchase(request);
    }
  }
}
