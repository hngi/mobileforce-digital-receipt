import 'dart:io';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:digital_receipt/widgets/button_loading_indicator.dart';

import 'package:digital_receipt/models/currency.dart';
import 'package:digital_receipt/models/customer.dart';
import 'package:digital_receipt/models/receipt.dart';
import 'package:digital_receipt/services/CarouselIndex.dart';
import 'package:digital_receipt/services/api_service.dart';
import 'package:digital_receipt/widgets/app_text_form_field.dart';
import 'package:digital_receipt/widgets/customer_dropdown.dart';
import 'package:digital_receipt/widgets/contact_dropdown.dart';
import 'package:digital_receipt/widgets/app_solid_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
import 'app_drop_selector.dart';
import 'currency_dropdown.dart';

class CreateReceiptStep0 extends StatefulWidget {
  const CreateReceiptStep0(
      {this.carouselController,
      this.carouselIndex,
      this.issuedCustomerReceipt});

  final CarouselController carouselController;
  final CarouselIndex carouselIndex;
  final Receipt issuedCustomerReceipt;
  @override
  _CreateReceiptStep0State createState() => _CreateReceiptStep0State();
}

class _CreateReceiptStep0State extends State<CreateReceiptStep0> {
  var getContactFromPhone;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _pNumberController = TextEditingController();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _pNumberFocus = FocusNode();
  final FocusNode _switchFocus = FocusNode();

  ReceiptCategory selectedCategory;
  Customer selectedCustomer;
  //Currency selectedCurrency = Currency.currencyList().elementAt(0);

  // Needed to decide weather to create a new customer or not
  List<Customer> customers = [];

  //List<Currency> currency = Currency.currencyList();

