import 'package:carousel_slider/carousel_controller.dart';
import 'package:digital_receipt/models/customer.dart';
import 'package:digital_receipt/models/receipt.dart';
import 'package:digital_receipt/services/CarouselIndex.dart';
import 'package:digital_receipt/widgets/app_textfield.dart';
import 'package:digital_receipt/widgets/submit_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateReceiptStep0 extends StatefulWidget {
  const CreateReceiptStep0({this.carouselController, this.carouselIndex});

  final CarouselController carouselController;
  final CarouselIndex carouselIndex;
  @override
  _CreateReceiptStep0State createState() => _CreateReceiptStep0State();
}

class _CreateReceiptStep0State extends State<CreateReceiptStep0> {
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
  ReceiptCategory selectedCategory;
  Customer selectedCustomer;

  // Needed to decide weather to create a new customer or not
  List<Customer> customers = [Customer(name: 'Select customer')];

  String _customerName, _customerEmail, _customerAddress, _customerPNumber;

  @override
  void initState() {
    super.initState();
    customers.addAll(Customer.dummy());
  }

  @override
  Widget build(BuildContext context) {
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
              Text(
                'Create a receipt',
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
              Text(
                'Category',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.3,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'This helps you track your sales from different platforms',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w300,
                  letterSpacing: 0.3,
                  fontSize: 12,
                  color: Color(0xFF141414),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              DropdownButtonFormField(
                hint: Text(
                  'Select category',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.normal,
                    letterSpacing: 0.3,
                    fontSize: 16,
                    color: Color(0xFF1B1B1B),
                  ),
                ),
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
                iconEnabledColor: Color.fromRGBO(0, 0, 0, 0.87),
                onChanged: (value) {
                  print(value);
                  setState(() {
                    selectedCategory = value;
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
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.3,
                  fontSize: 16,
                  color: Color(0xFF000000),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'This information is display on the receipt. If the customer is saved, select customer',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.3,
                  fontSize: 14,
                  color: Color(0xFF141414),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<Customer>(
                value: selectedCustomer,
                onChanged: (Customer value) {
                  setState(() {
                    selectedCustomer = value;
                  });
                },
                validator: (value) {
                  if (_nameController.text == null ||
                      _nameController.text.isEmpty) {
                    if (value == null) {
                      return "Select a customer or enter a new one";
                    }
                  }
                  return null;
                },
                items: customers.map((Customer customer) {
                  return DropdownMenuItem<Customer>(
                    value: customer.email != null ? customer : null,
                    child: Text(
                      customer.name,
                    ),
                  );
                }).toList(),
                iconEnabledColor: Color.fromRGBO(0, 0, 0, 0.87),
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
                height: 25,
              ),
              Text(
                'Otherwise, enter customer information',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.3,
                  fontSize: 14,
                  color: Color.fromRGBO(0, 0, 0, 0.6),
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
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Save to customer list',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0.3,
                      fontSize: 16,
                      color: Color.fromRGBO(0, 0, 0, 1),
                    ),
                  ),
                  Switch(
                    value: false,
                    onChanged: (val) {},
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              DropdownButtonFormField(
                items: [],
                onChanged: (val) {},
                iconDisabledColor: Color.fromRGBO(0, 0, 0, 0.87),
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
                hint: Text(
                  'Select currency',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3,
                    fontSize: 14,
                    color: Color(0xFF1B1B1B),
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
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();

                    Provider.of<Receipt>(context, listen: false)
                        .setCategory(selectedCategory);

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
                    widget.carouselController.animateToPage(1);
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
    super.dispose();
  }
}
