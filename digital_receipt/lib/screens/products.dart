import 'package:carousel_slider/carousel_controller.dart';
import 'package:digital_receipt/models/product.dart';
import 'package:digital_receipt/services/CarouselIndex.dart';
import 'package:flutter/material.dart';
import '../widgets/ProductList.dart';
import '../widgets/BorderButton.dart';
import '../widgets/create_new_product.dart';

class ProductInformation extends StatefulWidget {
  final CarouselController carouselController;
  final CarouselIndex carouselIndex;

  const ProductInformation(
      {Key key, this.carouselController, this.carouselIndex})
      : super(key: key);
  @override
  _ProductInformationState createState() => _ProductInformationState();
}

class _ProductInformationState extends State<ProductInformation> {
  bool flagPartPayment = false;
  DateTime _pickedDate;
  TimeOfDay _pickedTime;
  Widget paymentReminder;

  List<Product> items = [
    Product(
        id: '1',
        productDesc: 'After effects for dummies',
        quantity: 100,
        unitPrice: 10,
        amount: 1000),
    Product(
        id: '2',
        productDesc: 'Crtyptotrading course',
        quantity: 200,
        unitPrice: 10,
        amount: 2000),
    Product(
        id: '3',
        productDesc: 'Udemy courses',
        quantity: 300,
        unitPrice: 10,
        amount: 3000),
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  createProduct(Product newProduct) {
    final newItems = items;
    newItems.add(newProduct);

    setState(() {
      items = newItems;
    });
  }

  void updateProduct(
      {int index, String name, int amount, int quantity, int unit}) {
    var newItem = items;
    print('amount: $amount , quant: $quantity and unit: $unit');
    double newQuant = quantity <= 0 ? newItem[index].quantity : quantity;
    double newUnit = unit <= 0 ? newItem[index].unitPrice : unit;
    double newAmnt = newQuant * newUnit;
    print('amount: $newAmnt , quant: $newQuant and unit: $newUnit');
    newItem[index].productDesc = name == '' ? newItem[index].productDesc : name;
    newItem[index].amount = newAmnt.round() as double;
    newItem[index].quantity = newQuant;
    newItem[index].unitPrice = newUnit;

    setState(() {
      items = newItem;
    });
  }

  void addNewProduct(
    BuildContext ctx,
    Function fxn,
  ) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return CreateNewProduct(
            createProducts: fxn,
            isUpdate: false,
            products: [],
            index: 0,
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
        ));
  }

  void updateOldProductSheet(BuildContext ctx, index) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return CreateNewProduct(
              createProducts: updateProduct,
              isUpdate: true,
              products: items,
              index: index);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
        ));
  }

  void _presentDatePicker(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1990),
            lastDate: DateTime.now())
        .then((val) {
      if (val == null) {
        return;
      }
      setState(() {
        _pickedDate = val;
      });
    });
  }

  void _presentTimePicker(BuildContext context) {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _pickedTime = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    paymentReminder = !flagPartPayment
        ? SizedBox(
            height: 10,
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  'Set reminder for payment completion',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.normal,
                    letterSpacing: 0.3,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Date',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.3,
                  fontSize: 13,
                  color: Color.fromRGBO(0, 0, 0, 0.6),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black45, width: 2),
                ),
                child: ListTile(
                    title: _pickedDate == null
                        ? Text('')
                        : Text(_pickedDate.toString().substring(0, 10)),
                    onTap: () => _presentDatePicker(context)),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Time',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.3,
                  fontSize: 13,
                  color: Color.fromRGBO(0, 0, 0, 0.6),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black45, width: 2),
                ),
                child: ListTile(
                    title: _pickedTime == null
                        ? Text('')
                        : Text(_pickedTime.toString().substring(10, 15)),
                    onTap: () => _presentTimePicker(context)),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );

    return Scaffold(
      backgroundColor: Color(0xFFF2F8FF),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text(
              'Product item information',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
                fontSize: 22,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Provide the details of the product sold',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w300,
                letterSpacing: 0.3,
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: map<Widget>([1, 1, 2], (index, url) {
                    print(index);
                    return GestureDetector(
                      onTap: () {
                        widget.carouselController.animateToPage(index);
                      },
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 2,
                            width: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: widget.carouselIndex.index == index
                                    ? Color(0xFF25CCB3)
                                    : Color.fromRGBO(0, 0, 0, 0.12),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 3),
                                      blurRadius: 6,
                                      color: Color.fromRGBO(0, 0, 0, 0.16))
                                ]),
                          ),
                          index != 2 ? SizedBox(width: 10) : SizedBox.shrink()
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            BorderedButton(
              title: 'Add Product Item',
              icon: Icon(Icons.add),
              onpress: () => addNewProduct(context, createProduct),
            ),
            /*  SizedBox(height: 30,),
             BorderedButton(
               title: 'Upload .CSV file',
               icon: Icon(Icons.file_upload),
               onpress: () => print('add product fnx'),
             ), */
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                'For bulk entry you can upload a .csv file of all your product information',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.3,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Product item/s',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                height: 190,
                child: ProductDisplay(
                  items: items,
                  showBottomSheet: updateOldProductSheet,
                )),
            SizedBox(
              height: 20,
            ),
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
                    setState(() {
                      flagPartPayment = !flagPartPayment;
                    })
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            paymentReminder,
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: Card(
                color: Color(0xFF0B57A7),
                child: FlatButton(
                  // padding: EdgeInsets.only(top: 20, bottom: 20),
                  onPressed: () => widget.carouselController.animateToPage(2),
                  child: Text(
                    'Next',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
