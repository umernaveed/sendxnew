import 'package:intl/intl.dart';
import 'package:sendx/data/network/end_points.dart';

extension StringX on String {
  bool containsHtml() {
    String text = this;
    final pattern = RegExp(r'<[^>]*>');
    return pattern.hasMatch(text);
  }

  String get filterAndReturnHumainReadAble {
    final v = this;
    final validV = v.toLowerCase();
    if (validV.contains('timeout') ||
        validV.contains('socket') ||
        validV.contains('connection') ||
        validV.contains('Connecting') ||
        validV.contains('timed out') ||
        validV.contains('closed')) {
      return 'Something went wrong try again late';
    }
    return v;
  }

  String get filterNetConnection {
    final v = this;
    final validV = v.toLowerCase();
    if (validV.contains('timeout') ||
        validV.contains('socket') ||
        validV.contains('connection') ||
        validV.contains('Connecting') ||
        validV.contains('timed out') ||
        validV.contains('closed')) {
      return 'Please check your internet Connection';
    }
    return v;
  }

  String get filterServerError {
    final v = this;
    final validV = v.toLowerCase();
    if (validV == 'Internal Server Error'.toLowerCase()) {
      return 'Something went wrong try again late';
    } else {
      return validV;
    }
  }

  String get toElipsis {
    final name = this;
    return name.length > 22 ? '${name.substring(0, 10)}...' : name;
  }

  String get toDDMMYYYY {
    final inputDate = this;
    try {
      const outputFormat = 'dd-MM-yyyy';
      final date = DateTime.parse(inputDate);
      final outputDateFormat = DateFormat(outputFormat).format(date);
      return outputDateFormat;
    } catch (e) {
      return inputDate;
    }
  }

  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
}

extension FileNameFromUrlExtension on String {
  String extractFileNameWithoutExtension() {
    final uri = Uri.parse(this);
    final pathSegments = uri.pathSegments;

    if (pathSegments.isNotEmpty) {
      final fileNameWithExtension = pathSegments.last;
      final fileNameWithoutExtension = fileNameWithExtension.split('.').first;

      return fileNameWithoutExtension;
    }

    return ''; // Return an empty string or handle this case as needed
  }
}

extension RemoveBaseUrlExtension on String {
  String get removeBaseUrl {
    if (startsWith(EndPoints.baseURL)) {
      return substring(EndPoints.baseURL.length);
    } else {
      return this;
    }
  }
}

extension ImageUrlExtension on String {
  bool isSvgOrPngUrl() {
    final lowerCaseUrl = toLowerCase();
    return lowerCaseUrl.endsWith('.svg');
  }
}
