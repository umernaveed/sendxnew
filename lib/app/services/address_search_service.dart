import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sendx/data/models/address_prediction/address_prediction.dart';

/// Address search using Google Places Autocomplete.
class AddressSearchService {
  AddressSearchService() : _client = http.Client();

  static const String _googleApiKey = 'AIzaSyBo127TnyS6_wVpGiNGxSDWSeDsy1a0Wms';

  static const String _googleAutocompleteUrl =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  static const String _googleDetailsUrl =
      'https://maps.googleapis.com/maps/api/place/details/json';

  final http.Client _client;

  /// Fetches lat/lon for a Google place_id (Place Details API).
  /// Returns (lat, lon) or null on error.
  Future<(double, double)?> getPlaceLatLon(String placeId) async {
    final uri = Uri.parse(
      '$_googleDetailsUrl?place_id=${Uri.encodeQueryComponent(placeId)}'
      '&key=$_googleApiKey&fields=geometry',
    );
    try {
      final response =
          await _client.get(uri).timeout(const Duration(seconds: 10));
      if (response.statusCode != 200) return null;
      final body = jsonDecode(response.body) as Map<String, dynamic>?;
      if (body == null) return null;
      if (body['status'] != 'OK') return null;
      final result = body['result'] as Map<String, dynamic>?;
      final geometry = result?['geometry'] as Map<String, dynamic>?;
      final location = geometry?['location'] as Map<String, dynamic>?;
      if (location == null) return null;
      final lat = (location['lat'] as num?)?.toDouble();
      final lng = (location['lng'] as num?)?.toDouble();
      if (lat == null || lng == null) return null;
      return (lat, lng);
    } catch (_) {
      return null;
    }
  }

  /// [query] — search text (e.g. "Thokar niaz baig", "Sahiwal").
  /// Returns predictions from Google Places when API key is set; otherwise empty list.
  Future<List<AddressPrediction>> search(String query) async {
    final normalized = query.trim().replaceAll(RegExp(r'\s+'), ' ').trim();
    if (normalized.isEmpty) return [];

    final encoded = Uri.encodeQueryComponent(normalized);
    final uri = Uri.parse(
      '$_googleAutocompleteUrl?input=$encoded&key=$_googleApiKey&types=address',
    );

    try {
      final response =
          await _client.get(uri).timeout(const Duration(seconds: 10));

      if (response.statusCode != 200) return [];

      final body = jsonDecode(response.body) as Map<String, dynamic>?;
      if (body == null) return [];

      final status = body['status'] as String?;
      if (status != 'OK' && status != 'ZERO_RESULTS') return [];

      final predictions = body['predictions'] as List<dynamic>?;
      if (predictions == null) return [];

      return predictions
          .map((e) =>
              AddressPrediction.fromGoogleJson(e as Map<String, dynamic>))
          .where((e) => e.displayName.isNotEmpty)
          .toList();
    } catch (_) {
      return [];
    }
  }

  void dispose() {
    _client.close();
  }
}
