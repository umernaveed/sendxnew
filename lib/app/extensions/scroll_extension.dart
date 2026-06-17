import 'package:flutter/material.dart';

extension ScrollControllerExtensions on ScrollController {
  List<void Function()> get _listeners =>
      <void Function()>[]; // Store callback references

  void onScrollEndsListener(
    final void Function() callback, {
    double offset = 0,
  }) {
    final maxScroll = position.maxScrollExtent;
    final currentScroll = position.pixels - offset;

    if (currentScroll == maxScroll) {
      callback();
    } else {
      _listeners.add(callback); // Store the callback reference
      addListener(() {
        final currentScroll = position.pixels - offset;

        if (currentScroll == maxScroll) {
          _listeners.remove(callback); // Remove the callback reference
          callback();
        }
      });
    }
  }

  void removeAttachedListener(final void Function() callback) {
    if (_listeners.contains(callback)) {
      removeListener(() {
        // Do nothing, just to clear the listener
      });
      _listeners.remove(callback);
    }
  }
}
