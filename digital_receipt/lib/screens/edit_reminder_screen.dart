import 'package:digital_receipt/models/product.dart';
import 'package:digital_receipt/screens/create_receipt_page.dart';
import 'package:digital_receipt/utils/receipt_util.dart';
import 'package:digital_receipt/widgets/app_solid_button.dart';
import 'package:digital_receipt/widgets/app_text_form_field.dart';
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
