class Product {
  String id;
  String productDesc;
  double quantity;
  double unitPrice;
  double amount;
  double tax;
  double discount;

  Product(
      {this.id, this.productDesc, this.quantity, this.amount, this.unitPrice,this.tax,this.discount});
  // please let no one delete this  #francis22
  Product.receipt(
      {this.productDesc, this.quantity, this.amount, this.unitPrice,this.tax,this.discount});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        // End point returns id as an int!
        id: json['id'].toString(),
        productDesc: json['name'] as String,
        quantity: json['quantity'] as double,
        unitPrice: (json['unit_price'] as double),
        amount: json['amount'] as double);
  }
  Map<String, dynamic> toJson() => {
        "name": productDesc,
        "quantity": quantity,
        "unit_price": unitPrice,
      };

  static List<Product> dummy() => [];

  @override
  String toString() {
    // TODO: implement toString
    return '$id : $productDesc : $quantity : $unitPrice : $amount';
  }
}
