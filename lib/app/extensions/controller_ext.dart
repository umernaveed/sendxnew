import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sendx/app/util/flush_snackbar.dart';
import 'package:sendx/data/datasource/remote_data_source.dart';

extension GetXControllerX on GetxController {
  Future<void> asyncTask(Future<void> Function() operation) async {
    try {
      showLoading();
      await operation();
      dissmissLoading();
    } on CommonException catch (e) {
      dissmissLoading();
      FlushSnackbar.showSnackBar(e.toString(), isError: true);
    } on MessageException catch (e) {
      dissmissLoading();
      FlushSnackbar.showSnackBar(e.toString(), isError: true);
    } on UnAuthorizeException catch (e) {
      dissmissLoading();
      FlushSnackbar.showSnackBar(e.toString(), isError: true);
    } catch (e) {
      dissmissLoading();
      FlushSnackbar.showSnackBar('Something Went Wrong', isError: true);
    }
  }

  Future<T?> asyncTaskWithResult<T>(Future<T?> Function() operation) async {
    try {
      showLoading();
      final result = await operation();
      dissmissLoading();
      return result;
    } on CommonException catch (e) {
      dissmissLoading();
      FlushSnackbar.showSnackBar(e.toString(), isError: true);
    } on MessageException catch (e) {
      dissmissLoading();
      FlushSnackbar.showSnackBar(e.toString(), isError: true);
    } on UnAuthorizeException catch (e) {
      dissmissLoading();
      FlushSnackbar.showSnackBar(e.toString(), isError: true);
    } catch (e) {
      dissmissLoading();
      FlushSnackbar.showSnackBar('Something Went Wrong', isError: true);
    }

    /// else return null;
    return null;
  }
}

void showLoading() {
  if (Get.isDialogOpen ?? false) return;
  Get.dialog(
    const Loading(),
    barrierDismissible: kDebugMode,
    transitionCurve: Curves.bounceIn,
    barrierColor: Colors.transparent,
  );
}

void dissmissLoading() {
  if (!(Get.isDialogOpen ?? false)) return;
  Get.back();
}

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 5,
        sigmaY: 5,
      ),
      child: Container(
        width: context.width,
        height: context.height,
        color: Colors.transparent,
        child: Center(
          child: AppBody(
            'discreteCircle',
            LoadingAnimationWidget.fourRotatingDots(
              color: const Color(0xFF4791CE),
              size: 85,
            ),
          ).widget,
        ),
      ),
    );
  }
}

class AppBody {
  AppBody(
    this.title,
    this.widget,
  );
  final String title;
  final Widget widget;
}
