import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:digital_receipt/models/product.dart';
import 'package:digital_receipt/models/receipt.dart';
import 'package:digital_receipt/screens/create_receipt_page.dart';
import 'package:digital_receipt/screens/no_internet_connection.dart';
import 'package:digital_receipt/services/CarouselIndex.dart';
import 'package:digital_receipt/services/api_service.dart';
import 'package:digital_receipt/utils/connected.dart';
import 'package:digital_receipt/widgets/app_textfield.dart';
import 'package:digital_receipt/widgets/product_detail.dart';
import 'package:digital_receipt/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateReceiptStep1 extends StatefulWidget {
  const CreateReceiptStep1({this.carouselController, this.carouselIndex});
  final CarouselController carouselController;
  final CarouselIndex carouselIndex;

  @override
  _CreateReceiptStep1State createState() => _CreateReceiptStep1State();
}

class _CreateReceiptStep1State extends State<CreateReceiptStep1> {
  bool _partPayment = false;

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

  final _time = TextEditingController();
  final _date = TextEditingController();

  setCustomer() async {
    dynamic res = await ApiService().getAllCustomers();
    res = res.map(
      (e) {
        return Customer(
          address: e['address'],
          email: e['email'],
          phoneNumber: e['phoneNumber'],
          name: e['name'],
        );
      },
    );

    Provider.of<Customer>(context, listen: false).setCustomerList =
        List.from(res);

    //res = null;
  }

  @override
  void initState() {
    setCustomer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (date != null && time != null) {
      _date.text = DateFormat('dd-MM-yyyy').format(date);
      _time.text = time.format(context);
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
              height: 24,
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
            SizedBox(height: 29),
            GestureDetector(
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomerDropdown(
                      customers: customers,
                      onSubmit: (customer) {
                        setState(() {
                          selectedCustomer = customer;
                        });
                      },
                    );
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFC8C8C8),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(5.0)),
                padding: EdgeInsets.symmetric(horizontal: 13, vertical: 14),
                child: Row(
                  children: <Widget>[
                    Text(
                      selectedCustomer != null
                          ? selectedCustomer.name
                          : 'Select Customer',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.3,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.arrow_drop_down),
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
                      amount: Provider.of<Receipt>(context, listen: false)
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
                    sum += e.amount;
                  }
                  print("sum: $sum");

                  Provider.of<Receipt>(context, listen: false).setTotal(sum);
                  Provider.of<Receipt>(context, listen: false)
                      .setReminderTime(time);
                  Provider.of<Receipt>(context, listen: false)
                      .setReminderDate(date);
                  Provider.of<Receipt>(context, listen: false)
                      .setProducts(products);
                  widget.carouselController.animateToPage(2);
                }
              },
              title: 'Next',
              backgroundColor: Color(0xFF0B57A7),
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomerDropdown extends StatelessWidget {
  const CustomerDropdown({
    this.customers,
    this.onSubmit,
  });
  final List customers;
  final Function onSubmit;

  @override
  Widget build(BuildContext context) {
    List<Inventory> customers = Provider.of<Customer>(context).customerList;
    return SizedBox(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(
              top: 100,
              bottom: 10,
            ),
            child: Center(
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xFFF2F8FF),
                ),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width - 32,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      onChanged: (val) {
                        //print('jhj');
                        Provider.of<Customer>(context, listen: false)
                            .searchCustomerList(val);
                      },
                      decoration: InputDecoration(
                        hintText: "Search customer",
                        hintStyle: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.38),
                            fontFamily: 'Montserrat'),
                        prefixIcon: IconButton(
                          icon: Icon(Icons.search),
                          color: Color.fromRGBO(0, 0, 0, 0.38),
                          onPressed: () {},
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Color.fromRGBO(0, 0, 0, 0.12),
                            width: 1,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(15),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Color(0xFFC8C8C8),
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    customers.isEmpty
                        ? Expanded(
                            child: Column(
                            children: <Widget>[
                              Expanded(
                                child: kEmpty,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "You have not added any customer!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                  letterSpacing: 0.3,
                                  color: Color.fromRGBO(0, 0, 0, 0.87),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ))
                        : Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: customers.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    onSubmit(customers[index]);
                                    Navigator.pop(context);
                                  },
                                  child: ContactCard(
                                    receiptTitle: customers[index].name,
                                    subtitle: customers[index].phoneNumber,
                                  ),
                                );
                              },
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
