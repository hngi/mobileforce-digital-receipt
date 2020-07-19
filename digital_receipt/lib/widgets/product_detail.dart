import 'dart:math';

import 'package:digital_receipt/constant.dart';
import 'package:digital_receipt/models/inventory.dart';
import 'package:digital_receipt/models/product.dart';
import 'package:digital_receipt/services/api_service.dart';
import 'package:digital_receipt/utils/receipt_util.dart';
import 'package:digital_receipt/widgets/app_textfield.dart';
import 'package:digital_receipt/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'contact_card.dart';

class ProductDetail extends StatefulWidget {
  final Function(Product) onSubmit;
  final Product product;
  final index;

  @override
  _ProductDetailState createState() => _ProductDetailState();
  ProductDetail({Key key, this.onSubmit, this.product, this.index})
      : super(key: key);
}

class _ProductDetailState extends State<ProductDetail> {
  final productDescController = TextEditingController();
  final quantityController = TextEditingController();
  final unitPriceController = TextEditingController();
  final taxController = TextEditingController();
  final discountController = TextEditingController();
  final FocusNode _productDescFocus = FocusNode();
  final FocusNode _quantityDropdownFocus = FocusNode();
  final FocusNode _quantityFocus = FocusNode();
  final FocusNode _unitPriceFocus = FocusNode();
  final FocusNode _taxFocus = FocusNode();
  final FocusNode _discountFocus = FocusNode();

  bool productAdded = false;
  Product product;

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
  List<Inventory> inventories;
  Inventory selectedInventory;

