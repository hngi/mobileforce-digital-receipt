import 'package:digital_receipt/models/product.dart';
import 'package:digital_receipt/services/api_service.dart';
import 'package:digital_receipt/services/shared_preference_service.dart';
import 'package:digital_receipt/utils/connected.dart';
import 'package:digital_receipt/widgets/app_solid_button.dart';
import 'package:digital_receipt/widgets/app_text_form_field.dart';
import 'package:digital_receipt/widgets/button_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constant.dart';
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

  bool isLoading = false;
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

  Widget _buildQuantity(formLabel) {
    return Column(
      children: <Widget>[
        Padding(padding: const EdgeInsets.all(3)),
        Container(
          alignment: Alignment.bottomLeft,
          child: Text(
            formLabel,
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
                      ? Theme.of(context)
                          .inputDecorationTheme
                          .focusedBorder
                          .borderSide
                          .color
                      : Theme.of(context)
                          .inputDecorationTheme
                          .enabledBorder
                          .borderSide
                          .color,
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
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ),
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.normal),
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
              child: AppTextFormField(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.teal[50],
        appBar: AppBar(
          //backgroundColor: Color(0xff226EBE),
         
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
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Add items to your inventory',
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 22.0),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          AppTextFormField(
                            label: 'Category',
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Category empty';
                              }
                              return null;
                            },
                            onSaved: (String value) {
                              category = value;
                            },
                          ),
                          SizedBox(height: 22),
                          AppTextFormField(
                            label: 'Item',
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Item empty';
                              }
                              return null;
                            },
                            onSaved: (String value) {
                              item = value;
                            },
                          ),
                          SizedBox(height: 22),
                          AppTextFormField(
                            label: 'Unit price',
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Unit Price empty';
                              }
                              return null;
                            },
                            onSaved: (String value) {
                              unitPrice = value;
                            },
                          ),
                          SizedBox(height: 22),
                          _buildQuantity('Quantity'),
                          SizedBox(height: 22),
                          AppTextFormField(
                            label: 'Discount',
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Discount empty';
                              }
                              return null;
                            },
                            onSaved: (String value) {
                              discount = value;
                            },
                          ),
                          SizedBox(height: 22),
                          AppTextFormField(
                            label: 'Tax',
                            keyboardType: TextInputType.number,
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
                        ]),
                    SizedBox(height: 50), //Spacing
                    AppSolidButton(
                      text: 'Save',
                      isLoading: isLoading,
                      onPressed: () async {
                        if (_inventoryKey.currentState.validate()) {
                          _inventoryKey.currentState.save();

                          setState(() {
                            isLoading = true;
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
                              isLoading = false;
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
                              isLoading = false;
                            });

                            return;
                          }
                          setState(() {
                            isLoading = true;
                          });
                          print("quantity  unit is $unitValue");
                          print(tax);
                          var resp = await _apiService.addInventory(
                            category.toUpperCase(),
                            item.toUpperCase(),
                            double.parse(unitPrice),
                            double.parse(quantity),
                            unitValue.getShortName(
                                int.parse(quantityController.text)),
                            double.parse(discount),
                            double.parse(tax),
                          );
                          if (resp == 'true') {
                            setState(() {
                              isLoading = false;
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
                              isLoading = false;
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
