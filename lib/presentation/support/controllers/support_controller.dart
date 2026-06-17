import 'dart:io';

import 'package:dio/dio.dart' as dio;
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

  String _errorMessage(dynamic body, String? fallback) {
    if (body is Map && body['message'] != null && '${body['message']}'.isNotEmpty) {
      return '${body['message']}';
    }
    return fallback?.isNotEmpty == true ? fallback! : 'Request failed. Please try again.';
  }

  Future<void> pickAttachment() async {
    final result = await FilePicker.platform.pickFiles();
    final path = result?.files.single.path;
    if (path == null) return;
    selectedFile.value = File(path);
  }

  Future<({bool isDone, String message})> submitTicket() async {
    FocusManager.instance.primaryFocus?.unfocus();
    formKey.currentState?.save();
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return (isDone: false, message: 'Please complete all required ticket fields.');
    }

    final values = formKey.currentState?.value ?? {};
    final formData = dio.FormData.fromMap({
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
          await dio.MultipartFile.fromFile(
            file.path,
            filename: file.path.split(Platform.pathSeparator).last,
          ),
        ),
      );
    }

    isLoading.value = true;
    try {
      final response = await _apiClient.postReq(EndPoints.createSupportTicket, formData);

      final body = response.body;
      if (response.hasError || body == null || body is! Map || body['status'] != true) {
        return (isDone: false, message: _errorMessage(body, response.statusText));
      }

      final ticket = SupportTicket.fromJson(Map<String, dynamic>.from(body['data']));
      createdTicketNumber.value = ticket.ticketNumber;
      formKey.currentState?.reset();
      selectedFile.value = null;
      return (isDone: true, message: 'Ticket created: ${ticket.ticketNumber}');
    } catch (_) {
      return (isDone: false, message: 'Unable to create ticket. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<({bool isDone, String message})> trackTicket() async {
    FocusManager.instance.primaryFocus?.unfocus();
    trackFormKey.currentState?.save();
    final isValid = trackFormKey.currentState?.validate() ?? false;
    if (!isValid) {
      return (isDone: false, message: 'Please enter ticket number and email or phone.');
    }

    final values = trackFormKey.currentState?.value ?? {};
    isLoading.value = true;
    try {
      final response = await _apiClient.postReq(
        EndPoints.trackSupportTicket,
        {
          'ticket_number': values['ticket_number'],
          'contact': values['contact'],
        },
      );

      final body = response.body;
      if (response.hasError || body == null || body is! Map || body['status'] != true) {
        trackedTicket.value = SupportTicket.empty();
        return (isDone: false, message: _errorMessage(body, response.statusText));
      }

      trackedTicket.value = SupportTicket.fromJson(Map<String, dynamic>.from(body['data']));
      return (isDone: true, message: 'Ticket found');
    } catch (_) {
      trackedTicket.value = SupportTicket.empty();
      return (isDone: false, message: 'Unable to check ticket status. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }
}
