import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceInfoProvider {
  final DeviceInfoPlugin _deviceInfoPlugin;
  DeviceInfoProvider() : _deviceInfoPlugin = DeviceInfoPlugin() {
    init();
  }

  late String deviceType;
  late String deviceToken;
  late String appVersion;
  late String appVersionWithBuildNumber;
  late String timeZone;

  static const String _iosLink =
      'https://apps.apple.com/us/app/sendx-ja/id6743345579';
  static const String _androidLink =
      'https://play.google.com/store/apps/details?id=com.sendxm.app';

  void init() async {
    return switch (defaultTargetPlatform) {
      TargetPlatform.android => _andoird(),
      TargetPlatform.iOS => _ios(),
      _ => throw UnimplementedError('Polatform Not Supported'),
    }
        .then((_) {
      _deviceInfo();
    });
  }

  Future<void> _andoird() async {
    final AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
    final deviceIdentifier = androidInfo.id;
    deviceToken = deviceIdentifier;
    deviceType = 'android';
    timeZone = DateTime.now().timeZoneName;
  }

  Future<void> _ios() async {
    final IosDeviceInfo iosInfo = await _deviceInfoPlugin.iosInfo;
    final deviceIdentifier = iosInfo.identifierForVendor ?? '';
    deviceToken = deviceIdentifier;
    deviceType = 'ios';
    timeZone = DateTime.now().timeZoneName;
  }

  Future<void> _deviceInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final version = packageInfo.version;
    final buildNumber = packageInfo.buildNumber;
    appVersion = version;
    appVersionWithBuildNumber = '$version+$buildNumber';
  }

  String getStoreLink() {
    return switch (Platform.isAndroid) {
      true => _androidLink,
      false => _iosLink,
    };
  }
}

class Version implements Comparable<Version> {
  final int major;
  final int minor;
  final int patch;
  final int build;

  Version(this.major, this.minor, this.patch, this.build);

  factory Version.parse(String version) {
    List<String> parts = version.split('+');
    String versionPart = parts[0];
    int build = parts.length > 1 ? int.parse(parts[1]) : 0;

    List<String> versionNumbers = versionPart.split('.');
    int major = int.parse(versionNumbers[0]);
    int minor = int.parse(versionNumbers[1]);
    int patch = int.parse(versionNumbers[2]);

    return Version(major, minor, patch, build);
  }

  @override
  int compareTo(Version other) {
    if (major != other.major) {
      return major.compareTo(other.major);
    }
    if (minor != other.minor) {
      return minor.compareTo(other.minor);
    }
    if (patch != other.patch) {
      return patch.compareTo(other.patch);
    }
    return build.compareTo(other.build);
  }

  @override
  String toString() {
    return '$major.$minor.$patch+$build';
  }
}
