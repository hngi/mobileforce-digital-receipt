import 'package:digital_receipt/models/product.dart';
import 'package:flutter/material.dart';
import '../widgets/ProductList.dart';
import '../widgets/BorderButton.dart';
import '../widgets/create_new_product.dart';






class ProductInformation extends StatefulWidget {
  @override
  _ProductInformationState createState() => _ProductInformationState();
}

class _ProductInformationState extends State<ProductInformation> {
 bool flagPartPayment = false;
 DateTime _pickedDate;
 TimeOfDay _pickedTime;
 Widget paymentReminder;
 

    List<Product> items = [
    Product(id: '1', productDesc: 'After effects for dummies', amount: 1000),
    Product(id: '2', productDesc: 'Crtyptotrading course', amount: 1000),
    Product(id: '3', productDesc: 'Udemy courses', amount: 1000),
  ];

  createProduct(Product newProduct){
    final newItems = items;
    newItems.add(newProduct);

    setState(() {
      items = newItems;
    });
    
  }

 void addNewProduct(BuildContext ctx, Function fxn){
   showModalBottomSheet(context: ctx, builder: (_){
     return CreateNewProduct(createProducts: fxn,);
   },
   shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
        )
   );
 }

 void _presentDatePicker(BuildContext context){
   showDatePicker(
     context: context, 
     initialDate: DateTime.now(),
     firstDate: DateTime(1990), 
     lastDate: DateTime.now()
     ).then((val){
       if(val == null){
         return;
       }
       setState(() {
         _pickedDate = val;
       });
     });
 }

 void _presentTimePicker(BuildContext context){
   showTimePicker(
     context: context, 
     initialTime: TimeOfDay.now()).then((value){
       if(value == null){
         return;
       }
       setState((){
       _pickedTime = value;
       });
     });
 }



  @override
  Widget build(BuildContext context) {

    paymentReminder = !flagPartPayment ? SizedBox(height: 10,):
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
      SizedBox(height: 10,),
              Center(
                child: Text(
                  'Set reminder for payment completion', 
                 style: TextStyle(
                  color: Colors.black38,
                  wordSpacing: 5,
                  fontSize: 15, 
                  fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
            SizedBox(height: 20,),
              Text(
                'Date', 
              style: TextStyle(
                color: Colors.grey[700],
                wordSpacing: 1.5,
                fontSize: 15, 
                fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5) ,
                  border: Border.all(
                    color: Colors.grey[300],
                    width: 2
                  ),
                  
                ),
                child: ListTile(
                  title: _pickedDate == null ? Text('') : Text(_pickedDate.toString().substring(0,10)),
                  onTap: () => _presentDatePicker(context)
                ),
              ),
            SizedBox(height: 20,),
              Text(
                'Time', 
              style: TextStyle(
                color: Colors.grey[700],
                wordSpacing: 1.5,
                fontSize: 15, 
                fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5) ,
                  border: Border.all(
                    color: Colors.grey[300],
                    width: 2
                  ),
                  
                ),
                child: ListTile(
                  title: _pickedTime == null ? Text('') : Text(_pickedTime.toString().substring(10,15)),
                  onTap: () => _presentTimePicker(context)
                ),
              ),
              SizedBox(height: 20,),
    ],);
    
    return Scaffold(
      backgroundColor: Color(0xFFF2F8FF),
      appBar: AppBar(title: Text('Create Receipt'),),
          body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              SizedBox(height: 20,),
              Text(
                'Product item information', 
                style: TextStyle(
                wordSpacing: 5,
                letterSpacing: 2,
                fontSize: 30, 
                fontWeight: FontWeight.w600
                ),
              ),
              SizedBox(height: 5,),
              Text('Provide the details for the product sold', 
              style: TextStyle(
                color: Colors.black38,
                wordSpacing: 5,
                fontSize: 15, 
                fontWeight: FontWeight.w600),
              ),
               SizedBox(height: 20,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children:<Widget>[
                   Container(
                     width: 25,
                     height: 2,
                     color: Colors.grey[300],
                   ),
                   SizedBox(width: 10,),
                   Container(
                     width: 25,
                     height: 2,
                     color: Color(0xFF25CCB3),
                   ),
                   SizedBox(width: 10,),
                   Container(
                     width: 25,
                     height: 2,
                     color: Colors.grey[300],
                   ),
                 ]
               ),
               SizedBox(height: 20,),
             BorderedButton(
               title: 'Add Product Item',
               icon: Icon(Icons.add),
               onpress: () => addNewProduct(context, createProduct),
             ),
             SizedBox(height: 30,),
             BorderedButton(
               title: 'Upload .CSV file',
               icon: Icon(Icons.file_upload),
               onpress: () => print('add product fnx'),
             ),
             SizedBox(height: 10,),
              Text(
                'For bulk entry you can upload your csv file contianing the product information', 
              style: TextStyle(
                color: Colors.black38,
                wordSpacing: 5,
                fontSize: 15, 
                fontWeight: FontWeight.w600
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20,),
              Text(
                'Product item/s',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20,),
              Container(height: 190,child: ProductDisplay(items: items,)),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                Text(
                  'Part payment',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Switch(
                  activeColor: Color(0xFF25CCB3),
                  value: flagPartPayment, 
                  onChanged: (_) => {
                    setState((){flagPartPayment = !flagPartPayment;})
                  },
                ),
                ],
             ),
            SizedBox(height: 20,),
             paymentReminder,
              SizedBox(height: 20,),
              Container(
                width: double.infinity,
                child: Card(
                 color: Color(0xFF226EBE,),
                child: FlatButton(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  onPressed: (){
                    Navigator.of(context).pop();
                  }, 
                  child: Text('Next', style: TextStyle(color: Colors.white, fontSize: 18),),
                 
                  
                  ),
                  ),
              ),
               SizedBox(height: 20,),
            ],),
      ),
    );
  }
}

