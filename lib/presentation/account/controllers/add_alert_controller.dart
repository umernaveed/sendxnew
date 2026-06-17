import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:sendx/app/extensions/controller_ext.dart';
import 'package:sendx/app/services/file_picker_service.dart';
import 'package:sendx/data/models/requests/add_pre_alert_request/add_pre_alert_request.dart';
import 'package:sendx/domain/repositories/remote_repository.dart';

class AddPreAlertController extends GetxController {
  final RemoteRepository _remoteRepository;
  final FilePickerService _filePickerService;
  AddPreAlertController(
      {required RemoteRepository remoteRepository,
      required FilePickerService filePickerService})
      : _remoteRepository = remoteRepository,
        _filePickerService = filePickerService;

  final formKey = GlobalKey<FormBuilderState>();
  final pickedFile = File('').obs;
  final filePickError = ''.obs;

  bool get isFilePicked => pickedFile.value.path.isNotEmpty;

  String get pickedFileName =>
      isFilePicked ? pickedFile.value.path.split('/').last : '';

  Future<({bool isDone, String message})> onSubmit() async {
    validateFile();
    final isValid = formKey.currentState?.saveAndValidate() ?? false;
    if (!isValid) return (isDone: false, message: '');

    if (!isFilePicked) return (isDone: false, message: '');
    final formData = formKey.currentState?.value ?? {};
    if (formData.isEmpty) return (isDone: false, message: '');
    final request = AddPreAlertRequest(
      nickName: formData['nick_name'],
      merchant: formData['merchant'],
      courier: formData['courier'],
      supplierTrackingNo: formData['supplier_tracking_no'],
      weight: formData['weight'],
      price: formData['price'],
      itemDescription: formData['item_description'],
    );
    return _createAlert(request);
  }

  Future<({bool isDone, String message})> _createAlert(
      AddPreAlertRequest request) async {
    bool result = false;
    String message = '';
    await asyncTask(() async {
      final res = await _remoteRepository.addPreAlert(request);
      final m = res.message;
      final status = res.status;
      result = status;
      message = m;
      if (status) {
        formKey.currentState?.reset();
        clearFile();
      }
    });
    return (isDone: result, message: message);
  }

  void validateFile() {
    if (isFilePicked) {
      filePickError.value = '';
    } else {
      filePickError.value = 'Please select a file';
    }
  }

  Future<void> pickFile() async {
    try {
      final file = await _filePickerService.pickFile();
      if (file != null) {
        pickedFile.value = file;
      }
    } catch (_) {}
  }

  void clearFile() {
    pickedFile.value = File('');
  }
}
