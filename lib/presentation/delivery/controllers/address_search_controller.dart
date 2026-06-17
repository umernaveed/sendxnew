import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sendx/app/services/address_search_service.dart';
import 'package:sendx/data/models/address_prediction/address_prediction.dart';

class AddressSearchController extends GetxController {
  AddressSearchController() : _service = AddressSearchService();

  final AddressSearchService _service;
  final searchController = TextEditingController();
  final predictions = <AddressPrediction>[].obs;
  final isLoading = false.obs;

  static const String _debounceKey = 'address_search';

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void onClose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    _service.dispose();
    super.onClose();
  }

  void _onSearchChanged() {
    final query = searchController.text.trim();
    if (query.isEmpty) {
      predictions.clear();
      return;
    }
    _debouncedSearch(query);
  }

  void _debouncedSearch(String query) {
    EasyDebounce.debounce(
      _debounceKey,
      const Duration(milliseconds: 600),
      () => _search(query),
    );
  }

  Future<void> _search(String query) async {
    if (query.trim().isEmpty) {
      predictions.clear();
      return;
    }
    isLoading.value = true;
    predictions.clear();
    try {
      final list = await _service.search(query);
      predictions.assignAll(list);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onSelect(AddressPrediction prediction) async {
    if (prediction.placeIdString != null &&
        prediction.placeIdString!.isNotEmpty) {
      final latLon = await _service.getPlaceLatLon(prediction.placeIdString!);
      if (latLon != null) {
        Get.back(result: prediction.copyWith(lat: latLon.$1, lon: latLon.$2));
        return;
      }
    }
    Get.back(result: prediction);
  }
}
