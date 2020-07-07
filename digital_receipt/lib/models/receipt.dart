enum ReceiptCategory { WHATSAPP, INSTAGRAM, TWITTER }

class Receipt {
  final String receiptNo;
  final String issuedDate;
  final String customerName;
  final String description;
  final ReceiptCategory category;
  final String totalAmount;

  Receipt({
    this.receiptNo,
    this.issuedDate,
    this.customerName,
    this.description,
    this.category,
    this.totalAmount,
  });

  
  factory Receipt.fromJson(Map<String, dynamic> json) => Receipt(
        receiptNo: json["receipt_number"] == null ? null : json["receipt_number"],
        issuedDate: json["date"] == null ? null : json["date"],
        customerName: json["customer"]["name"] == null ? null : json["customer"]["name"],
        category: json["category"] == null ? null : json["category"],
        totalAmount: json["total"] == null ? null : json["total"].toString(),
        
    );
}

List<Receipt> dummyReceiptList = [
  Receipt(
    receiptNo: '0020',
    issuedDate: '12-05-2020',
    customerName: 'Carole Johnson',
    description: 'Introduction to Numeritical analysis sales',
    totalAmount: '83,000',
    category: ReceiptCategory.WHATSAPP,
  ),
  Receipt(
    receiptNo: '0021',
    issuedDate: '11-04-2020',
    customerName: 'Carole Froschauer',
    description: 'Cryptocurrency course, intro to after effects',
    totalAmount: '80,000',
    category: ReceiptCategory.WHATSAPP,
  ),
  Receipt(
    receiptNo: '0023',
    issuedDate: '21-07-2020',
    customerName: 'Paul Walker',
    description: 'Introduction to Programming book sales',
    totalAmount: '6,000',
    category: ReceiptCategory.INSTAGRAM,
  ),
  Receipt(
    receiptNo: '0035',
    issuedDate: '11-04-2020',
    customerName: 'Dwayne Johnson',
    description: 'Cryptocurrency course, intro to after effects',
    totalAmount: '40,000',
    category: ReceiptCategory.INSTAGRAM,
  ),
  Receipt(
    receiptNo: '0037',
    issuedDate: '29-12-2020',
    customerName: 'Johnson Stones',
    description: 'Introduction to Numeritical analysis sales',
    totalAmount: '33,000',
    category: ReceiptCategory.TWITTER,
  ),
  Receipt(
    receiptNo: '0021',
    issuedDate: '11-04-2020',
    customerName: 'Kelvin Hart',
    description: 'Cryptocurrency course, intro to after effects',
    totalAmount: '44,000',
    category: ReceiptCategory.TWITTER,
  ),
];
