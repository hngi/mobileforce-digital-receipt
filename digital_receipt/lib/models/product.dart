class Product{
   String id;
   String productDesc;
   int quantity;
   int unitPrice;
   int amount;

  Product({this.id, this.productDesc,this.quantity, this.amount, this.unitPrice});

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      id: json['receiptId'] as String,
      productDesc: json['name'] as String,
      quantity: json['quantity'] as int, 
      amount: json['amount'] as int);
  }

  
}