import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/app/extensions/controller_ext.dart';
import 'package:sendx/app/services/image_service.dart';
import 'package:sendx/app/util/flush_snackbar.dart';
import 'package:sendx/data/models/outlet/outlet.dart';
import 'package:sendx/data/models/requests/update_user_request/update_user_request.dart';
import 'package:sendx/domain/repositories/local_repository.dart';
import 'package:sendx/domain/repositories/remote_repository.dart';
import 'package:sendx/presentation/account/controllers/account_controller.dart';
import 'package:sendx/presentation/auth/widgets/drop_down.dart';

class UpdateProfileController extends GetxController {
  final RemoteRepository _remoteRepository;
  final LocalRepository _localRepository;
  final AccountController accountController;
  final IImagePicker _imagePicker;

  UpdateProfileController({
    required LocalRepository localRepository,
    required RemoteRepository remoteRepository,
    required IImagePicker imagePicker,
  })  : _remoteRepository = remoteRepository,
        _localRepository = localRepository,
        accountController = find<AccountController>(),
        _imagePicker = imagePicker;

  final formKey = GlobalKey<FormBuilderState>();
  final passwordVisibility = ValueNotifier<bool>(true);

  List<Outlet> get outLets => accountController.outLet.outLets;
  bool get isBusiness =>
      accountController.user.value.userType.toLowerCase() == 'business';
  final isTypeBusinnes = false.obs;
  File? file;

  OutLetPair? findOutLetForExsistingUser({required String outletId}) {
    final outLets = accountController.outLet.outLets;
    final outLet = outLets.firstWhereOrNull((e) => e.outletId == outletId);

    return outLet == null
        ? null
        : OutLetPair(value: outLet.outletName, key: outLet.outletId);
  }

  Future<void> onUpdate() async {
    formKey.currentState?.save();
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    final formData = formKey.currentState?.value ?? {};
    final userType = (formData['userType'] as NormalString).key;
    final isBusineesUser = userType.toLowerCase() == 'business';
    final address1 = formData['address1'] ?? '';
    final request = UpdateUserRequest(
      userType: userType,
      outletId: (formData['outletId'] as OutLetPair).key,
      firstName: formData['firstName'],
      lastName: formData['lastName'],
      email: formData['email'],
      phone: formData['phone'] ?? '',
      // trn: (formData['trn']).toString(),
      // mobile: formData['mobile'],
      // tccIssueDate: isBusineesUser
      //     ? DateFormat('yyyy-MM-dd')
      //         .format((formData['tccIssueDate'] as DateTime))
      //     : '',
      // tccExpiryDate: isBusineesUser
      //     ? DateFormat('yyyy-MM-dd')
      //         .format(formData['tccExpiryDate'] as DateTime)
      //     : '',
      // businessTrn: isBusineesUser ? formData['businessTrn'] : '',
      address1: address1,
      // address2: formData['address2'],
      // city: formData['city'],
      // state: formData['state'],
      // country: (formData['country'] as NormalString).key,
    );
    await _updateUser(request, file: file);
  }

  Future<void> _updateUser(
    UpdateUserRequest request, {
    File? file,
  }) async {
    String message = '';
    bool result = false;
    await asyncTask(() async {
      final res = await _remoteRepository.updateUser(request, file: file);
      message = res.message;
      result = res.status;
      final localUser = await _localRepository.getUser();
      final newUser = res.data.copyWith(
        loginToken: localUser.loginToken,
        accessToken: localUser.accessToken,
      );
      await _localRepository.saveUser(newUser);
      accountController.updateLocalUser(newUser);
    });
    if (result) {
      Get.back();
      Future.delayed(1.seconds, () {
        FlushSnackbar.showSnackBar(message);
      });
    }
  }

  Future<void> onImageSourceSelect({
    required ImageSourceWrapper sourceWrapper,
  }) async {
    try {
      final result =
          await _imagePicker.pickImageOnTheBaseOfSource(sourceWrapper);
      file = result;
      update(['avatar']);
    } on PermissionNotAllowed catch (_) {
      AppDialogs.showPermissionDeniedDialog();
    } on Exception catch (_) {}
  }

  void onUserTypeChange(String type) {
    if (type.toLowerCase() == 'business') {
      isTypeBusinnes.value = true;
    } else {
      isTypeBusinnes.value = false;
    }
  }

  toggleUserType() {}

  @override
  void onReady() {
    onUserTypeChange(accountController.user.value.userType);
    super.onReady();
  }

  @override
  void onClose() {
    passwordVisibility.dispose();
    super.onClose();
  }

  void onPasswordToggle() {
    final lastV = passwordVisibility.value;
    passwordVisibility.value = !lastV;
  }
}
