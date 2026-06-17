import 'package:flutter/material.dart';

mixin SearchingMixin<T> {
  List<T> _searchList = [];

  late final TextEditingController _textEditingController;

  String get _searchText => _textEditingController.text;
  TextEditingController get textEditingController => _textEditingController;

  List<T> get searchList => _searchList;

  void updateSearchList(List<T> items) {
    _searchList = items;
  }

  void clearSearchList() {
    _searchList = [];
  }

  Future<List<T>> search(String key);

  Future<void> _internelListener() async {
    try {
      final items = await search.call(_searchText);
      updateSearchList(items);
    } catch (_) {}
  }

  void filterSearchList(bool Function(T) predicate) {
    _searchList = _searchList.where(predicate).toList();
  }

  void sortSearchList(int Function(T, T) compare) {
    _searchList.sort(compare);
  }

  int getSearchListLength() {
    return _searchList.length;
  }

  T getSearchListElement(int index) {
    return _searchList[index];
  }

  void dispose() {
    _textEditingController.removeListener(_internelListener);
    _textEditingController.dispose();
  }

  void initlizieController() {
    _textEditingController = TextEditingController();
    _textEditingController.addListener(_internelListener);
  }
}
