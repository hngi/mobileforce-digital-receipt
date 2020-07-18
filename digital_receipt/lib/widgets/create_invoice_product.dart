import 'package:digital_receipt/models/invoice.dart';
import 'package:digital_receipt/models/product.dart';
import 'package:digital_receipt/screens/invoice_page.dart';
import 'package:digital_receipt/screens/invoice_screen.dart';
import 'package:digital_receipt/widgets/app_textfield.dart';
import 'package:digital_receipt/widgets/date_time_input_textField.dart';
import 'package:digital_receipt/widgets/product_detail.dart';
import 'package:digital_receipt/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class InvoiceProduct extends StatefulWidget {
  @override
  _InvoiceProductState createState() => _InvoiceProductState();
}

class _InvoiceProductState extends State<InvoiceProduct> {

  TextEditingController _dateTextController = TextEditingController();
  TextEditingController _receiptNumberController = TextEditingController();

  bool _partPayment = false;

  List<Product> products = Product.dummy();


  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  final _time = TextEditingController();
  final _date = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (date != null && time != null) {
      _date.text = DateFormat('dd-MM-yyyy').format(date);
      _time.text = time.format(context);
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0B57A7),
        title: Text(
          'Create an Invoice',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
            fontSize: 16,
            //color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 14,
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
              SizedBox(height: 5),
              Text(
                'Provide the details of the product(s) sold',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w300,
                  letterSpacing: 0.3,
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'Add invoice number',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.3,
                  fontSize: 13,
                  color: Color.fromRGBO(0, 0, 0, 0.6),
                ),
              ),
              SizedBox(height: 5),
              AppTextFieldForm(
                controller: _receiptNumberController,
              ),
              SizedBox(
                height: 12,
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
              ),
              SizedBox(height: 5),
              DateTimeInputTextField(
                  controller: _dateTextController,
                  onTap: () async {
                    final DateTime picked = await showDatePicker(
                      context: context,
                      initialDate: date,
                      firstDate: date.add(Duration(days: -20)),
                      lastDate: date.add(Duration(days: 365)),
                    );

                    if (picked != null && picked != date) {
                      setState(() {
                        date = picked;
                        print(DateTime.now());
                      });
                    }
                  }),
              SizedBox(
                height: 12,
              ),
              Text(
                'Due Date',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.3,
                  fontSize: 13,
                  color: Color.fromRGBO(0, 0, 0, 0.6),
                ),
              ),
              SizedBox(height: 5),
              DateTimeInputTextField(
                  controller: _dateTextController,
                  onTap: () async {
                    final DateTime picked = await showDatePicker(
                      context: context,
                      initialDate: date,
                      firstDate: date.add(Duration(days: -20)),
                      lastDate: date.add(Duration(days: 365)),
                    );

                    if (picked != null && picked != date) {
                      setState(() {
                        date = picked;
                        print(DateTime.now());
                      });
                    }
                  }),
              SizedBox(
                height: 44,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: FlatButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) => ProductDetail(
                        onSubmit: (product, {index}) {
                          setState(() {
                            products.add(product);
                          });
                        },
                      ),
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,

                      //barrierColor: Colors.red
                    );
                  },
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Color(0xFF25CCB3), width: 1.5),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Add product item',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.normal,
                          letterSpacing: 0.3,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.add,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              products.length != 0
                  ? Text(
                'Product item/s',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.3,
                  fontSize: 16,
                  color: Colors.black,
                ),
              )
                  : SizedBox.shrink(),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Product thisProduct = products[index];
                    return Dismissible(
                      onDismissed: (direction) {
                        setState(() {
                          products.removeAt(index);
                        });
                        Scaffold.of(context).showSnackBar(SnackBar(
                            content:
                            Text("${thisProduct.productDesc} dismissed")));
                      },
                      key: Key(thisProduct.id),
                      child: ProductItem(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            builder: (BuildContext context) => ProductDetail(
                              product: thisProduct,
                              onSubmit: (product) {
                                setState(() {
                                  products[index] = product;
                                  Navigator.pop(context);
                                });
                              },
                            ),
                          );
                        },
                        title: thisProduct.productDesc,
                        amount: Provider.of<Invoice>(context, listen: false)
                            .getCurrency()
                            .currencySymbol +
                            '${thisProduct.amount}',
                        index: index,
                      ),
                    );
                  }),
              /* Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Part payment',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.normal,
                    letterSpacing: 0.3,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                Switch(
                  value: Provider.of<Receipt>(context, listen: false)
                      .enablePartPayment(),
                  onChanged: (val) {
                    setState(() {
                      _partPayment = val;
                      Provider.of<Receipt>(context, listen: false)
                          .togglPartPayment();
                    });
                  },
                ),
              ],
            ), */
              _partPayment
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Text(
                      'Set reminder for payment completion',
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
                    height: 22,
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
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    readOnly: true,
                    controller: _date,
                    onTap: () async {
                      final DateTime datePicked = await showDatePicker(
                          context: context,
                          initialDate: date,
                          firstDate: date.add(Duration(days: -5)),
                          lastDate: date.add(Duration(days: 365)));

                      if (datePicked != null && datePicked != date) {
                        setState(() {
                          date = datePicked;

                          print(date);
                        });
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Color(0xFFC8C8C8),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(),
                      //hintText: hintText,
                      hintStyle: TextStyle(
                        color: Color(0xFF979797),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Text(
                    'Time',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0.3,
                      fontSize: 15,
                      color: Color.fromRGBO(0, 0, 0, 0.6),
                    ),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    readOnly: true,
                    controller: _time,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Color(0xFFC8C8C8),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(),
                      //hintText: hintText,
                      hintStyle: TextStyle(
                        color: Color(0xFF979797),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    onTap: () async {
                      final TimeOfDay timePicked = await showTimePicker(
                          context: context, initialTime: time);
                      if (timePicked != null && timePicked != time) {
                        setState(() {
                          time = timePicked;
                          time.format(context);
                          print(time);
                        });
                      }
                    },
                  ),
                ],
              )
                  : SizedBox.shrink(),
              SizedBox(
                height: 55,
              ),
              SubmitButton(
                onPressed: () {
//                  if (products.length == 0) {
//                    Fluttertoast.showToast(
//                      msg:
//                      "You need to add at least a product before you can proceed!",
//                      fontSize: 12,
//                      toastLength: Toast.LENGTH_LONG,
//                      backgroundColor: Colors.red,
//                    );
//                  } else {
//                    num sum = 0;
//                    for (Product e in products) {
//                      sum += e.amount;
//                    }
//                    print("sum: $sum");
//
//                    Provider.of<Invoice>(context, listen: false).setTotal(sum);
//                    Provider.of<Invoice>(context, listen: false)
//                        .setReminderTime(time);
//                    Provider.of<Invoice>(context, listen: false)
//                        .setReminderDate(date);
//                    Provider.of<Invoice>(context, listen: false)
//                        .setProducts(products);
//                    //widget.carouselController.animateToPage(2);
//                  }
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => InvoiceScreen()));
                },
                title: 'Generate Invoice',
                backgroundColor: Color(0xFF0B57A7),
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
