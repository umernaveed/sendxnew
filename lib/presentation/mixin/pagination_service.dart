import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

mixin PaginationService<T> {
  int get numberOfPostsPerRequest => 20;
  PagingController<int, T> get pagingController => _pagingController;
  late final PagingController<int, T> _pagingController;
  final TextEditingController _textEditingController = TextEditingController();
  TextEditingController get textEditingController => _textEditingController;

  void _addListener() {
    _textEditingController.addListener(() {
      _internelListener(0);
    });
    _pagingController.addPageRequestListener(_internelListener);
  }

  Future<List<T>> listener(int pageKey, {String keyToSearch = ''});

  Future<void> _internelListener(int pageKey) async {
    try {
      final searchText = _textEditingController.text;
      final isSearching = searchText.isNotEmpty;
      final items = await listener.call(
        pageKey,
        keyToSearch: searchText,
      );

      final isLastPage = items.length < numberOfPostsPerRequest;
      final uniqueItems = removeDuplicates(
        items,
        (item1, item2) => item1 == item2,
      );

      if (isSearching) {
        if (pageKey <= 0) {
          _pagingController.itemList = uniqueItems;
        } else {
          if (pageKey <= 0) {
            _pagingController.itemList?.clear();
          }
          _pagingController.appendPage(uniqueItems, pageKey);
        }
      } else if (isLastPage) {
        if (pageKey <= 0) {
          _pagingController.itemList?.clear();
        }
        _pagingController.appendLastPage(uniqueItems);
      } else {
        final nextPageKey = pageKey + 1;
        if (pageKey <= 0) {
          _pagingController.itemList?.clear();
        }
        _pagingController.appendPage(uniqueItems, nextPageKey);
      }
    } catch (e) {
      _pagingController.error = e;
    }
  }

  void initlizieController() {
    _pagingController = PagingController(firstPageKey: 0);
    _addListener();
  }

  void append(List<T> list, {required int nextPageKey}) {
    _pagingController.appendPage(list, nextPageKey);
  }

  void disposeController() {
    _textEditingController.removeListener(() {
      _internelListener(0);
    });
    _textEditingController.dispose();
    _pagingController.dispose();
  }

  List<T> removeDuplicates(List<T> list, bool Function(T, T) equals) {
    final uniqueList = <T>[];
    for (final item in list) {
      if (!uniqueList.any((existingItem) => equals(existingItem, item))) {
        uniqueList.add(item);
      }
    }
    return uniqueList;
  }

  T? findItem(int index) {
    return _pagingController.itemList?[index];
  }

  void updateListFromNewList(List<T> items) {
    _pagingController.itemList = items;
  }

  int? getIndex(T item) {
    return _pagingController.itemList?.indexOf(item);
  }

  /// create a function that will mute 1 property in the list and rebuild it
}
