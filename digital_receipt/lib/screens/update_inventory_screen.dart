import 'package:digital_receipt/constant.dart';
import 'package:digital_receipt/models/inventory.dart';
import 'package:digital_receipt/models/product.dart';
import 'package:digital_receipt/screens/create_inventory_screen.dart';
import 'package:digital_receipt/screens/inventory_screen.dart';
import 'package:digital_receipt/services/api_service.dart';
import 'package:digital_receipt/services/shared_preference_service.dart';
import 'package:digital_receipt/utils/connected.dart';
import 'package:digital_receipt/widgets/app_textfield.dart';
import 'package:digital_receipt/widgets/button_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'no_internet_connection.dart';

class UpdateInventory extends StatefulWidget {
  final Inventory inventory;

  UpdateInventory({this.inventory});

  @override
  _UpdateInventoryState createState() => _UpdateInventoryState();
}

final ApiService _apiService = ApiService();
final SharedPreferenceService _sharedPreferenceService =
    SharedPreferenceService();

class _UpdateInventoryState extends State<UpdateInventory> {
  String category;
  String item;
  String unitPrice;
  String quantity;
  String discount;
  String tax;

  bool loading = false;
  var status;

  final _inventoryKey = GlobalKey<FormState>();

  Unit unitValue;

  List<Unit> units = [
    Unit(fullName: 'Gram', singular: 'g', plural: 'g'),
    Unit(fullName: 'Meter', singular: 'm', plural: 'm'),
    Unit(fullName: 'Kilogram', singular: 'Kg', plural: 'Kg'),
    Unit(fullName: 'Litre', singular: 'Ltr', plural: 'Ltr'),
    Unit(fullName: 'Box', singular: 'Box', plural: 'Boxes'),
    Unit(fullName: 'Bag', singular: 'Bag', plural: 'Bags'),
    Unit(fullName: 'Bottle', singular: 'Bottle', plural: 'Bottles'),
    Unit(fullName: 'Rolls', singular: 'Rol', plural: 'Rol'),
    Unit(fullName: 'Pieces', singular: 'Pcs', plural: 'Pcs'),
    Unit(fullName: 'Pack', singular: 'Pac', plural: 'Pac'),
  ];

  void _changeFocus({FocusNode from, FocusNode to}) {
    from.unfocus();
    FocusScope.of(context).requestFocus(to);
  }

  final quantityController = TextEditingController();

  final FocusNode _quantityDropdownFocus = FocusNode();
  final FocusNode _quantityFocus = FocusNode();
  final FocusNode _unitPriceFocus = FocusNode();

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
          initialValue: widget.inventory.category,
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
          initialValue: widget.inventory.title,
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
          initialValue: widget.inventory.unitPrice.toString(),
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
    quantityController.text = widget.inventory.quantity.toString();
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
        Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: _quantityDropdownFocus.hasFocus
                      ? Colors.black
                      : Color.fromRGBO(0, 0, 0, 0.12),
                ),
              ),
              child: DropdownButton<Unit>(
                focusColor: kPrimaryColor,
                focusNode: _quantityDropdownFocus,
                value: unitValue,
                hint: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Unit',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0.3,
                      fontSize: 16,
                      color: Color(0xFF1B1B1B),
                    ),
                  ),
                ),
                underline: Divider(),
                items: units.map(
                  (Unit unit) {
                    return DropdownMenuItem<Unit>(
                      value: unit,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          unit.fullName,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    );
                  },
                ).toList(),
                onChanged: (Unit value) {
                  print(value);
                  setState(() => unitValue = value);
                  _changeFocus(
                      from: _quantityDropdownFocus, to: _quantityFocus);
                },
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: AppTextFieldForm(
                focusNode: _quantityFocus,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) =>
                    _changeFocus(from: _quantityFocus, to: _unitPriceFocus),
                keyboardType: TextInputType.number,
                controller: quantityController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'quantity empty';
                  }
                  return null;
                },
                onSaved: (String value) {
                  quantity = value;
                },
              ),
            ),
          ],
        ),
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
          initialValue: widget.inventory.discount.toString(),
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
          initialValue: widget.inventory.tax.toString(),
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
    print(widget.inventory.quantity);
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
                            FocusScope.of(context).unfocus();
                            if (unitValue == null) {
                              Fluttertoast.showToast(
                                msg: "Add quantity unit",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              setState(() {
                                loading = false;
                              });
                              return;
                            }
                            setState(() {
                              loading = true;
                            });
                          
                            var resp = await _apiService.updateInventory(
                              id: widget.inventory.id,
                              category: category.toUpperCase(),
                              productName: item,
                              price: double.parse(unitPrice),
                              quantity: double.parse(quantity),
                              unit: unitValue.toString(),
                              discount: double.parse(discount),
                              tax: double.parse(tax),
                            );
                            if (resp == 'true') {
                              setState(() {
                                loading = false;
                              });

                              Fluttertoast.showToast(
                                msg: 'updated successfully',
                                toastLength: Toast.LENGTH_LONG,
                                backgroundColor: Colors.grey[700],
                                textColor: Colors.white,
                              );
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InventoryScreen()));
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
                                'Update',
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
