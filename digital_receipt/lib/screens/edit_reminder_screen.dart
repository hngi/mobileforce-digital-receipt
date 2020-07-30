import 'package:digital_receipt/models/product.dart';
import 'package:digital_receipt/screens/create_receipt_page.dart';
import 'package:digital_receipt/services/api_service.dart';
import 'package:digital_receipt/utils/receipt_util.dart';
import 'package:digital_receipt/widgets/app_solid_button.dart';
import 'package:digital_receipt/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class EditReminderScreen extends StatefulWidget {
  String day;
  String month;
  String year;
  String hour;
  String minute;

  EditReminderScreen(
      {@required this.day, this.month, this.year, this.hour, this.minute});
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
  DateTime date;
  TimeOfDay time;

  TextEditingController _dateTextController = TextEditingController();
  TextEditingController _timeTextController = TextEditingController();

  Widget initData() {
    date = DateTime(
        int.parse(widget.year), int.parse(widget.month), int.parse(widget.day));
    time = TimeOfDay(
        hour: int.parse(widget.hour), minute: int.parse(widget.minute));
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ApiService _apiService = ApiService();
    if (date != null && time != null) {
      _dateTextController.text = DateFormat('dd-MM-yyyy').format(date);
      _timeTextController.text = time.format(context);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit reminder",
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
                style: Theme.of(context).textTheme.headline6,
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
              SwitchListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text('Part payment',
                    style: Theme.of(context).textTheme.headline6),
                value: _partPayment,
                activeColor: Theme.of(context).accentColor,
                onChanged: (val) {
                  setState(() {
                    _partPayment = !_partPayment;
                  });
                },
              ),
              _partPayment
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'If Payment has been completed, Toggle switch off',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 27,
                        ),
                        AppTextFormField(
                          label: 'Date',
                          readOnly: true,
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
                          },
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        AppTextFormField(
                          label: 'Time',
                          readOnly: true,
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
                          },
                        ),
                      ],
                    )
                  : SizedBox.shrink(),
              SizedBox(
                height: 55,
              ),
              AppSolidButton(
                onPressed: () async {
                  // var res = await _apiService.updatePartPaymentReminder(
                  //     id: '2',
                  //     date: _dateTextController.text,
                  //     time: _timeTextController.text);


                  var j = _dateTextController.text.split("-");
                  print(j[2]);
                  print(j[1]);
                  print(j[0]);
                  String date =
                      j[2]+'-'+j[1]+'-'+j[0] +"T"+_timeTextController.text+':00.000000z';
                  print(date);
                  // String dateWithT =
                  //     date.substring(0, 10) + 'T' + date.substring(10);
                  DateTime dateTime = DateTime.parse(date);
                  // print(dateTime);

                  print(date);
                  print(time);
                },
                text: 'Update',
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
