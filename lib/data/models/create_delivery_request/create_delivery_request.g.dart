// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_delivery_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateDeliveryRequest _$CreateDeliveryRequestFromJson(
        Map<String, dynamic> json) =>
    CreateDeliveryRequest(
      name: json['name'] as String,
      phone: json['phone'] as String,
      reqDate: json['req_date'] as String,
      reqTime: json['req_time'] as String,
      noOfPackages: json['no_of_packages'] as String,
      packageIds: json['package_ids'] as String,
      packageTotal: json['package_total'] as String,
      notes: json['notes'] as String,
      address: json['address'] as String,
      day: json['day'] as String,
      areaId: json['area_id'] as String,
      cost: json['cost'] as String,
      timeoslotId: json['timeslot_id'] as String,
      deliveryType: json['delivery_type'] as String,
      tdate: json['tdate'] as String,
    );

Map<String, dynamic> _$CreateDeliveryRequestToJson(
        CreateDeliveryRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'req_date': instance.reqDate,
      'req_time': instance.reqTime,
      'no_of_packages': instance.noOfPackages,
      'package_ids': instance.packageIds,
      'package_total': instance.packageTotal,
      'notes': instance.notes,
      'address': instance.address,
      'day': instance.day,
      'area_id': instance.areaId,
      'cost': instance.cost,
      'timeslot_id': instance.timeoslotId,
      'delivery_type': instance.deliveryType,
      'tdate': instance.tdate,
    };
