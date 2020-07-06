import 'dart:math';
import 'dart:io';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:digital_receipt/models/receipt.dart';
import 'package:digital_receipt/screens/receipt_screen.dart';
import 'package:digital_receipt/services/CarouselIndex.dart';
import 'package:digital_receipt/widgets/app_textfield.dart';
import 'package:digital_receipt/widgets/date_time_input_textField.dart';
import 'package:digital_receipt/widgets/loading.dart';
import 'package:digital_receipt/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class CreateReceiptStep2 extends StatefulWidget {
  CreateReceiptStep2({
    this.carouselController,
    this.carouselIndex,
  });
  final CarouselController carouselController;
  final CarouselIndex carouselIndex;

  @override
  _CreateReceiptStep2State createState() => _CreateReceiptStep2State();
}

class _CreateReceiptStep2State extends State<CreateReceiptStep2> {
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  TextEditingController _dateTextController = TextEditingController();
  TextEditingController _receiptNumberController = TextEditingController();
  TextEditingController _hexCodeController = TextEditingController()
    ..text = "F14C4C";

  bool autoReceiptNo = true;
  String fontVal = "100";
  DateTime date = DateTime.now();
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  Future getImageSignature() async {
    PermissionStatus status = await Permission.storage.status;
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    print("file size is :");
    print(File(pickedFile.path).lengthSync());
    if (pickedFile != null) {
      setState(() {
        Provider.of<Receipt>(context, listen: false)
            .setSignature(pickedFile.path);
      });
    } else {
      print("no file");
    }
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    _dateTextController.text = DateFormat('dd-MM-yyyy').format(date);
    return isLoading == true
        ? LoadingIndicator()
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    'Customization',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                      fontSize: 22,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Tweak the look and feel to your receipt',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0.3,
                      fontSize: 14,
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
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.16))
                                      ]),
                                ),
                                index != 2
                                    ? SizedBox(width: 10)
                                    : SizedBox.shrink()
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
                    'Add receipt No (Optional)',
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
                    controller: _receiptNumberController,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Auto generate receipt No',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.normal,
                          letterSpacing: 0.3,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      Checkbox(
                        value:
                            Provider.of<Receipt>(context).shouldGenReceiptNo(),
                        onChanged: (val) {
                          setState(() {
                            Provider.of<Receipt>(context, listen: false)
                                .toggleAutoGenReceiptNo();
                          });
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 32,
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
                  DateTimeInputTextField(
                      controller: _dateTextController,
                      onTap: () async {
                        final DateTime picked = await showDatePicker(
                          context: context,
                          initialDate: date,
                          firstDate: date.add(Duration(days: -20)),
                          lastDate: date.add(Duration(days: 365)),
                        );

                        if (picked != null && picked != date) {
                          setState(() {
                            date = picked;
                            print(DateTime.now());
                          });
                        }
                      }),
                  SizedBox(
                    height: 30,
                  ),
                  DropdownButtonFormField<String>(
                    value: fontVal,
                    items: ['100', '200', '300', '400', '500']
                        .map((val) => DropdownMenuItem(
                              child: Text(val.toString()),
                              value: val,
                            ))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        fontVal = val;
                      });
                    },
                    style:  TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Montserrat',
                      ),
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
                    iconEnabledColor: Color.fromRGBO(0, 0, 0, 0.87),
                    hint: Text(
                      'Select font',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.3,
                        fontSize: 16,
                        color: Color(0xFF1B1B1B),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: getImageSignature,
                      shape: RoundedRectangleBorder(
                          side:
                              BorderSide(color: Color(0xFF25CCB3), width: 1.5),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Upload signature',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.normal,
                              letterSpacing: 0.3,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 7),
                          Icon(
                            Icons.file_upload,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      'Your Signature should be taken on a clear white paper and have a max size of 3MB (Optional)',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.3,
                        fontSize: 14,
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Choose a color (optional)',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.3,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(_hexCodeController.text.toUpperCase()),
                    ],
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 33,
                    child: SizedBox(
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            ColorButton(
                              color: Colors.red,
                              onPressed: () {
                                setState(() {
                                  _hexCodeController.text = 'F14C4C';
                                });
                              },
                            ),
                            ColorButton(
                              color: Color(0xFF539C30),
                              onPressed: () {
                                setState(() {
                                  _hexCodeController.text = '539C30';
                                });
                              },
                            ),
                            ColorButton(
                              color: Color(0xFF2C33D5),
                              onPressed: () {
                                setState(() {
                                  _hexCodeController.text = '2C33D5';
                                });
                              },
                            ),
                            ColorButton(
                              color: Color(0xFFE7D324),
                              onPressed: () {
                                setState(() {
                                  _hexCodeController.text = 'E7D324';
                                });
                              },
                            ),
                            ColorButton(
                              color: Color(0xFFC022B1),
                              onPressed: () {
                                setState(() {
                                  _hexCodeController.text = 'C022B1';
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Or type brand Hex code here',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.3,
                        fontSize: 14,
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  AppTextFieldForm(
                    controller: _hexCodeController,
                    hintText: 'Enter Brand color hex code',
                    hintColor: Color.fromRGBO(0, 0, 0, 0.38),
                    borderWidth: 1.5,
                  ),
                  SizedBox(height: 37),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Add paid stamp',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.3,
                          fontSize: 16,
                          color: Color.fromRGBO(0, 0, 0, 0.87),
                        ),
                      ),
                      Checkbox(
                        value: Provider.of<Receipt>(context, listen: false)
                            .enablePaidStamp(),
                        onChanged: (val) {
                          setState(() {
                            Provider.of<Receipt>(context, listen: false)
                                .togglePaidStamp();
                          });
                        },
                      )
                    ],
                  ),
                  SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Save as preset',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.3,
                          fontSize: 16,
                          color: Color.fromRGBO(0, 0, 0, 0.87),
                        ),
                      ),
                      Switch(
                        value: Provider.of<Receipt>(context, listen: false)
                            .enablePreset(),
                        onChanged: (val) {
                          setState(() {
                            Provider.of<Receipt>(context, listen: false)
                                .togglePreset();
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        var result =
                            await Provider.of<Receipt>(context, listen: false)
                                .saveReceipt();
                        if (result == "successful") {
                          setState(() {
                            isLoading = false;
                          });
                          Fluttertoast.showToast(
                              msg: "saved to Draft",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          setState(() {
                            isLoading = false;
                          });
                          Fluttertoast.showToast(
                              msg: "$result",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      },
                      shape: RoundedRectangleBorder(
                          side:
                              BorderSide(color: Color(0xFF0B57A7), width: 1.5),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        'Save to drafts',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  SubmitButton(
                    onPressed: () {
                      if (Provider.of<Receipt>(context, listen: false)
                          .shouldGenReceiptNo()) {
                        Provider.of<Receipt>(context, listen: false)
                            .setNumber(Random().nextInt(999) + 100);
                      } else {
                        try {
                          Provider.of<Receipt>(context, listen: false)
                              .setNumber(
                                  int.parse(_receiptNumberController.text));
                        } catch (e) {
                          print(e);
                        }
                      }
                      Provider.of<Receipt>(context, listen: false)
                          .setIssueDate(_dateTextController.text);
                      Provider.of<Receipt>(context, listen: false)
                          .setColor(hexCode: _hexCodeController.text);
                      Provider.of<Receipt>(context, listen: false)
                          .setFont(int.parse(fontVal));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReceiptScreen(),
                          ));
                    },
                    title: 'Generate Receipt',
                    textColor: Colors.white,
                    backgroundColor: Color(0xFF0B57A7),
                  ),
                ],
              ),
            ),
          );
  }
}

class ColorButton extends StatelessWidget {
  const ColorButton({
    Key key,
    this.onPressed,
    this.color,
  }) : super(key: key);

  final Function onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 33,
      width: 33,
      child: FlatButton(
        color: color,
        onPressed: onPressed,
        child: SizedBox.shrink(),
      ),
    );
  }
}
