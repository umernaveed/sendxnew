// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outlet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Outlet _$OutletFromJson(Map<String, dynamic> json) => Outlet(
      outletId: json['outlet_id'] as String? ?? '',
      outletName: json['outlet_name'] as String? ?? '',
    );

Map<String, dynamic> _$OutletToJson(Outlet instance) => <String, dynamic>{
      'outlet_id': instance.outletId,
      'outlet_name': instance.outletName,
    };
