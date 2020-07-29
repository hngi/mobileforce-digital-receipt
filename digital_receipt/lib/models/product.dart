class Product {
  String id;
  String productDesc;
  double quantity;
  double unitPrice;
  String categoryName;
  double amount;
  double tax;
  double discount;
  String unit;

  Product(
      {this.id,
      this.productDesc,
      this.quantity,
      this.amount,
      this.categoryName,
      this.unitPrice,
      this.tax,
      this.discount,
      this.unit});
  // please let no one delete this  #francis22
  Product.receipt(
      {this.productDesc,
      this.quantity,
      this.amount,
      this.unitPrice,
      this.tax,
      this.discount});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        // End point returns id as an int!
        id: json['id'].toString(),
        productDesc: json['name'] as String,
        quantity: json['quantity']?.toDouble(),
        unitPrice: (json['unit_price']?.toDouble()),
        amount: json['amount']?.toDouble(),
        tax: json['tax_amount'],
        categoryName: json['category_name'],
        discount: double.parse(json['discount']),
        unit: json['discount']);
  }

  Map<String, dynamic> toJson() => {
        "name": productDesc,
        "quantity": quantity,
        "unit_price": unitPrice,
        "category_name": categoryName.isNotEmpty ? categoryName : 'kdnfhajdvagdvj',
        "tax_amount": tax,
        "discount": discount,
        "unit": unit
      };

  static List<Product> dummy() => [];

  @override
  String toString() {
    // TODO: implement toString
    return '$id : $productDesc : $quantity : $unitPrice : $amount';
  }
}

class Unit {
  final fullName;
  final singular;
  final plural;

  Unit({this.fullName, this.singular, this.plural});

  getShortName(value) {
    return value > 1 ? plural : singular;
  }
}
