class Reminder {
  final String id;
  final String receiptNumber;
  final DateTime partPaymentDateTime;
  final bool active;
  final DateTime createdAt;

  Reminder({
    this.id,
    this.receiptNumber,
    this.active,
    this.partPaymentDateTime,
    this.createdAt,
  });

  factory Reminder.fromJson(Map<String, dynamic> json) => Reminder(
        id: json['id'],
        receiptNumber: json['receipt_number'],
        active: json['active'],
        partPaymentDateTime: DateTime.tryParse(json['partPaymentDateTime'] as String),
        createdAt: DateTime.tryParse(json['created_at'] as String),
      );
}
