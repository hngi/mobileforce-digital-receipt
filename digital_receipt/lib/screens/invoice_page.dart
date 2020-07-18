import 'package:digital_receipt/widgets/create_invoice_product.dart';
import 'package:flutter/material.dart';
import 'package:digital_receipt/models/currency.dart';
import 'package:digital_receipt/models/customer.dart';
import 'package:digital_receipt/widgets/app_textfield.dart';
import 'package:digital_receipt/widgets/submit_button.dart';


import 'package:digital_receipt/widgets/currency_dropdown.dart';


class CreateInvoicePage extends StatefulWidget {
  @override
  _CreateInvoicePageState createState() => _CreateInvoicePageState();
}

class _CreateInvoicePageState extends State<CreateInvoicePage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _pNumberController = TextEditingController();

  Customer selectedCustomer;
  Currency selectedCurrency = Currency.currencyList().elementAt(0);

  // Needed to decide weather to create a new customer or not
  List<Customer> customers = [];

  List<Currency> currency = Currency.currencyList();

  String _customerName, _customerEmail, _customerAddress, _customerPNumber;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F8FF),
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 14,
                ),
                Text(
                  'Create an Invoice',
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
                  'Lets get started',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.normal,
                    letterSpacing: 0.3,
                    fontSize: 14,
                    color: Color.fromRGBO(0, 0, 0, 0.6),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  'Customer information',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3,
                    fontSize: 16,
                    color: Color(0xFF000000),
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  'Customer name',
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
                  controller: _nameController,
                  validator: (value) {
                    if (selectedCustomer == null) {
                      if (value.isEmpty) {
                        return "Enter customer name";
                      }
                      if (value.length < 6) {
                        return 'customer name must be more than 8 characters';
                      }
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _customerName = value;
                    });
                  },
                ),
                SizedBox(height: 22),
                Text(
                  'Email address',
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
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  validator: (value) {
                    if (selectedCustomer == null) {
                      if (value.isEmpty) {
                        return "Enter Email Address";
                      }
                      Pattern pattern =
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regex = new RegExp(pattern);
                      if (!regex.hasMatch(value)) return 'Enter Valid Email';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _customerEmail = value;
                    });
                  },
                ),
                SizedBox(
                  height: 22,
                ),
                Text(
                  'Address',
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
                  controller: _addressController,
                  validator: (value) {
                    if (selectedCustomer == null) {
                      if (value.isEmpty) {
                        return "Enter Address";
                      }

                      if (value.length < 8) {
                        return 'Address must be more than 8 characters';
                      }
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _customerAddress = value;
                    });
                  },
                ),
                SizedBox(
                  height: 22,
                ),
                Text(
                  'Phone number',
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
                  keyboardType: TextInputType.number,
                  controller: _pNumberController,
                  validator: (value) {
                    if (selectedCustomer == null) {
                      if (value.isEmpty) {
                        return "Enter Phone number";
                      }

                      if (value.length < 8) {
                        return 'Phone number must be more than 8 characters';
                      }
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _customerPNumber = value;
                    });
                  },
                ),
                SizedBox(
                  height: 45,
                ),
                GestureDetector(
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CurrencyDropdown(
                          currency: currency,
                          onSubmit: (currency) {
                            setState(() {
                              selectedCurrency = currency;
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
                          selectedCurrency != null
                              ? selectedCurrency.currencyName
                              : 'Select Currency',
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
                  height: 45,
                ),
                SubmitButton(
                  title: 'Next',
                  textColor: Colors.white,
                  backgroundColor: Color(0xFF0B57A7),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => InvoiceProduct()));
//                    if (_formKey.currentState.validate()) {
//                      _formKey.currentState.save();
//
//                      Provider.of<Receipt>(context, listen: false)
//                          .setCategory(selectedCategory);
//                      Provider.of<Receipt>(context, listen: false)
//                          .setCurrency(selectedCurrency);
//
//                      if (selectedCustomer == null) {
//                        Provider.of<Receipt>(context, listen: false).setCustomer(
//                          Customer(
//                            name: _customerName,
//                            email: _customerEmail,
//                            phoneNumber: _customerPNumber,
//                            address: _customerAddress,
//                          ),
//                        );
//                      } else {
//                        Provider.of<Receipt>(context, listen: false)
//                            .setCustomer(selectedCustomer);
//                      }
//
//                      print(Provider.of<Receipt>(context, listen: false));
//                      widget.carouselController.animateToPage(1);
//                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _pNumberController.dispose();
    super.dispose();
  }
}

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key key,
    this.title,
    this.amount,
    this.index,
    this.onTap,
  }) : super(key: key);

  final String title;
  final String amount;
  final int index;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          child: Ink(
            color: Color(0xFFEBF1F8),
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: InkWell(
                onTap: onTap,
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.normal,
                            letterSpacing: 0.3,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          softWrap: true,
                        ),
                      ),
                      Text(
                        amount,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.normal,
                          letterSpacing: 0.3,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        index == 0 ? SizedBox(height: 5) : SizedBox.shrink(),
        index == 0
            ? Text(
          'Tap to edit. Swipe to delete',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.normal,
            letterSpacing: 0.3,
            fontSize: 14,
            color: Color.fromRGBO(0, 0, 0, 0.6),
          ),
        )
            : SizedBox.shrink(),
        SizedBox(height: 25),
      ],
    );
  }
}
