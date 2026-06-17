import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:sendx/data/models/support_ticket/support_ticket.dart';
import 'package:sendx/data/network/api_client.dart';
import 'package:sendx/data/network/end_points.dart';

class SupportController extends GetxController {
  final IApiClient _apiClient;
  final formKey = GlobalKey<FormBuilderState>();
  final trackFormKey = GlobalKey<FormBuilderState>();
  final selectedFile = Rxn<File>();
  final createdTicketNumber = ''.obs;
  final trackedTicket = SupportTicket.empty().obs;
  final isLoading = false.obs;

  SupportController({required IApiClient apiClient}) : _apiClient = apiClient;

  final issueTypes = const [
    'Package Tracking',
    'Missing Package',
    'Damaged Package',
    'Customs/Receipt Issue',
    'Billing/Payment Issue',
    'Delivery Request',
    'Product Sourcing Request',
    'General Complaint',
    'Other',
  ];

  Future<void> pickAttachment() async {
    final result = await FilePicker.platform.pickFiles();
    final path = result?.files.single.path;
    if (path == null) return;
    selectedFile.value = File(path);
  }

  Future<({bool isDone, String message})> submitTicket() async {
    formKey.currentState?.save();
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return (isDone: false, message: '');

    final values = formKey.currentState?.value ?? {};
    final formData = FormData({
      'full_name': values['full_name'],
      'phone_number': values['phone_number'],
      'email': values['email'],
      'suite_number': values['suite_number'] ?? '',
      'tracking_number': values['tracking_number'] ?? '',
      'package_description': values['package_description'] ?? '',
      'issue_type': values['issue_type'],
      'description': values['description'],
    });

    final file = selectedFile.value;
    if (file != null) {
      formData.files.add(
        MapEntry(
          'attachment',
          MultipartFile(file, filename: file.path.split(Platform.pathSeparator).last),
        ),
      );
    }

    isLoading.value = true;
    final response = await _apiClient.postReq(EndPoints.createSupportTicket, formData);
    isLoading.value = false;

    final body = response.body;
    if (response.hasError || body == null || body['status'] != true) {
      return (isDone: false, message: '${body?['message'] ?? response.statusText ?? 'Unable to create ticket'}');
    }

    final ticket = SupportTicket.fromJson(Map<String, dynamic>.from(body['data']));
    createdTicketNumber.value = ticket.ticketNumber;
    formKey.currentState?.reset();
    selectedFile.value = null;
    return (isDone: true, message: 'Ticket created: ${ticket.ticketNumber}');
  }

  Future<({bool isDone, String message})> trackTicket() async {
    trackFormKey.currentState?.save();
    final isValid = trackFormKey.currentState?.validate() ?? false;
    if (!isValid) return (isDone: false, message: '');

    final values = trackFormKey.currentState?.value ?? {};
    isLoading.value = true;
    final response = await _apiClient.postReq(
      EndPoints.trackSupportTicket,
      {
        'ticket_number': values['ticket_number'],
        'contact': values['contact'],
      },
    );
    isLoading.value = false;

    final body = response.body;
    if (response.hasError || body == null || body['status'] != true) {
      trackedTicket.value = SupportTicket.empty();
      return (isDone: false, message: '${body?['message'] ?? response.statusText ?? 'Ticket not found'}');
    }

    trackedTicket.value = SupportTicket.fromJson(Map<String, dynamic>.from(body['data']));
    return (isDone: true, message: 'Ticket found');
  }
}
