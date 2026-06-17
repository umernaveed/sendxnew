/// Represents a location prediction (Nominatim or Google Places).
class AddressPrediction {
  const AddressPrediction({
    required this.displayName,
    this.lat,
    this.lon,
    this.name,
    this.placeId,
    this.placeIdString,
    this.address,
  });

  /// Parses Google Places Autocomplete prediction.
  /// [placeIdString] is used to fetch lat/lon via Place Details when selected.
  factory AddressPrediction.fromGoogleJson(Map<String, dynamic> json) {
    final description = json['description'] as String? ?? '';
    return AddressPrediction(
      displayName: description,
      name: (json['structured_formatting']
          as Map<String, dynamic>?)?['main_text'] as String?,
      placeId: null,
      placeIdString: json['place_id'] as String?,
      address: null,
    );
  }

  /// Parses Nominatim search result item.
  /// [lat]/[lon] are returned as strings; [address] is a nested object.
  factory AddressPrediction.fromJson(Map<String, dynamic> json) {
    final latRaw = json['lat'];
    final lonRaw = json['lon'];
    double? lat;
    double? lon;
    if (latRaw != null) {
      if (latRaw is num) {
        lat = latRaw.toDouble();
      } else {
        lat = double.tryParse(latRaw.toString());
      }
    }
    if (lonRaw != null) {
      if (lonRaw is num) {
        lon = lonRaw.toDouble();
      } else {
        lon = double.tryParse(lonRaw.toString());
      }
    }

    Map<String, dynamic>? addressMap;
    final addressRaw = json['address'];
    if (addressRaw is Map<String, dynamic>) {
      addressMap = addressRaw;
    } else if (addressRaw is Map) {
      addressMap = Map<String, dynamic>.from(addressRaw);
    }

    return AddressPrediction(
      displayName: json['display_name'] as String? ?? '',
      lat: lat,
      lon: lon,
      name: json['name'] as String?,
      placeId: json['place_id'] is int
          ? json['place_id'] as int
          : int.tryParse(json['place_id']?.toString() ?? ''),
      address: addressMap,
    );
  }

  final String displayName;
  final double? lat;
  final double? lon;
  final String? name;
  final int? placeId;

  /// Google Places place_id (string); used to fetch lat/lon via Place Details.
  final String? placeIdString;
  final Map<String, dynamic>? address;

  /// Returns a copy with [lat] and [lon] set (e.g. after fetching from Place Details).
  AddressPrediction copyWith({double? lat, double? lon}) {
    return AddressPrediction(
      displayName: displayName,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      name: name,
      placeId: placeId,
      placeIdString: placeIdString,
      address: address,
    );
  }

  /// Display in "City, Country" format for the UI (English).
  /// Uses [address] map when available; falls back to [displayName].
  String get cityCountryDisplay {
    final addr = address;
    if (addr == null) return displayName;
    final cityPart = addr['city'] as String? ??
        addr['town'] as String? ??
        addr['village'] as String? ??
        addr['municipality'] as String? ??
        addr['suburb'] as String? ??
        addr['subdistrict'] as String? ??
        addr['county'] as String? ??
        addr['state_district'] as String? ??
        name ??
        '';
    final countryPart = addr['country'] as String? ?? '';
    final city = cityPart.trim();
    final country = countryPart.trim();
    if (city.isEmpty && country.isEmpty) return displayName;
    if (city.isEmpty) return country;
    if (country.isEmpty) return city;
    return '$city, $country';
  }
}
