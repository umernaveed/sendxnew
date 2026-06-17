import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/simple_builder.dart';

typedef ValueBuilderBuilderX<T> = Widget Function(
    T snapshot, ValueBuilderUpdateCallback<T> updater);

class ValueBuilderX<T> extends StatefulWidget {
  final T? initialValue;
  final ValueBuilderBuilderX<T> builder;
  final void Function()? onDispose;
  final void Function(T)? onUpdate;

  const ValueBuilderX({
    Key? key,
    this.initialValue,
    this.onDispose,
    this.onUpdate,
    required this.builder,
  }) : super(key: key);

  @override
  ValueBuilderState<T> createState() => ValueBuilderState<T>();
}

class ValueBuilderState<T> extends State<ValueBuilder<T?>> {
  T? value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) => widget.builder(value, updater);

  void updater(T? newValue) {
    if (widget.onUpdate != null) {
      widget.onUpdate!(newValue);
    }
    setState(() {
      value = newValue;
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.onDispose?.call();
    if (value is ChangeNotifier) {
      (value as ChangeNotifier?)?.dispose();
    } else if (value is StreamController) {
      (value as StreamController?)?.close();
    }
    value = null;
  }
}
