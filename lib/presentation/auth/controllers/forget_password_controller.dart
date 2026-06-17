import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:sendx/app/core/routes/app_pages.dart';
import 'package:sendx/app/extensions/controller_ext.dart';
import 'package:sendx/app/util/flush_snackbar.dart';
import 'package:sendx/data/models/requests/forget_password_request/forget_password_request.dart';
import 'package:sendx/domain/repositories/remote_repository.dart';

class ForgetPasswordController extends GetxController {
  final RemoteRepository _remoteRepository;
  ForgetPasswordController({
    required RemoteRepository remoteRepository,
  }) : _remoteRepository = remoteRepository;

  final formKey = GlobalKey<FormBuilderState>();

  Future<({bool isDone, String message})> _forgetPassword(
      ForgetPasswordRequest request) async {
    bool result = false;
    String message = '';
    await asyncTask(() async {
      final res = await _remoteRepository.forgetPassword(request);
      message = res.message;
      formKey.currentState?.reset();
      result = true;
    });
    return (isDone: result, message: message);
  }

  Future<void> onSubmit() async {
    try {
      final isValid = formKey.currentState?.saveAndValidate() ?? false;
      if (!isValid) return;
      final formData = formKey.currentState?.value ?? {};
      final request = ForgetPasswordRequest(
        email: formData['email'],
      );
      final result = await _forgetPassword(request);
      final isDone = result.isDone;
      final message = result.message;
      if (isDone) Get.offAllNamed(AppPages.login);
      if (message.isNotEmpty) {
        FlushSnackbar.showSnackBar(message);
      }
    } catch (e) {
      FlushSnackbar.showSnackBar(e.toString());
    }
  }
}
