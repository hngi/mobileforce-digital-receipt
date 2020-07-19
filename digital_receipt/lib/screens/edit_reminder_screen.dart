import 'package:digital_receipt/models/product.dart';
import 'package:digital_receipt/screens/create_receipt_page.dart';
import 'package:digital_receipt/utils/receipt_util.dart';
import 'package:digital_receipt/widgets/submit_button.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class EditReminderScreen extends StatefulWidget {
  @override
  _EditReminderScreenState createState() => _EditReminderScreenState();
}

class _EditReminderScreenState extends State<EditReminderScreen> {
  bool _partPayment = true;

  List<Product> items = [
    Product(id: '1', productDesc: 'After effects for dummies', amount: 1000),
    Product(id: '2', productDesc: 'Crtyptotrading course', amount: 1000),
    Product(id: '3', productDesc: 'Udemy courses', amount: 1000)
  ];
  DateTime date = DateTime(2020, 6, 22);
  TimeOfDay time = TimeOfDay(hour: 22, minute: 00);

  TextEditingController _dateTextController = TextEditingController();
  TextEditingController _timeTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (date != null && time != null) {
      _dateTextController.text = DateFormat('dd-MM-yyyy').format(date);
      _timeTextController.text = time.format(context);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit reminder",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat',
            letterSpacing: 0.03,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 14.0,
              ),
              Text(
                'Product item/s',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.3,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) => ProductItem(
                  title: items[index].productDesc,
                  amount: '₦${Utils.formatNumber(items[index].amount)}',
                ),
                itemCount: items.length,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Part payment',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0.3,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  Switch(
                    value: _partPayment,
                    activeColor: Color(0xFF76DBC9),
                    activeTrackColor: Color(0xFFD7DCE2),
                    onChanged: (val) {
                      setState(() {
                        _partPayment = !_partPayment;
                      });
                    },
                  ),
                ],
              ),
              if (_partPayment)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'If Payment has been completed, Toggle switch off',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.normal,
                          letterSpacing: 0.3,
                          fontSize: 14,
                          color: Color(0x99000000),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 22,
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
                    _buildTextFieldWidget(
                        controller: _dateTextController,
                        onTap: () async {
                          final DateTime picked = await showDatePicker(
                            context: context,
                            initialDate: date,
                            firstDate: date.add(Duration(days: -5)),
                            lastDate: date.add(Duration(days: 365)),
                          );

                          if (picked != null && picked != date) {
                            setState(() {
                              date = picked;
                            });
                          }
                        }),
                    SizedBox(
                      height: 22,
                    ),
                    Text(
                      'Time',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.normal,
                        letterSpacing: 0.3,
                        fontSize: 15,
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                      ),
                    ),
                    SizedBox(height: 5),
                    _buildTextFieldWidget(
                        controller: _timeTextController,
                        onTap: () async {
                          final TimeOfDay picked = await showTimePicker(
                            context: context,
                            initialTime: time,
                          );

                          if (picked != null && picked != time) {
                            setState(() {
                              time = picked;
                            });
                          }
                        }),
                  ],
                )
              else
                SizedBox.shrink(),
              SizedBox(
                height: 55,
              ),
              SubmitButton(
                onPressed: () async {
                  // TODO Update Reminder
                },
                title: 'Update',
                backgroundColor: Color(0xFF0B57A7),
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void dispose() {
    _dateTextController.dispose();
    _timeTextController.dispose();
    super.dispose();
  }
}

Widget _buildTextFieldWidget(
    {TextEditingController controller, Function onTap}) {
  return TextField(
    controller: controller,
    readOnly: true,
    style: TextStyle(
      color: Color(0xFF2B2B2B),
      fontSize: 14,
      fontWeight: FontWeight.w600,
      fontFamily: 'Montserrat',
    ),
    onTap: onTap,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.all(15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color: Color(0xFFC8C8C8),
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(),
    ),
  );
}
