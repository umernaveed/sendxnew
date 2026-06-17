class SupportTicket {
  final int id;
  final String ticketNumber;
  final String fullName;
  final String phoneNumber;
  final String email;
  final String suiteNumber;
  final String trackingNumber;
  final String packageDescription;
  final String issueType;
  final String description;
  final String status;
  final String createdAt;

  const SupportTicket({
    required this.id,
    required this.ticketNumber,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.suiteNumber,
    required this.trackingNumber,
    required this.packageDescription,
    required this.issueType,
    required this.description,
    required this.status,
    required this.createdAt,
  });

  factory SupportTicket.fromJson(Map<String, dynamic> json) {
    return SupportTicket(
      id: int.tryParse('${json['id'] ?? 0}') ?? 0,
      ticketNumber: '${json['ticket_number'] ?? ''}',
      fullName: '${json['full_name'] ?? ''}',
      phoneNumber: '${json['phone_number'] ?? ''}',
      email: '${json['email'] ?? ''}',
      suiteNumber: '${json['suite_number'] ?? ''}',
      trackingNumber: '${json['tracking_number'] ?? ''}',
      packageDescription: '${json['package_description'] ?? ''}',
      issueType: '${json['issue_type'] ?? ''}',
      description: '${json['description'] ?? ''}',
      status: '${json['status'] ?? ''}',
      createdAt: '${json['created_at'] ?? ''}',
    );
  }

  static SupportTicket empty() {
    return const SupportTicket(
      id: 0,
      ticketNumber: '',
      fullName: '',
      phoneNumber: '',
      email: '',
      suiteNumber: '',
      trackingNumber: '',
      packageDescription: '',
      issueType: '',
      description: '',
      status: '',
      createdAt: '',
    );
  }
}
