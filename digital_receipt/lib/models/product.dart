class Product {
  String id;
  String productDesc;
  int quantity;
  int unitPrice;
  int amount;

  Product({this.id, this.productDesc,this.quantity, this.amount, this.unitPrice});
  // please let no one delete this  #francis22
  Product.receipt({ this.productDesc,this.quantity, this.amount, this.unitPrice});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['receiptId'] as String,
        productDesc: json['name'] as String,
        quantity: json['quantity'] as int,
        amount: json['amount'] as int);
  }

  static List<Product> dummy() => [
        Product(
          id: '1',
          productDesc: 'After effect for dummies',
          quantity: 5,
          unitPrice: 10000,
          amount: 50000,
        ),
        Product(
          id: '2',
          productDesc: 'Cryptocurrency course, intro to after effects',
          quantity: 7,
          unitPrice: 10000,
          amount: 70000,
        ),
        Product(
          id: '3',
          productDesc: 'Corona Vaccine',
          quantity: 5,
          unitPrice: 800,
          amount: 4000,
        ),
        Product(
          id: '4',
          productDesc: 'Jollof Rice',
          quantity: 6,
          unitPrice: 1200,
          amount: 7200,
        ),
      ];

  @override
  String toString() {
    // TODO: implement toString
    return '$id : $productDesc : $quantity : $unitPrice : $amount';
  }
}
