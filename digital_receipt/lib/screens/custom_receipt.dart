import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

class CustomReceipt extends StatefulWidget {
  @override
  _CustomReceiptState createState() => _CustomReceiptState();
}

class _CustomReceiptState extends State<CustomReceipt> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File gallery;
  String color = 'No Color';
  var _customReceipt = CustomRecipeModel(
      receiptNo: null,
      generateReceipt: false,
      date: DateTime.now(),
      font: null,
      selectedColor: Colors.blue,
      hexcode: null,
      paidStamp: false,
      preset: false);

  String _validateItemRequired(String value) {
    return value.isEmpty ? 'This field is required' : null;
  }
DateTime selectedDate = DateTime.now();
// Date Picker
Future<DateTime> _selectDate(DateTime selectedDate) async {
 DateTime _initialDate = selectedDate;
 final DateTime _pickedDate = await showDatePicker(
 context: context,
 initialDate: _initialDate,
 firstDate: DateTime.now().subtract(Duration(days: 365)),
 lastDate: DateTime.now().add(Duration(days: 365)),
 );
 if (_pickedDate != null) {
 selectedDate = DateTime(
 _pickedDate.year,
 _pickedDate.month,
 _pickedDate.day,
 _initialDate.hour,
 _initialDate.minute,
 _initialDate.second,
 _initialDate.millisecond,
 _initialDate.microsecond);
 }

 setState(() {
   _customReceipt.date = selectedDate;
 });
 return selectedDate;
}

  void _submitOrder() {
    /*
    This function performs the action of create and editing recipes. Do no make changes 
    unloess you are giuven permission
     */
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue[700],
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text('Create Receipt'),
          ),
          body: Form(
            key: _formKey,
            autovalidate: true,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 10),
                  child: Text(
                    'Customization',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Tweak the look and feel of your receipt.',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black54,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, bottom: 12),
                  child: Text(
                    'Add receipt No(optional) .',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Enter receipt no (optional)',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black,
                        ))),
                    onSaved: (value) => _customReceipt = CustomRecipeModel(
                        receiptNo: value,
                        generateReceipt: _customReceipt.generateReceipt,
                        date: _customReceipt.date,
                        font: _customReceipt.font,
                        selectedColor: _customReceipt.selectedColor,
                        hexcode: _customReceipt.hexcode,
                        paidStamp: _customReceipt.paidStamp,
                        preset: _customReceipt.preset),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6, left: 10, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Auto generate receipt No',
                        style: TextStyle(fontSize: 19),
                      ),
                      Checkbox(
                        checkColor: Colors.teal,
                        activeColor: Colors.white,
                        hoverColor: Colors.white,
                        value: _customReceipt.generateReceipt,
                        onChanged: (value) => {
                          setState(() {
                            value = !(_customReceipt.generateReceipt);
                            _customReceipt.generateReceipt = value;
                          })
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 12),
                  child: Text(
                    'Date',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                ),
                GestureDetector(
                                  child: Container(
                    height: 40,
                    
                    margin: EdgeInsets.only(left: 10, right: 10, bottom: 15),
                    padding: EdgeInsets.all(8),
                     decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.teal)),
                    child:Text('Current Date - ${_customReceipt.date}',
                     style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 17,
                    ),
                    ),
                    /*
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                        color: Colors.black,
                      ))),
                      validator: (value) => _validateItemRequired(value),
                      onSaved: (value) => _customReceipt = CustomRecipeModel(
                          receiptNo: _customReceipt.receiptNo,
                          generateReceipt: _customReceipt.generateReceipt,
                          date: value,
                          font: _customReceipt.font,
                          selectedColor: _customReceipt.selectedColor,
                          hexcode: _customReceipt.hexcode,
                          paidStamp: _customReceipt.paidStamp,
                          preset: _customReceipt.preset),
                    ),*/
                  ),
                  onTap: () => _selectDate(selectedDate),
                ),
                DropDown(),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, bottom: 15),
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.teal)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Upload Signature'),
                      Icon(
                        Icons.file_download,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 28.0, right: 28),
                        child: Text(
                          'Your logo should be in PNG format and have ',
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 28.0, right: 28),
                        child: Text(
                          'a max size of 3MB',
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, bottom: 15),
                  child: Text(
                    'Choose receipt color (optional) - $color',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                        child: PickColor(Colors.deepOrange),
                        onTap: () => setState(() {
                              color = 'Orange';
                            })),
                    GestureDetector(
                        child: PickColor(Colors.green),
                        onTap: () => setState(() {
                              color = 'Green';
                            })),
                    GestureDetector(
                        child: PickColor(Colors.blue[900]),
                        onTap: () => setState(() {
                              color = 'Blue';
                            })),
                    GestureDetector(
                        child: PickColor(Colors.yellow),
                        onTap: () => setState(() {
                              color = 'Yellow';
                            })),
                    GestureDetector(
                        child: PickColor(Colors.purple),
                        onTap: () => setState(() {
                              color = 'Purple';
                            })),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: Center(child: Text('or type brand hexcode here')),
                ),
                Container(
                  height: 40,
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: TextFormField(
                    autovalidate: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                    validator: (value) => _validateItemRequired(value),
                    onSaved: (value) => _customReceipt = CustomRecipeModel(
                        receiptNo: _customReceipt.receiptNo,
                        generateReceipt: _customReceipt.generateReceipt,
                        date: _customReceipt.date,
                        font: _customReceipt.font,
                        selectedColor: _customReceipt.selectedColor,
                        hexcode: value,
                        paidStamp: _customReceipt.paidStamp,
                        preset: _customReceipt.preset),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Add paid stamp',
                        style: TextStyle(fontSize: 17),
                      ),
                      Checkbox(
                        checkColor: Colors.teal,
                        activeColor: Colors.white,
                        hoverColor: Colors.white,
                        value: _customReceipt.paidStamp,
                        onChanged: (value) => {
                          setState(() {
                            value = !(_customReceipt.paidStamp);
                            _customReceipt.paidStamp = value;
                          })
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Save as Preset',
                        style: TextStyle(fontSize: 17),
                      ),
                      Switch(
                        activeColor: Colors.teal,
                        value: _customReceipt.preset,
                        onChanged: (value) => {
                          setState(() {
                            value = !(_customReceipt.preset);
                            _customReceipt.preset = value;
                          })
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 14),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  width: 150,
                  child: OutlineButton(
                    onPressed: () {
                      _submitOrder();
                    },
                    child: Text('Save to Drafts'),
                    borderSide: BorderSide(color: Colors.blue[700]),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  width: 150,
                  child: FlatButton(
                    onPressed: () => () {
                      _submitOrder();
                    },
                    color: Colors.blue[700],
                    child: Text(
                      'Generate to Receipt',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class PickColor extends StatelessWidget {
  Color color;
  PickColor(this.color);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      color: color,
    );
  }
}

class DropDown extends StatefulWidget {
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    String text = 'Default';
    String dropdown;
    var mywidth = MediaQuery.of(context).size.width;
    return Center(
      child: DropdownButton<String>(
        hint: Container(
            margin: EdgeInsets.only(left: 10, right: 50),
            width: mywidth - 100,
            child: Text('$text')),
      
        items:
            <String>['Default', 'Arial', 'Roman', 'Lucida'].map((String value) {
          return new DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
          onChanged: (value) {
          setState(() {
            text = value;
          });
        },
      ),
      
    );
  }
}

class CustomRecipeModel {
  String receiptNo;
  bool generateReceipt = false;
  DateTime date;
  String font;
  Color selectedColor;
  String hexcode;
  bool paidStamp;
  bool preset;

  CustomRecipeModel(
      {@required this.receiptNo,
      @required this.generateReceipt,
      @required this.date,
      @required this.font,
      @required this.selectedColor,
      @required this.hexcode,
      @required this.paidStamp,
      @required this.preset});
}
