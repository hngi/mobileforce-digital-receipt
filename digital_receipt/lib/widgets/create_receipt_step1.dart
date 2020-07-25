import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:digital_receipt/models/inventory.dart';
import 'package:digital_receipt/models/product.dart';
import 'package:digital_receipt/models/receipt.dart';
import 'package:digital_receipt/screens/create_receipt_page.dart';
import 'package:digital_receipt/screens/no_internet_connection.dart';
import '../services/shared_preference_service.dart';
import 'package:digital_receipt/services/CarouselIndex.dart';
import 'package:digital_receipt/services/api_service.dart';
import 'package:digital_receipt/utils/connected.dart';
import 'package:digital_receipt/utils/receipt_util.dart';
import 'package:digital_receipt/widgets/app_text_form_field.dart';
import 'package:digital_receipt/widgets/date_time_input_textField.dart';
import 'package:digital_receipt/widgets/product_detail.dart';
import 'package:digital_receipt/widgets/app_solid_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
import 'contact_card.dart';

class CreateReceiptStep1 extends StatefulWidget {
  const CreateReceiptStep1(
      {this.carouselController,
      this.carouselIndex,
      this.issuedCustomerReceipt});

  final CarouselController carouselController;
  final CarouselIndex carouselIndex;
  final Receipt issuedCustomerReceipt;

  @override
  _CreateReceiptStep1State createState() => _CreateReceiptStep1State();
}

class _CreateReceiptStep1State extends State<CreateReceiptStep1> {
  bool _partPayment = false;
  DateTime dateToSend;
  Map<String, dynamic> temp = {
    '0': DateTime.now().year,
    '1': DateTime.now().month,
    '2': DateTime.now().day,
  };

  String currency = '';
  List<Product> products = Product.dummy();

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  final _timeController = TextEditingController();
  final _dateController = TextEditingController();

  getInventories() async {
    currency = await SharedPreferenceService().getStringValuesSF('Currency');
    try {
      Provider.of<Inventory>(context, listen: false).setInventoryList =
          await ApiService().getAllInventories();
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getInventories();
    if (widget.issuedCustomerReceipt != null) {
      updateContents();
    }
    super.initState();
  }

  updateContents() {
    widget.issuedCustomerReceipt.products.forEach((product) {
      products.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (date != null && time != null) {
      _dateController.text = DateFormat('dd-MM-yyyy').format(date);
      _timeController.text = time.format(context);
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 14,
            ),
            Text('Product item information',
                style: Theme.of(context).textTheme.headline5),
            SizedBox(
              height: 5,
            ),
            Text(
              'Provide the details of the product sold',
              style: Theme.of(context).textTheme.subtitle2,
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: map<Widget>([0, 1, 2, 3], (index, url) {
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
                          index != 3 ? SizedBox(width: 10) : SizedBox.shrink()
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
            SizedBox(
              height: 24,
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
                    side: BorderSide(
                        color: Theme.of(context).accentColor, width: 1.5),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Add product item',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.add,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 29),
            SizedBox(
              height: 20,
            ),
            products.length != 0
                ? Text(
                    'Product item/s',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6,
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
                      amount:currency +
                          '${Utils.formatNumber(thisProduct.amount) ?? Utils.formatNumber(thisProduct.unitPrice * thisProduct.quantity)}',
                      // '${}',
                      index: index,
                    ),
                  );
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Part payment',
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                ),
                Switch(
                  value: _partPayment,
                  onChanged: (val) {
                    setState(() {
                      _partPayment = val;
                    });
                    Provider.of<Receipt>(context, listen: false).partPayment =
                        val;
                  },
                ),
              ],
            ),
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
                        ),
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      Text(
                        'Date',
                      ),
                      SizedBox(height: 5),
                      DateTimeInputTextField(
                        controller: _dateController,
                        onTap: () async {
                          final DateTime datePicked = await showDatePicker(
                              context: context,
                              initialDate: date,
                              firstDate: date.add(Duration(days: -5)),
                              lastDate: date.add(Duration(days: 365)));

                          if (datePicked != null && datePicked != date) {
                            setState(() {
                              date = datePicked;
                              temp = {
                                '0': date.year,
                                '1': date.month,
                                '2': date.day
                              };
                            });
                            /*  print(
                                '${date.year}-${date.month}-${date.day} % $date');
                            print(DateTime.now()); */
                          }
                        },
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      Text(
                        'Time',
                      ),
                      SizedBox(height: 5),
                      DateTimeInputTextField(
                        controller: _timeController,
                        onTap: () async {
                          final TimeOfDay timePicked = await showTimePicker(
                              context: context, initialTime: time);
                          if (timePicked != null && timePicked != time) {
                            setState(() {
                              time = timePicked;
                              time.format(context);
                              temp['3'] = time.hour;
                              temp['4'] = time.minute;
                              dateToSend = DateTime(
                                temp['0'],
                                temp['1'],
                                temp['2'],
                                temp['3'],
                                temp['4'],
                              );
                            });

                            Provider.of<Receipt>(context, listen: false)
                                .setReminderDate(dateToSend);
                            print(Provider.of<Receipt>(context, listen: false)
                                .reminderDate);
                            print(Provider.of<Receipt>(context, listen: false)
                                .partPayment);
                          }
                        },
                      ),
                    ],
                  )
                : SizedBox.shrink(),
            SizedBox(
              height: 55,
            ),
            AppSolidButton(
              onPressed: () {
                if (products.length == 0) {
                  Fluttertoast.showToast(
                    msg:
                        "You need to add at least a product before you can proceed!",
                    fontSize: 12,
                    toastLength: Toast.LENGTH_LONG,
                    backgroundColor: Colors.red,
                  );
                } else {
                  num sum = 0;
                  for (Product e in products) {
                    sum += e.amount ?? (e.unitPrice * e.quantity);
                  }
                  print("sum: $sum");

                  Provider.of<Receipt>(context, listen: false)
                      .setTotal(sum);
                  Provider.of<Receipt>(context, listen: false)
                      .setReminderTime(time);
                  Provider.of<Receipt>(context, listen: false)
                      .setReminderDate(dateToSend ?? date);
                  Provider.of<Receipt>(context, listen: false)
                      .setProducts(products);
                  widget.carouselController.animateToPage(2);
                }
              },
              text: 'Next',
              backgroundColor: Theme.of(context).buttonColor,
            ),
          ],
        ),
      ),
    );
  }
}
