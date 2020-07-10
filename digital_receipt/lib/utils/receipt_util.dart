import 'package:digital_receipt/models/receipt.dart';

class ReceiptUtil {
  static List<Receipt> sortReceiptByCategory(List<Receipt> receiptList,
      {ReceiptCategory byCategory}) {
    ReceiptCategory _byCategory =
        byCategory != null ? byCategory : ReceiptCategory.WHATSAPP;
    return receiptList
        .where((element) => element.category == _byCategory)
        .toList();
  }

  static List<Receipt> sortReceiptByDate(List<Receipt> receiptList) {
    receiptList.sort((a, b) => a.issuedDate.compareTo(b.issuedDate));
    return receiptList.toList();
  }

  static List<Receipt> sortReceiptByReceiptNo(List<Receipt> receiptList) {
    receiptList.sort((a, b) => a.receiptNo.compareTo(b.receiptNo));
    return receiptList.toList();
  }

  static List<Receipt> filterReceipt(List<Receipt> receiptList, String value) {
    print(value);
    return receiptList
        .where((receipt) =>
            receipt.customerName
                //.replaceAll(new RegExp(r' '), '')
                .toLowerCase()
                .contains(value) ||
            receipt.description
                // .replaceAll(new RegExp(r' '), '')
                .toLowerCase()
                .contains(value))
        .toList();
  }
}
