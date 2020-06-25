import 'package:digital_receipt/models/product.dart';
import 'package:flutter/material.dart';



class CreateNewProduct extends StatefulWidget {
  final Function createProducts;

  const CreateNewProduct({Key key, this.createProducts}) : super(key: key);
  
  @override
  _CreateNewProductState createState() => _CreateNewProductState();
}

class _CreateNewProductState extends State<CreateNewProduct> {
  final _productDesc = TextEditingController();
  final _quantity = TextEditingController();
  final _unitPrice = TextEditingController();


  _submitProduct(){
    final product = _productDesc.text;
    final int quantity = _quantity.text == '' ? 0 :  int.parse(_quantity.text);
    final int unit = _unitPrice.text == '' ? 0 : int.parse(_unitPrice.text);
    final int totalAmount = unit * quantity;
    if(totalAmount <= 0 && (product.isEmpty || product.length <= 5)){
      return;
    }
    final String id = DateTime.now().toString().substring(0,10) + TimeOfDay.now().toString().substring(10,15);

    widget.createProducts(new Product(id: id, productDesc: product, amount: totalAmount));

     Navigator.of(context).pop();

  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
        padding: EdgeInsets.fromLTRB(
        10, 10, 10, 
        MediaQuery.of(context).viewInsets.bottom + 30
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: Navigator.of(context).pop,
                ),
                ),
                SizedBox(height: 20,),
                  Text(
                    'Product Description', 
                  style: TextStyle(
                    color: Colors.grey,
                    wordSpacing: 1.5,
                    fontSize: 15, 
                    fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(5) ,
                      border: Border.all(
                        color: Colors.grey,
                        width: 2
                      ),
                      
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      controller: _productDesc,
                      onFieldSubmitted: (_) => _submitProduct(),
                    ),
                  ),
                SizedBox(height: 20,),
                  Text(
                    'Quantity', 
                  style: TextStyle(
                    color: Colors.grey,
                    wordSpacing: 1.5,
                    fontSize: 15, 
                    fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(5) ,
                      border: Border.all(
                     color: Colors.grey,
                        width: 2
                      ),
                      
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none
                      ),
                      keyboardType: TextInputType.numberWithOptions(),
                      controller: _quantity,
                      onFieldSubmitted: (_) => _submitProduct(),
                    ),
                  ),
                SizedBox(height: 20,),
                  Text(
                    'Unit Price', 
                  style: TextStyle(
                    color: Colors.grey,
                    wordSpacing: 1.5,
                    fontSize: 15, 
                    fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5) ,
                      border: Border.all(
                        color: Colors.grey,
                        width: 2
                      ),
                      
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none
                      ),
                      keyboardType: TextInputType.numberWithOptions(),
                      controller: _unitPrice,
                      onFieldSubmitted: (_) => _submitProduct(),
                    ),
                  ),
                   SizedBox(height: 20,),
              Container(
                width: double.infinity,
                child: Card(
                 color: Color(0xFF226EBE),
                child: FlatButton(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  onPressed: (){
                    _submitProduct();
                  }, 
                  child: Text('Add', style: TextStyle(color: Colors.white, fontSize: 18),),
                 
                  
                  ),
                  ),
              )
          ],
        ),
      ),
    );
  }
}