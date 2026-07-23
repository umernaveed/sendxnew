import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:sendx/data/models/user/user.dart';
import 'package:sendx/data/models/support_ticket/support_ticket.dart';
import 'package:sendx/data/network/api_client.dart';
import 'package:sendx/data/network/end_points.dart';
import 'package:sendx/domain/repositories/local_repository.dart';

class SupportController extends GetxController {
  final IApiClient _apiClient;
  final LocalRepository _localRepository;
  final formKey = GlobalKey<FormBuilderState>();
  final trackFormKey = GlobalKey<FormBuilderState>();
  final selectedFile = Rxn<File>();
  final createdTicketNumber = ''.obs;
  final trackedTicket = SupportTicket.empty().obs;
  final tickets = <SupportTicket>[].obs;
  final selectedIssueType = 'Missing Package'.obs;
  final selectedPriority = 'Normal'.obs;
  final isLoading = false.obs;
  final isTicketsLoading = false.obs;

  SupportController({
    required IApiClient apiClient,
    required LocalRepository localRepository,
  })  : _apiClient = apiClient,
        _localRepository = localRepository;

  final issueTypes = <String>[
    'Package Tracking',
    'Missing Package',
    'Damaged Package',
    'Customs/Receipt Issue',
    'Billing/Payment Issue',
    'Delivery Request',
    'Product Sourcing Request',
    'General Complaint',
    'Other',
  ].obs;

  final priorities = const ['Normal', 'Important', 'Urgent'];

  User get user => _localRepository.getInstantUser();

  String get contactName {
    final name = user.completeName.trim();
    if (name.isNotEmpty) return name;
    return user.userName.trim().isNotEmpty ? user.userName.trim() : 'SendX Customer';
  }

  String get contactPhone {
    if (user.phone.trim().isNotEmpty) return user.phone.trim();
    if (user.mobile.trim().isNotEmpty) return user.mobile.trim();
    return '';
  }

  String get contactEmail => user.email.trim();

  int get openCount => _countByStatus(['open']);
  int get pendingCount => _countByStatus(['pending', 'in progress', 'waiting on customer', 'escalated']);
  int get closedCount => _countByStatus(['closed', 'resolved']);

  List<SupportTicket> get recentTickets => tickets.take(3).toList();

  @override
  void onInit() {
    super.onInit();
    loadIssueTypes();
    loadTickets();
  }

  int _countByStatus(List<String> values) {
    return tickets.where((ticket) {
      final status = ticket.status.toLowerCase();
      return values.any(status.contains);
    }).length;
  }

  Future<void> loadIssueTypes() async {
    try {
      final response = await _apiClient.getReq(EndPoints.supportTicketIssueTypes);
      final body = response.body;
      if (response.hasError || body is! Map || body['status'] != true || body['data'] is! List) return;
      final remoteTypes = (body['data'] as List).map((e) => '$e').where((e) => e.isNotEmpty).toList();
      if (remoteTypes.isNotEmpty) {
        issueTypes
          ..clear()
          ..addAll(remoteTypes);
        if (!issueTypes.contains(selectedIssueType.value)) {
          selectedIssueType.value = issueTypes.first;
        }
      }
    } catch (_) {}
  }

  Future<void> loadTickets() async {
    isTicketsLoading.value = true;
    try {
      final response = await _apiClient.postReq(
        EndPoints.getSupportTickets,
        {'offset': '0'},
      );
      final body = response.body;
      if (response.hasError || body is! Map || body['status'] != true || body['data'] is! List) return;
      tickets.value = (body['data'] as List)
          .whereType<Map>()
          .map((e) => SupportTicket.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } catch (_) {
      tickets.clear();
    } finally {
      isTicketsLoading.value = false;
    }
  }

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
    final fullName = '${values['full_name'] ?? contactName}'.trim();
    final phone = '${values['phone_number'] ?? contactPhone}'.trim();
    final email = '${values['email'] ?? contactEmail}'.trim();
    final formData = dio.FormData.fromMap({
      'full_name': fullName,
      'phone_number': phone,
      'email': email,
      'suite_number': values['suite_number'] ?? '',
      'tracking_number': values['tracking_number'] ?? '',
      'package_description': values['package_description'] ?? '',
      'issue_type': values['issue_type'] ?? selectedIssueType.value,
      'priority': values['priority'] ?? selectedPriority.value,
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
      selectedPriority.value = 'Normal';
      await loadTickets();
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
    final values = trackFormKey.currentState?.value ?? {};
    final ticketNumber = '${values['ticket_number'] ?? ''}'.trim();
    final contact = '${values['contact'] ?? ''}'.trim();
    if (ticketNumber.isEmpty && contact.isEmpty) {
      return (isDone: false, message: 'Please enter ticket number or email/phone.');
    }

    isLoading.value = true;
    try {
      final response = await _apiClient.postReq(
        EndPoints.trackSupportTicket,
        {
          'ticket_number': ticketNumber,
          'contact': contact,
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
