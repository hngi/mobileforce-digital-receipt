class Reminder {
  final String id;
  final String customerName;
  final String receiptNumber;
  final DateTime partPaymentDateTime;
  final bool active;
  final double total;
  final DateTime createdAt;

  Reminder({
    this.id,
    this.customerName,
    this.receiptNumber,
    this.active,
    this.total,
    this.partPaymentDateTime,
    this.createdAt,
  });

  factory Reminder.fromJson(Map<String, dynamic> json) => Reminder(
        id: json['id'],
        customerName: json['customer']['name'],
        receiptNumber: json['receipt_number'],
        active: json['active'],
        total: json['total'],
        partPaymentDateTime:
            DateTime.tryParse(json['partPaymentDateTime'] as String),
        createdAt: DateTime.tryParse(json['created_at'] as String),
      );
}

List<Reminder> formatReminderResponse(Map<String, dynamic> json) {
  List<Reminder> results = [];

  if (json['data'] != null) {
    json['data'].forEach((data) {
      print(data['partPayment']);
      if ((data['partPayment'] as bool)) {
        print('data $data');
        results.add(new Reminder.fromJson(data));
      }
    });
  }

  return results;
}
