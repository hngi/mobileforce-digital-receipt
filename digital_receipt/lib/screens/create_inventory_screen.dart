import 'package:digital_receipt/services/api_service.dart';
import 'package:digital_receipt/services/shared_preference_service.dart';
import 'package:digital_receipt/utils/connected.dart';
import 'package:digital_receipt/widgets/button_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'no_internet_connection.dart';

class CreateInventory extends StatefulWidget {
  @override
  _CreateInventoryState createState() => _CreateInventoryState();
}

final ApiService _apiService = ApiService();
final SharedPreferenceService _sharedPreferenceService =
    SharedPreferenceService();

class _CreateInventoryState extends State<CreateInventory> {
  String category;
  String item;
  String unitPrice;
  String quantity;
  String discount;
  String tax;

  final _itemControl = TextEditingController();
  final _quantityControl = TextEditingController();
  final _unitPriceControl = TextEditingController();
  final _categoryControl = TextEditingController();
  final _taxControl = TextEditingController()..text = '0';
  final _discountControl = TextEditingController()..text = '0';

  bool loading = false;
  var status;

  final _inventoryKey = GlobalKey<FormState>();

  Widget _buildCategory(formLabel) {
    return Column(
      children: <Widget>[
        Padding(padding: const EdgeInsets.all(3)),
        Container(
          alignment: Alignment.bottomLeft,
          child: Text(
            formLabel,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 13.0,
              color: Color.fromRGBO(0, 0, 0, 0.6),
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          
          controller: _categoryControl,
          style: TextStyle(
            color: Color(0xFF2B2B2B),
            fontSize: 15,
            fontWeight: FontWeight.w600,
            height: 1.43,
            fontFamily: 'Montserrat',
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: 1,
                color: Color.fromRGBO(0, 0, 0, 0.12),
              ),
            ),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Category empty';
            }
            return null;
          },
          onSaved: (String value) {
            category = value;
          },
        )
      ],
    );
  }

  Widget _buildItem(formLabel) {
    return Column(
      children: <Widget>[
        Padding(padding: const EdgeInsets.all(3)),
        Container(
          alignment: Alignment.bottomLeft,
          child: Text(
            formLabel,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 13.0,
              color: Color.fromRGBO(0, 0, 0, 0.6),
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: _itemControl,
          style: TextStyle(
            color: Color(0xFF2B2B2B),
            fontSize: 15,
            fontWeight: FontWeight.w600,
            height: 1.43,
            fontFamily: 'Montserrat',
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: 1,
                color: Color.fromRGBO(0, 0, 0, 0.12),
              ),
            ),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Item empty';
            }
            return null;
          },
          onSaved: (String value) {
            item = value;
          },
        )
      ],
    );
  }

  Widget _buildUnitPrice(formLabel) {
    return Column(
      children: <Widget>[
        Padding(padding: const EdgeInsets.all(3)),
        Container(
          alignment: Alignment.bottomLeft,
          child: Text(
            formLabel,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 13.0,
              color: Color.fromRGBO(0, 0, 0, 0.6),
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          controller: _unitPriceControl,
          style: TextStyle(
            color: Color(0xFF2B2B2B),
            fontSize: 15,
            fontWeight: FontWeight.w600,
            height: 1.43,
            fontFamily: 'Montserrat',
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: 1,
                color: Color.fromRGBO(0, 0, 0, 0.12),
              ),
            ),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Unit Price empty';
            }
            return null;
          },
          onSaved: (String value) {
            unitPrice = value;
          },
        )
      ],
    );
  }

  Widget _buildQuantity(formLabel) {
    return Column(
      children: <Widget>[
        Padding(padding: const EdgeInsets.all(3)),
        Container(
          alignment: Alignment.bottomLeft,
          child: Text(
            formLabel,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 13.0,
              color: Color.fromRGBO(0, 0, 0, 0.6),
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          controller: _quantityControl,
          style: TextStyle(
            color: Color(0xFF2B2B2B),
            fontSize: 15,
            fontWeight: FontWeight.w600,
            height: 1.43,
            fontFamily: 'Montserrat',
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: 1,
                color: Color.fromRGBO(0, 0, 0, 0.12),
              ),
            ),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Quantity empty';
            }
            return null;
          },
          onSaved: (String value) {
            quantity = value;
          },
        )
      ],
    );
  }

  Widget _buildDiscount(formLabel) {
    return Column(
      children: <Widget>[
        Padding(padding: const EdgeInsets.all(3)),
        Container(
          alignment: Alignment.bottomLeft,
          child: Text(
            formLabel,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 13.0,
              color: Color.fromRGBO(0, 0, 0, 0.6),
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          controller: _discountControl,
          style: TextStyle(
            color: Color(0xFF2B2B2B),
            fontSize: 15,
            fontWeight: FontWeight.w600,
            height: 1.43,
            fontFamily: 'Montserrat',
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: 1,
                color: Color.fromRGBO(0, 0, 0, 0.12),
              ),
            ),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Discount empty';
            }
            return null;
          },
          onSaved: (String value) {
            discount = value;
          },
        )
      ],
    );
  }

  Widget _buildTax(formLabel) {
    return Column(
      children: <Widget>[
        Padding(padding: const EdgeInsets.all(3)),
        Container(
          alignment: Alignment.bottomLeft,
          child: Text(
            formLabel,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 13.0,
              color: Color.fromRGBO(0, 0, 0, 0.6),
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          controller: _taxControl,
          style: TextStyle(
            color: Color(0xFF2B2B2B),
            fontSize: 15,
            fontWeight: FontWeight.w600,
            height: 1.43,
            fontFamily: 'Montserrat',
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: 1,
                color: Color.fromRGBO(0, 0, 0, 0.12),
              ),
            ),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Tax empty';
            }
            return null;
          },
          onSaved: (String value) {
            tax = value;
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.teal[50],
        appBar: AppBar(
          //backgroundColor: Color(0xff226EBE),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            "Inventory",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: 'Montserrat',
              letterSpacing: 0.03,
            ),
          ),
          //centerTitle: true,
          actions: <Widget>[],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 40,
              ),
              child: Form(
                key: _inventoryKey,
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Create inventory',
                            style: TextStyle(
                                fontSize: 23.0,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w900,
                                color: Colors.black),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Add items to your inventory',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                            textAlign: TextAlign.justify,
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: 22.0),

                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          _buildCategory('Category'),
                          SizedBox(height: 22),
                          _buildItem('Item'),
                          SizedBox(height: 22),
                          _buildUnitPrice('Unit price'),
                          SizedBox(height: 22),
                          _buildQuantity('Quantity'),
                          SizedBox(height: 22),
                          _buildDiscount('Discount'),
                          SizedBox(height: 22),
                          _buildTax('Tax'),
                        ]),

                    SizedBox(
                      height: 50,
                    ), //Spacing
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: FlatButton(
                        onPressed: () async {
                          if (_inventoryKey.currentState.validate()) {
                            _inventoryKey.currentState.save();

                            setState(() {
                              loading = true;
                            });
                            var connected = await Connected().checkInternet();
                            if (!connected) {
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return NoInternet();
                                },
                              );
                              setState(() {
                                loading = false;
                              });
                              return;
                            }
                            setState(() {
                              loading = true;
                            });
                            var resp = await _apiService.addInventory(
                                category.toUpperCase(),
                                item.toUpperCase(),
                                double.parse(unitPrice),
                                double.parse(quantity),
                                'kg');
                            if (resp == 'true') {
                               setState(() {
                                loading = false;
                               /*  _itemControl..text="";
                                _quantityControl..text = "";
                                _unitPriceControl..text = "";
                                _categoryControl..text = "";

                                _taxControl..text = "";
                                _discountControl..text = "";*/
                              }); 

                              Fluttertoast.showToast(
                                msg: 'created successfully',
                                toastLength: Toast.LENGTH_LONG,
                                backgroundColor: Colors.grey[700],
                                textColor: Colors.white,
                              );
                            } else {
                              setState(() {
                                loading = false;
                              });
                              Fluttertoast.showToast(
                                msg: 'an error occured',
                                toastLength: Toast.LENGTH_LONG,
                                backgroundColor: Colors.grey[700],
                                textColor: Colors.white,
                              );
                            }
                          }
                        },
                        textColor: Colors.white,
                        color: Color(0xFF0B57A7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: loading
                            ? ButtonLoadingIndicator(
                                color: Colors.white, height: 20, width: 20)
                            : Text(
                                'Save',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
