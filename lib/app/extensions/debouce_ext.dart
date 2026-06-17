import 'dart:async';

import 'package:easy_debounce/easy_debounce.dart';

extension FutureDebounceExtension<T> on Future<T> {
  Future<T> debounce(Duration duration) {
    final completer = Completer<T>();
    EasyDebounce.debounce(
      'future_debounce', // debounce key
      duration, // debounce duration
      () async {
        try {
          final result = await this;
          completer.complete(result);
        } catch (error) {
          completer.completeError(error);
        }
      },
    );
    return completer.future;
  }
}
