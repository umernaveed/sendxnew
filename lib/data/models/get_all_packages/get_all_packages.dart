import 'package:sendx/data/models/get_all_package/get_all_package.dart';

class GetAllPackagesResponse {
  final List<GetAllPackage> packages;

  GetAllPackagesResponse({required this.packages});

  factory GetAllPackagesResponse.fromJson(List<dynamic> json) {
    return GetAllPackagesResponse(
      packages: json
          .map((e) => GetAllPackage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