  @override
  void initState() {
    ApiService().getAllInventories();
    product = widget.product;
    if (product != null) {
      productDescController.text = product.productDesc;
      quantityController.text = product.quantity.round().toString();
      unitPriceController.text = product.unitPrice.round().toString();
      taxController.text = product.tax.round().toString();
      discountController.text = product.discount.round().toString();
      if (product.unit != null) {
        unitValue = units.firstWhere((unit) {
          if (unit.singular == product.unit || unit.plural == product.unit) {
            return true;
          }
          return false;
        }, orElse: () => null);
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    productDescController.dispose();
    quantityController.dispose();
    unitPriceController.dispose();
    taxController.dispose();
    discountController.dispose();

    _productDescFocus.dispose();
    _quantityDropdownFocus.dispose();
    _quantityFocus.dispose();
    _unitPriceFocus.dispose();
    _taxFocus.dispose();
    _discountFocus.dispose();
    super.dispose();
  }

  fillWithInventory() {
    productDescController.text = selectedInventory.title;
    quantityController.text = '1';
    unitPriceController.text = selectedInventory.unitPrice.round().toString();
    taxController.text = (selectedInventory.tax?.round()?.toString()) ?? '0';
    discountController.text =
        selectedInventory.discount?.round()?.toString() ?? '0';
    if (selectedInventory.unit != null) {
      unitValue = units?.firstWhere((unit) {
        if (unit.singular == selectedInventory?.unit ||
            unit.plural == selectedInventory?.unit) {
          return true;
        }
        return false;
      }, orElse: () => null);
    }
    selectedInventory = null;
  }

  @override
  Widget build(BuildContext context) {
    inventories = Provider.of<Inventory>(context).inventoryList;
    if (selectedInventory != null) {
      fillWithInventory();
    }
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
            color: Color(0xFFFFFFFFF),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 1,
                ),
                RawMaterialButton(
                    padding: EdgeInsets.only(
                        top: 60, bottom: 20, left: 10, right: 50),
                    constraints: BoxConstraints.tightForFinite(),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                    ))
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(21.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 9),

                     product == null

                          ? GestureDetector(
                              onTap: () async {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return InventoryDialog(
                                      inventories: inventories,
                                      onSubmit: (Inventory inventory) {
                                        setState(() {
                                          selectedInventory = inventory;
                                        });
                                      },
                                    );
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color.fromRGBO(0, 0, 0, 0.12),
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 13, vertical: 14),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      selectedInventory != null
                                          ? selectedInventory.title
                                          : 'Select from Inventory',
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
                            )
                          : SizedBox.shrink(),
                      SizedBox(
                        height: 7,
                      ),
                      product == null
                          ? Text(
                              'Or, enter Product information',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.normal,
                                letterSpacing: 0.3,
                                fontSize: 14,
                                color: Color.fromRGBO(0, 0, 0, 0.6),
                              ),
                            )
                          : SizedBox.shrink(),
                      SizedBox(height: 7),
                      SizedBox(height: 9),
                      Text(
                        'Description',
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
                          focusNode: _productDescFocus,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (value) => _changeFocus(
                              from: _productDescFocus,
                              to: _quantityDropdownFocus),
                          controller: productDescController,
                          validator: (val) {
                            if (val.length < 1) {
                              return "minimum length is 1 character";
                            }
                            return "";
                          }),
                      SizedBox(height: 22),
                      Text(
                        'Quantity',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.normal,
                          letterSpacing: 0.3,
                          fontSize: 13,
                          color: Color.fromRGBO(0, 0, 0, 0.6),
                        ),
                      ),
                      SizedBox(height: 5),
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
                                    from: _quantityDropdownFocus,
                                    to: _quantityFocus);
                              },
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: AppTextFieldForm(
                              focusNode: _quantityFocus,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (value) => _changeFocus(
                                  from: _quantityFocus, to: _unitPriceFocus),
                              keyboardType: TextInputType.number,
                              controller: quantityController,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 22),
                      Text(
                        'Unit price',
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
                        focusNode: _unitPriceFocus,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) =>
                            _changeFocus(from: _unitPriceFocus, to: _taxFocus),
                        keyboardType: TextInputType.number,
                        controller: unitPriceController,
                      ),
                      SizedBox(height: 22),
                      Text(
                        'Tax',
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
                        focusNode: _taxFocus,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) =>
                            _changeFocus(from: _taxFocus, to: _discountFocus),
                        keyboardType: TextInputType.number,
                        controller: taxController,
                      ),
                      SizedBox(height: 22),
                      Text(
                        'Discount',
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
                        focusNode: _discountFocus,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (value) {
                          _discountFocus.unfocus();
                          submitForm();
                        },
                        keyboardType: TextInputType.number,
                        controller: discountController,
                      ),
                      productAdded
                          ? Center(
                              child: Text(
                                product == null
                                    ? 'Product added'
                                    : 'Product edited',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.normal,
                                  letterSpacing: 0.3,
                                  fontSize: 13,
                                  color: Color.fromRGBO(0, 0, 0, 0.6),
                                ),
                              ),
                            )
                          : SizedBox(),
                      SizedBox(height: 20),
                      SubmitButton(
                        title: 'Add',
                        backgroundColor: Color(0xFF0B57A7),
                        onPressed: () {
                          submitForm();
                        },
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void submitForm() {
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
      return;
    }
    try {
      widget.onSubmit(
        Product(
          id: productDescController.text.substring(1, 4) +
              (Random().nextInt(99) + 10).toString(),
          productDesc: productDescController.text.toUpperCase(),
          quantity: double.parse(quantityController.text),
          unitPrice: double.parse(unitPriceController.text),
          unit: unitValue.getShortName(int.parse(quantityController.text)),
          amount: (double.parse(quantityController.text) *
                  double.parse(unitPriceController.text)) +
              (double.parse(taxController.text)) -
              (double.parse(discountController.text) /
                  100 *
                  (double.parse(quantityController.text) *
                      double.parse(unitPriceController.text))),
          tax: double.parse(taxController.text),
          discount: double.parse(discountController.text),
        ),
      );
      setState(() {
        productAdded = true;
        unitValue = null;
        selectedInventory = null;
        productDescController..text = "";
        quantityController..text = "";
        unitPriceController..text = "";
        taxController..text = "";
        discountController..text = "";
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          productAdded = false;
          product = null;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  void _changeFocus({FocusNode from, FocusNode to}) {
    from.unfocus();
    FocusScope.of(context).requestFocus(to);
  }
}

class InventoryDialog extends StatelessWidget {
  const InventoryDialog({
    this.inventories,
    this.onSubmit,
  });
  final List<Inventory> inventories;
  final Function onSubmit;

  @override
  Widget build(BuildContext context) {
    //List<Inventory> customers = Provider.of<Customer>(context).customerList;
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
                        print(val);
                        Provider.of<Inventory>(context, listen: false)
                            .searchInventoryList(val);
                      },
                      decoration: InputDecoration(
                        hintText: "Search inventory",
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
                    inventories.isEmpty
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
                                "You have not added any inventory item!",
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
                              itemCount: inventories.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    onSubmit(inventories[index]);
                                    Navigator.pop(context);
                                  },
                                  child: ContactCard(
                                    receiptTitle: inventories[index].title,
                                    subtitle:
                                        'UNIT PRICE: N ${Utils.formatNumber(inventories[index].unitPrice.round().toDouble() ?? 0)}',
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
