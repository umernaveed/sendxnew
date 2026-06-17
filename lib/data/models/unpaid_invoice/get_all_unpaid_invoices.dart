import 'dart:core';

import 'package:sendx/data/models/unpaid_invoice/unpaid_invoice.dart';

class GetAllUnpaidInvoices {
  final List<UnpaidInvoice> unPaidInvoices;

  GetAllUnpaidInvoices({required this.unPaidInvoices});

  factory GetAllUnpaidInvoices.fromJson(List<dynamic> json) {
    return GetAllUnpaidInvoices(
      unPaidInvoices: json
          .map((e) => UnpaidInvoice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
