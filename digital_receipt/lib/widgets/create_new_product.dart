import 'package:digital_receipt/models/product.dart';
import 'package:digital_receipt/widgets/custom_formfield.dart';
import 'package:digital_receipt/widgets/app_solid_button.dart';
import 'package:flutter/material.dart';

class CreateNewProduct extends StatefulWidget {
  final Function createProducts;
  final List<Product> products;
  final int index;
  final bool isUpdate;

  const CreateNewProduct(
      {Key key, this.createProducts, this.isUpdate, this.products, this.index})
      : super(key: key);

  @override
  _CreateNewProductState createState() => _CreateNewProductState();
}

class _CreateNewProductState extends State<CreateNewProduct> {
  final _productDesc = TextEditingController();
  final _quantity = TextEditingController();
  final _unitPrice = TextEditingController();

  TextEditingController _updateTextEditing(val) {
    return TextEditingController(text: val);
  }

  _submitProduct() {
    final product = _productDesc.text;
    final double quantity =
        _quantity.text == '' ? 0 : int.parse(_quantity.text);
    final double unit =
        _unitPrice.text == '' ? 0 : double.parse(_unitPrice.text);
    final double totalAmount = unit * quantity;
    if ((totalAmount <= 0 && (product.isEmpty || product.length <= 5)) &&
        !widget.isUpdate) {
      return;
    }
    final String id = DateTime.now().toString().substring(0, 10) +
        TimeOfDay.now().toString().substring(10, 15);

    if (widget.isUpdate) {
      widget.createProducts(
          index: widget.index,
          name: product,
          amount: totalAmount,
          quantity: quantity,
          unit: unit);

      print(product +
          ' ' +
          quantity.toString() +
          ' ' +
          unit.toString() +
          ' ' +
          totalAmount.toString());
    } else {
      widget.createProducts(new Product(
          id: id,
          productDesc: product,
          quantity: quantity,
          unitPrice: unit,
          amount: totalAmount.round() as double));
    }

    Navigator.of(context).pop();
    print(product +
        ' ' +
        quantity.toString() +
        ' ' +
        unit.toString() +
        ' ' +
        totalAmount.toString());
  }

  @override
  Widget build(BuildContext context) {
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
                    padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
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
                      Text(
                        'Product description',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.normal,
                          letterSpacing: 0.3,
                          fontSize: 13,
                          color: Color.fromRGBO(0, 0, 0, 0.6),
                        ),
                      ),
                      SizedBox(height: 5),
                      CustomFormField(
                          hintText: !widget.isUpdate
                              ? ''
                              : widget.products[widget.index].productDesc,
                          inputController: _productDesc,
                          onSubmit: _submitProduct),
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
                      CustomFormField(
                        hintText: !widget.isUpdate
                            ? ''
                            : widget.products[widget.index].quantity.toString(),
                        inputController: _quantity,
                        onSubmit: _submitProduct,
                        numKeyShow: true,
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
                      CustomFormField(
                        hintText: !widget.isUpdate
                            ? ''
                            : widget.products[widget.index].unitPrice
                                .toString(),
                        inputController: _unitPrice,
                        onSubmit: _submitProduct,
                        numKeyShow: true,
                      ),
                      // SizedBox(height: 15),
                      // Center(
                      //   child: Text(
                      //     'Product added',
                      //     style: TextStyle(
                      //       fontFamily: 'Montserrat',
                      //       fontWeight: FontWeight.w500,
                      //       letterSpacing: 0.3,
                      //       fontSize: 14,
                      //       color: Color(0xFF219653),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 20),
                      widget.isUpdate
                          ? AppSolidButton(
                              text: 'Update',
                              backgroundColor: Color(0xFF0B57A7),
                              onPressed: () => _submitProduct(),
                              textColor: Colors.white,
                            )
                          : AppSolidButton(
                              text: 'Add',
                              backgroundColor: Color(0xFF0B57A7),
                              onPressed: () => _submitProduct(),
                              textColor: Colors.white,
                            )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
