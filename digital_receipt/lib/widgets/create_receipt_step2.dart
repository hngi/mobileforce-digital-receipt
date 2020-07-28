import 'dart:convert';
import 'dart:math';
import 'dart:io';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:digital_receipt/models/receipt.dart';
import 'package:digital_receipt/screens/no_internet_connection.dart';
import 'package:digital_receipt/screens/receipt_screen.dart';
import 'package:digital_receipt/services/CarouselIndex.dart';
import 'package:digital_receipt/utils/connected.dart';
import 'package:digital_receipt/widgets/app_text_form_field.dart';
import 'package:digital_receipt/widgets/date_time_input_textField.dart';
import 'package:digital_receipt/widgets/app_solid_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'button_loading_indicator.dart';
import 'package:digital_receipt/services/api_service.dart';

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
  ApiService _apiService = ApiService();
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
  TextEditingController _sellerNameController = TextEditingController();

  final FocusNode _receiptNumberFocus = FocusNode();
  final FocusNode _dateTextFocus = FocusNode();
  final FocusNode _hexCodeFocus = FocusNode();

  bool autoReceiptNo = true;
  String fontVal = "100";
  DateTime date = DateTime.now();
  final picker = ImagePicker();

  List<String> receiptTemplate = [
    'assets/images/Group 168 (1).png',
    'assets/images/Group 169 (1).png',
    'assets/images/Group 172 (1).png',
  ];

  @override
  void initState() {
    super.initState();
    setSellerName();
  }

  void setSellerName() async {
    var user = await _apiService.getUserInfo();
    _sellerNameController.text = user["name"] ?? '';
  }

  @override
  void dispose() {
    _receiptNumberFocus.dispose();
    _dateTextFocus.dispose();
    _hexCodeFocus.dispose();
    super.dispose();
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

  setPreReceipt(String result) {
    var temp = json.decode(result)['receiptData'];
    Provider.of<Receipt>(context, listen: false).setIssueDate(temp['date']);
    Provider.of<Receipt>(context, listen: false)
        .setNumber(temp['receipt_number']);
    Provider.of<Receipt>(context, listen: false).receiptId = temp['id'];
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    _dateTextController.text = DateFormat('dd-MM-yyyy').format(date);
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
              'Customization',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              'Tweak the look and feel to your receipt',
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
            /* Text(
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
              focusNode: _receiptNumberFocus,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (value) =>
                  _changeFocus(from: _receiptNumberFocus, to: _dateTextFocus),
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
                  value: Provider.of<Receipt>(context).shouldGenReceiptNo(),
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
            ), */
            Text('Date'),
            SizedBox(height: 5),
            DateTimeInputTextField(
                focusNode: _dateTextFocus,
                controller: _dateTextController,
                onTap: () async {
                  final DateTime datePicked = await showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: date.add(Duration(days: -20)),
                    lastDate: date.add(Duration(days: 365)),
                  );

                  _dateTextFocus.unfocus();
                  if (datePicked != null && datePicked != date) {
                    setState(() {
                      date = datePicked;
                      print(DateTime.now());
                    });
                  }
                }),
            /* SizedBox(
              height: 20,
            ),
            Text('Seller\'s name'),
            SizedBox(height: 5),
            AppTextFormField(
              controller: _sellerNameController,
            ),
            */
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Text(
                  'Choose a color (optional)',
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
                  scrollDirection: Axis.vertical,
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
            /* Center(
              child: Text(
                'Or type brand Hex code here',
                textAlign: TextAlign.center,
              ),
            ), */
            SizedBox(height: 20),
            AppTextFormField(
              focusNode: _hexCodeFocus,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (value) => _hexCodeFocus.unfocus(),
              controller: _hexCodeController,
              hintText: 'Enter Brand color hex code',
              hintColor: Theme.of(context).textTheme.subtitle2.color,
              borderWidth: 1.5,
              readOnly: true,
            ),
            SizedBox(height: 37),
            /*  Text(
              'Select a receipt',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
                fontSize: 16,
                color: Color.fromRGBO(0, 0, 0, 0.87),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: ListView.builder(
                itemCount: receiptTemplate.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Scaffold(
                                backgroundColor: Colors.white,
                                appBar: AppBar(
                                  title: Text(
                                    'Preview',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Montserrat',
                                      letterSpacing: 0.03,
                                    ),
                                  ),
                                ),
                                body: SizedBox.expand(
                                  child: Stack(
                                    children: <Widget>[
                                      SingleChildScrollView(
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: ListView.builder(
                                            itemCount: receiptTemplate.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.asset(
                                                  
                                                  receiptTemplate[index],
                                                  fit: BoxFit.cover,
                                                  height: double.infinity,
                                                  width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: SubmitButton(
                                              title: 'Select',
                                              backgroundColor:
                                                  Color(0xFF0B57A7),
                                              textColor: Colors.white,
                                              onPressed: () {},
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: SizedBox(
                        height: 200,
                        width: 150,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: 200,
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                      image: AssetImage(receiptTemplate[index]),
                                      fit: BoxFit.cover),
                                  color: Colors.white),
                            ),
                            Container(
                              height: 200,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                  image: AssetImage(''),
                                ),
                                color: Color.fromRGBO(0, 0, 0, 0.3),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ), */
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Add paid stamp',
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        fontWeight: FontWeight.normal,
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
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        fontWeight: FontWeight.normal,
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
            AppSolidButton(
              height: 50,
              isLoading: isLoading,
              text: 'Generate Receipt',
              onPressed: () async {
                // check the internet
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
                setState(() {
                  isLoading = true;
                });
                Provider.of<Receipt>(context, listen: false).setIssueDate(null);
                Provider.of<Receipt>(context, listen: false)
                    .setColor(hexCode: _hexCodeController.text);
                Provider.of<Receipt>(context, listen: false).setFont(24);
                Provider.of<Receipt>(context, listen: false)
                    .setSellerName(_sellerNameController.text);

                Response result =
                    await Provider.of<Receipt>(context, listen: false)
                        .saveReceipt();
                print(result);
                if (result != null && result.statusCode == 200) {
                  setState(() {
                    isLoading = false;
                  });
                  setPreReceipt(result.body);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReceiptScreen(),
                    ),
                  );
                  Fluttertoast.showToast(
                      msg: "Receipt saved to draft",
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
            ),
            // SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  void _changeFocus({FocusNode from, FocusNode to}) {
    from.unfocus();
    FocusScope.of(context).requestFocus(to);
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
