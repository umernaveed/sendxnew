import 'package:json_annotation/json_annotation.dart';

part 'get_packages_ready_for_pickup_response.g.dart';

@JsonSerializable()
class Package {
  @JsonKey(name: 'packeg_id', defaultValue: -1)
  final int packegId;
  @JsonKey(name: 'tracking_no', defaultValue: '')
  final String trackingNo;
  @JsonKey(name: 'mailbox', defaultValue: '')
  final String mailbox;
  @JsonKey(name: 'outlet_id', defaultValue: '')
  final String outletId;
  @JsonKey(name: 'user_name', defaultValue: '')
  final String userName;
  @JsonKey(name: 'supplier_tracking_no', defaultValue: '')
  final String supplierTrackingNo;
  @JsonKey(name: 'courier', defaultValue: '')
  final String courier;
  @JsonKey(name: 'price', defaultValue: '')
  final String price;
  @JsonKey(name: 'item_description', defaultValue: '')
  final String itemDescription;
  @JsonKey(name: 'package_type', defaultValue: '')
  final String packageType;
  @JsonKey(name: 'package_code', defaultValue: '')
  final String packageCode;
  @JsonKey(name: 'weight', defaultValue: '')
  final String weight;
  @JsonKey(name: 'invoice', defaultValue: '')
  final String invoice;
  @JsonKey(name: 'status', defaultValue: 1)
  final int status;
  @JsonKey(name: 'is_added_manifest', defaultValue: -1)
  final int isAddedManifest;
  @JsonKey(name: 'is_temprary_logs', defaultValue: -1)
  final int isTempraryLogs;
  @JsonKey(name: 'delivery', defaultValue: -1)
  final int delivery;
  @JsonKey(name: 'freight_type', defaultValue: '')
  final String freightType;
  @JsonKey(name: 'dilivery_description', defaultValue: '')
  final String diliveryDescription;
  @JsonKey(name: 'nick_name', defaultValue: '')
  final String nickName;
  @JsonKey(name: 'pk_no', defaultValue: '')
  final String pkNo;
  @JsonKey(name: 'manifest_no', defaultValue: '')
  final String manifestNo;
  @JsonKey(name: 'merchant', defaultValue: '')
  final String merchant;
  @JsonKey(name: 'location_id', defaultValue: '')
  final String locationId;
  @JsonKey(name: 'permotion_code', defaultValue: '')
  final String permotionCode;
  @JsonKey(name: 'pieces', defaultValue: '')
  final String pieces;
  @JsonKey(name: 'package_status', defaultValue: -1)
  final int packageStatus;
  @JsonKey(name: 'status_name', defaultValue: '')
  final String statusName;
  @JsonKey(name: 'is_request', defaultValue: -1)
  final int isRequest;
  @JsonKey(name: 'is_warehouse', defaultValue: -1)
  final int isWarehouse;
  @JsonKey(name: 'csv_package_status', defaultValue: '')
  final String csvPackageStatus;
  @JsonKey(name: 'date_received', defaultValue: '')
  final String dateReceived;
  @JsonKey(name: 'time_recieved', defaultValue: '')
  final String timeRecieved;
  @JsonKey(name: 'comments', defaultValue: '')
  final String comments;
  @JsonKey(name: 'quantity', defaultValue: '')
  final String quantity;
  @JsonKey(name: 'cubic_cft', defaultValue: '')
  final String cubicCft;
  @JsonKey(name: 'created_at', defaultValue: '')
  final String createdAt;
  @JsonKey(name: 'updated_at', defaultValue: '')
  final String updatedAt;
  @JsonKey(name: 'is_invoice', defaultValue: 0)
  final int isInvoice;
  @JsonKey(name: 'invoice_no', defaultValue: 0)
  final int invoiceNo;

