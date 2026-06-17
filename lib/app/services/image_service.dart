import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/app/services/app_permission_service.dart';

abstract class IImagePicker {
  /// input: Nothing
  /// output: [File]
  /// exception: [FileException]
  Future<File> pickImageFromCamera();

  /// input: Nothing
  /// output: [File]
  /// exception: [FileException]
  Future<File> pickImageFromGallery({bool allowCrope = true});

  /// input: [File]
  /// output: [File]
  /// exception: [FileException]
  Future<File> cropImage({required File file});

  /// input: [ImageSourceWrapper]
  /// output: [File]
  /// exception: [FileException]
  /// this function will throw [FileException] if its failed
  /// recommended:
  Future<File> pickImageOnTheBaseOfSource(ImageSourceWrapper source);
}

class ImagePickerImp implements IImagePicker {
  ImagePickerImp()
      : _imagePicker = ImagePicker(),
        _imageCropper = ImageCropper(),
        _permissionService = find<PermissionService>();

  final ImagePicker _imagePicker;
  final ImageCropper _imageCropper;
  final PermissionService _permissionService;

  @override
  Future<File> pickImageFromCamera() async {
    final result = await _imagePicker.pickImage(source: ImageSource.camera);
    final file = result.toFile();
    final croppedImage = await cropImage(file: file);
    return croppedImage;
  }

  @override
  Future<File> pickImageFromGallery({bool allowCrope = true}) async {
    final result = await _imagePicker.pickImage(source: ImageSource.gallery);
    final file = result.toFile();
    if (!allowCrope) return file;
    final croppedImage = await cropImage(file: file);
    return croppedImage;
  }

  @override
  Future<File> cropImage({required File file}) async {
    final e = await _imageCropper.cropImage(
      sourcePath: file.path,
      //
      maxWidth: 1080,
      maxHeight: 1080,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          cropStyle: CropStyle.circle,
          statusBarColor: Colors.white,
        ),
        IOSUiSettings(
          doneButtonTitle: 'Done',
          cropStyle: CropStyle.circle,
          cancelButtonTitle: 'Cancel',
        ),
      ],
    );
    if (e == null) throw FileException(cause: 'Error While Cropping');
    return File(e.path);
  }

  @override
  Future<File> pickImageOnTheBaseOfSource(ImageSourceWrapper source) {
    return checkPermissionAndExecute(
      () {
        return switch (source) {
          ImageSourceWrapper.gallery => pickImageFromGallery(),
          ImageSourceWrapper.camera => pickImageFromCamera(),
          _ => throw FileException(),
        };
      },
      source: source,
    );
  }

  Future<T> checkPermissionAndExecute<T>(
    Future<T> Function() callback, {
    required ImageSourceWrapper source,
  }) async {
    if (source.isCamera) {
      await handleCameraPermission();
    } else {
      await handlePhotoPermission();
    }

    return callback();
  }

  Future<void> handleCameraPermission() async {
    final isCameraPermissionDenied =
        await _permissionService.isCameraPermissionPermanentalyDenied();

    if (isCameraPermissionDenied) {
      final isPermissionGranted =
          await _permissionService.askCameraPermission();

      if (!isPermissionGranted) {
        const message = 'Camera Permission is Denied';
        throw PermissionNotAllowed(message);
      }
    }
  }

  Future<void> handlePhotoPermission() async {
    final isPhotoPermissionPermanentlyDenied =
        await _permissionService.isPhotoPermissionPermanentalyDenied();

    if (isPhotoPermissionPermanentlyDenied) {
      var isPermissionGranted = false;
      if (Platform.isIOS || (await DeviceInfoPlugin().androidVersion >= 13)) {
        isPermissionGranted = await _permissionService.askPhotoPermission();
      } else {
        isPermissionGranted = await _permissionService.askStoragePermission();
      }
      if (!isPermissionGranted) {
        const message = 'Photo Permission is Denied';
        throw PermissionNotAllowed(message);
      }
    }
  }
}

extension FileX on XFile? {
  File toFile() {
    final _ = this;
    if (_ == null || _.path.isEmpty) throw FileException();
    final file = File(this!.path);
    if (!file.existsSync()) throw FileException();
    return file;
  }
}

extension FileExtension on File? {
  File toFile() {
    final _ = this;
    if (_ == null || _.path.isEmpty) throw FileException();
    return _;
  }
}

class FileException implements Exception {
  FileException({this.cause});
  final String? cause;
  @override
  String toString() {
    return cause ?? 'File Not Found';
  }
}

enum ImageSourceWrapper {
  gallery,
  camera,
  delete;

  bool get isDelete => this == ImageSourceWrapper.delete;
  bool get isCamera => this == ImageSourceWrapper.camera;
}

extension XDeviceInfoPlugin on DeviceInfoPlugin {
  Future<int> get androidVersion async {
    final info = await androidInfo;
    return int.parse(info.version.release);
  }
}

class PermissionNotAllowed implements Exception {
  PermissionNotAllowed(this.cause);
  String cause;

  @override
  String toString() {
    return cause;
  }
}
