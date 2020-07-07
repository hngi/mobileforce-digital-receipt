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
     Map<String,dynamic> toJson() => {
      "name":productDesc,
      "quantity":quantity,
      "unit_price":unitPrice,
    };
  

  static List<Product> dummy() => [
    
      ];

  @override
  String toString() {
    // TODO: implement toString
    return '$id : $productDesc : $quantity : $unitPrice : $amount';
  }
}