  const Package({
    required this.packegId,
    required this.trackingNo,
    required this.mailbox,
    required this.outletId,
    required this.userName,
    required this.supplierTrackingNo,
    required this.courier,
    required this.price,
    required this.itemDescription,
    required this.packageType,
    required this.packageCode,
    required this.weight,
    required this.invoice,
    required this.status,
    required this.isAddedManifest,
    required this.isTempraryLogs,
    required this.delivery,
    required this.freightType,
    required this.diliveryDescription,
    required this.nickName,
    required this.manifestNo,
    required this.merchant,
    required this.locationId,
    required this.permotionCode,
    required this.pieces,
    required this.packageStatus,
    required this.statusName,
    required this.isRequest,
    required this.isWarehouse,
    required this.csvPackageStatus,
    required this.dateReceived,
    required this.timeRecieved,
    required this.comments,
    required this.quantity,
    required this.cubicCft,
    required this.createdAt,
    required this.updatedAt,
    required this.pkNo,
    required this.invoiceNo,
    required this.isInvoice,
  });

  factory Package.fromJson(Map<String, dynamic> json) {
    return _$PackageFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PackageToJson(this);
  }

  @override
  bool operator ==(covariant Package other) {
    if (identical(this, other)) return true;

    return other.packegId == packegId &&
        other.trackingNo == trackingNo &&
        other.mailbox == mailbox &&
        other.outletId == outletId &&
        other.userName == userName &&
        other.supplierTrackingNo == supplierTrackingNo &&
        other.courier == courier &&
        other.price == price &&
        other.itemDescription == itemDescription &&
        other.packageType == packageType &&
        other.packageCode == packageCode &&
        other.weight == weight &&
        other.invoice == invoice &&
        other.status == status &&
        other.isAddedManifest == isAddedManifest &&
        other.isTempraryLogs == isTempraryLogs &&
        other.delivery == delivery &&
        other.freightType == freightType &&
        other.diliveryDescription == diliveryDescription &&
        other.nickName == nickName &&
        other.manifestNo == manifestNo &&
        other.merchant == merchant &&
        other.locationId == locationId &&
        other.permotionCode == permotionCode &&
        other.pieces == pieces &&
        other.packageStatus == packageStatus &&
        other.statusName == statusName &&
        other.isRequest == isRequest &&
        other.isWarehouse == isWarehouse &&
        other.csvPackageStatus == csvPackageStatus &&
        other.dateReceived == dateReceived &&
        other.timeRecieved == timeRecieved &&
        other.comments == comments &&
        other.quantity == quantity &&
        other.cubicCft == cubicCft &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return packegId.hashCode ^
        trackingNo.hashCode ^
        mailbox.hashCode ^
        outletId.hashCode ^
        userName.hashCode ^
        supplierTrackingNo.hashCode ^
        courier.hashCode ^
        price.hashCode ^
        itemDescription.hashCode ^
        packageType.hashCode ^
        packageCode.hashCode ^
        weight.hashCode ^
        invoice.hashCode ^
        status.hashCode ^
        isAddedManifest.hashCode ^
        isTempraryLogs.hashCode ^
        delivery.hashCode ^
        freightType.hashCode ^
        diliveryDescription.hashCode ^
        nickName.hashCode ^
        manifestNo.hashCode ^
        merchant.hashCode ^
        locationId.hashCode ^
        permotionCode.hashCode ^
        pieces.hashCode ^
        packageStatus.hashCode ^
        statusName.hashCode ^
        isRequest.hashCode ^
        isWarehouse.hashCode ^
        csvPackageStatus.hashCode ^
        dateReceived.hashCode ^
        timeRecieved.hashCode ^
        comments.hashCode ^
        quantity.hashCode ^
        cubicCft.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}

class AllPackagesReadyToPick {
  final List<Package> packages;

  AllPackagesReadyToPick({required this.packages});

  factory AllPackagesReadyToPick.fromJson(List<dynamic> json) {
    return AllPackagesReadyToPick(
      packages:
          json.map((e) => Package.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}
