import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sendx/app/services/image_service.dart';

class PermissionService {
  ///Storage Permission
  Future<bool> getStoragePermission() async {
    if (Platform.isAndroid) {
      final isAndroid13 = await DeviceInfoPlugin().androidVersion >= 13;
      if (isAndroid13) return true;
    }

    final status = await Permission.storage.request();
    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
      return false;
    } else if (await Permission.storage.request().isDenied) {
      await openAppSettings();
      return false;
    } else {
      return false;
    }
  }

  Future<void> askNotificationPermission() async {
    final isAllowed = await isNotificationPermissionAllowed();
    if (isAllowed) return;
    if (!isAllowed) {
      final status = await Permission.notification.request();
      if (status == PermissionStatus.denied) {
        await AppSettings.openAppSettings(type: AppSettingsType.notification);
      } else if (status == PermissionStatus.permanentlyDenied) {
        await AppSettings.openAppSettings(type: AppSettingsType.notification);
      }
    }
  }

  Future<bool> isNotificationPermissionAllowed() async {
    var isAllowed = false;
    const notificationP = Permission.notification;
    final isDenied = await notificationP.isDenied;
    final isPDenied = await notificationP.isPermanentlyDenied;
    final isGranted = await notificationP.isGranted;
    if (isGranted) {
      isAllowed = true;
    }
    if (isDenied || isPDenied && !isGranted) {
      isAllowed = false;
    }
    return isAllowed;
  }

  // Future<bool> isPhotoPermissionAllowed() async {
  //   final status = await Permission.photos.status;
  //   return status.isGranted || status.isLimited;
  // }

  Future<bool> isPhotoPermissionPermanentalyDenied() async {
    if (Platform.isIOS) {
      final status = await Permission.photos.status;
      return status.isPermanentlyDenied || status.isDenied;
    } else if (Platform.isAndroid) {
      final status = await Permission.photos.status;
      final isAndroid13 = await DeviceInfoPlugin().androidVersion >= 13;
      if (isAndroid13) {
        return false;
      }
      return status.isPermanentlyDenied || status.isDenied;
    } else {
      throw UnimplementedError('Platform not implemented');
    }
  }

  Future<bool> isCameraPermissionPermanentalyDenied() async {
    if (Platform.isIOS) {
      final status = await Permission.camera.status;
      return status.isPermanentlyDenied || status.isDenied;
    } else if (Platform.isAndroid) {
      final status = await Permission.camera.status;
      final isAndroid13 = await DeviceInfoPlugin().androidVersion >= 13;
      if (isAndroid13) {
        return false;
      }
      return status.isPermanentlyDenied || status.isDenied;
    } else {
      throw UnimplementedError('Platform not implemented');
    }
  }

  Future<bool> askPhotoPermission() async {
    final status = await Permission.photos.request();
    return status.isGranted;
  }

  Future<bool> askStoragePermission() async {
    final status = await Permission.storage.request();
    return status.isGranted;
  }

  Future<bool> askCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }
}