  String _customerName, _customerEmail, _customerAddress, _customerPNumber;

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
    if (widget.issuedCustomerReceipt != null) {
      updateContents();
    }
    super.initState();
  }

  updateContents() {
    selectedCategory = widget.issuedCustomerReceipt.category;
    selectedCustomer = widget.issuedCustomerReceipt.customer;
  }

  @override
  Widget build(BuildContext context) {
    bool isPickingContact = false;
    /* Function getContactFromPhone = () async {
      setState(() {
        isPickingContact = true;
      }); */
    /*  if (await FlutterContactPicker.hasPermission()) {
        final PhoneContact contact =
            await FlutterContactPicker.pickPhoneContact();
        setState(() {
          _nameController.text = contact.fullName;
          _pNumberController.text = contact.phoneNumber.number;
        });
      } else {
        final granted = await FlutterContactPicker.requestPermission(); */

    /* setState(() {
        isPickingContact = false;
      });
    }; */
    // SendReceiptService srs = Provider.of<SendReceiptService>(context);
    return SingleChildScrollView(
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
              Text('Create a receipt',
                  style: Theme.of(context).textTheme.headline5),
              SizedBox(
                height: 5,
              ),
              Text(
                'Lets get started',
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
              Text('Category', style: Theme.of(context).textTheme.headline6),
              SizedBox(
                height: 5,
              ),
              Text(
                'This helps you track your sales from different platforms',
                style: Theme.of(context).textTheme.subtitle2,
              ),
              SizedBox(
                height: 15,
              ),
              DropdownButtonFormField(
                hint: Text(
                  'Select category',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.normal),
                ),
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.normal),
                items: [
                  DropdownMenuItem(
                    value: ReceiptCategory.WHATSAPP,
                    child: Text('WhatsApp'),
                  ),
                  DropdownMenuItem(
                    value: ReceiptCategory.INSTAGRAM,
                    child: Text('Instagram'),
                  ),
                  DropdownMenuItem(
                    value: ReceiptCategory.FACEBOOK,
                    child: Text('Facebook'),
                  ),
                  DropdownMenuItem(
                    value: ReceiptCategory.TWITTER,
                    child: Text('Twitter'),
                  ),
                  DropdownMenuItem(
                    value: ReceiptCategory.REDIT,
                    child: Text('Redit'),
                  ),
                  DropdownMenuItem(
                    value: ReceiptCategory.OTHERS,
                    child: Text('Others'),
                  ),
                ],
                validator: (value) {
                  if (value == null) {
                    return "Select a Category";
                  }
                  return null;
                },
                onChanged: (value) {
                  print(value);
                  setState(() {
                    selectedCategory = value;
                    Provider.of<Receipt>(context, listen: false)
                        .setCategory(selectedCategory);
                  });
                },
                value: selectedCategory,
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
                height: 39,
              ),
              Text(
                'Customer information',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'This information is display on the receipt. If the customer is saved, select customer',
                style: Theme.of(context).textTheme.subtitle2,
              ),
              SizedBox(
                height: 10,
              ),
              AppDropSelector(
                text: selectedCustomer != null
                    ? selectedCustomer.name
                    : 'Select Customer',
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomerDropdown(
                        customers: customers,
                        onSubmit: (customer) {
                          setState(() {
                            selectedCustomer = customer;
                            _nameController.text = customer.name;
                            _emailController.text = customer.email;
                            _addressController.text = customer.address;
                            _pNumberController.text = customer.phoneNumber;
                          });
                        },
                      );
                    },
                  );
                },
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'Otherwise, enter customer information',
                style: Theme.of(context).textTheme.subtitle2,
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                'Customer name',
                style: Theme.of(context).textTheme.subtitle2,
              ),
              SizedBox(height: 5),
              AppTextFormField(
                focusNode: _nameFocus,
                textInputAction: TextInputAction.next,
                suffixIcon: IconButton(
                  // focusNode: _nameFocus,
                  icon: Icon(
                    Icons.contacts,
                    color: Theme.of(context)
                        .inputDecorationTheme
                        .enabledBorder
                        .borderSide
                        .color,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => ContactDropdown(
                              onSubmit: (Contact contact) {
                                // selectedCustomer = contact;
                                _nameController.text = contact.displayName;
                                _emailController.text =
                                    contact.emails.toList().isNotEmpty
                                        ? contact.emails?.toList()[0].value
                                        : '';
                                _addressController.text =
                                    contact.postalAddresses.toList().isNotEmpty
                                        ? contact.postalAddresses
                                            ?.toList()[0]
                                            .street
                                        : '';
                                _pNumberController.text =
                                    contact.phones.toList().isNotEmpty
                                        ? contact.phones?.toList()[0].value
                                        : '';
                              },
                            ));
                  },
                ),
                onFieldSubmitted: (value) =>
                    _changeFocus(from: _nameFocus, to: _emailFocus),
                controller: _nameController,
                validator: (value) {
                  if (selectedCustomer == null) {
                    if (value.isEmpty) {
                      return "Enter customer name";
                    }
                    if (value.length < 4) {
                      return 'customer name must be more than 4 characters';
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
                style: Theme.of(context).textTheme.subtitle2,
              ),
              SizedBox(height: 5),
              AppTextFormField(
                focusNode: _emailFocus,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) =>
                    _changeFocus(from: _emailFocus, to: _addressFocus),
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
                style: Theme.of(context).textTheme.subtitle2,
              ),
              SizedBox(height: 5),
              AppTextFormField(
                focusNode: _addressFocus,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) =>
                    _changeFocus(from: _addressFocus, to: _pNumberFocus),
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
                style: Theme.of(context).textTheme.subtitle2,
              ),
              SizedBox(height: 5),
              AppTextFormField(
                focusNode: _pNumberFocus,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) => _pNumberFocus.unfocus(),
                keyboardType: TextInputType.phone,
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
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Save to customer list',
                      style: Theme.of(context).textTheme.headline6.copyWith(
                            fontWeight: FontWeight.normal,
                          )),
                  Switch(
                    focusNode: _switchFocus,
                    value: Provider.of<Receipt>(context, listen: false)
                        .enableSaveCustomer(),
                    onChanged: (val) {
                      setState(() {
                        Provider.of<Receipt>(context, listen: false)
                            .toggleSaveCustomer();
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              /* AppDropSelector(
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
                text: selectedCurrency != null
                    ? selectedCurrency.currencyName
                    : 'Select Currency',
              ),
              SizedBox(
                height: 45,
              ), */
              AppSolidButton(
                text: 'Next',
                backgroundColor: Theme.of(context).buttonColor,
                onPressed: () {
                  FocusScope.of(context).unfocus();

                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();

                    Provider.of<Receipt>(context, listen: false)
                        .setCategory(selectedCategory);
                   /*  Provider.of<Receipt>(context, listen: false)
                        .setCurrency(selectedCurrency); */

                    if (selectedCustomer == null) {
                      Provider.of<Receipt>(context, listen: false).setCustomer(
                        Customer(
                          name: _customerName,
                          email: _customerEmail,
                          phoneNumber: _customerPNumber,
                          address: _customerAddress,
                        ),
                      );
                    } else {
                      Provider.of<Receipt>(context, listen: false)
                          .setCustomer(selectedCustomer);
                    }

                    print(Provider.of<Receipt>(context, listen: false));
                    widget.carouselController.nextPage();
                  }
                },
              )
            ],
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
    _nameFocus.dispose();
    _emailFocus.dispose();
    _addressFocus.dispose();
    _pNumberFocus.dispose();
    _switchFocus.dispose();
    super.dispose();
  }

  void _changeFocus({FocusNode from, FocusNode to}) {
    from.unfocus();
    FocusScope.of(context).requestFocus(to);
  }

  void _selectCustomerDropdown(BuildContext context,
      {Function(Customer) onSubmit}) {
    Dialog simpleDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            TextFormField(
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
            Expanded(
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
    );
    showDialog(
        context: context, builder: (BuildContext context) => simpleDialog);
  }

  Widget ContactCard({String receiptNo, total, date, receiptTitle, subtitle}) {
    return SizedBox(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFF539C30),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              margin: EdgeInsets.only(left: 5.0),
              decoration: BoxDecoration(
                color: Color(0xFFE2EAF3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
                    child: Text(
                      "$receiptTitle",
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.87),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                        letterSpacing: 0.03,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 5.0, 102.0, 5.0),
                    child: Text(
                      "$subtitle",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w100,
                        height: 1.43,
                        fontFamily: 'Montserrat',
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  void _changeCurrency(Currency currency) {
    print(currency.currencyName);
  }
}
