import 'package:flutter/material.dart';

class CustomReceipt extends StatefulWidget {
  @override
  _CustomReceiptState createState() => _CustomReceiptState();
}

class _CustomReceiptState extends State<CustomReceipt> {
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
              onPressed: null,
            ),
            title: Text('Create Receipt'),
          ),
          body: ListView(
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
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                    color: Colors.black,
                  ))),
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
                      checkColor: Colors.black,
                      value: false,
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
              Container(
                height: 40,
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 15),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                    color: Colors.black,
                  ))),
                ),
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
                  'Choose receipt color (optional)',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  PickColor(Colors.deepOrange),
                  PickColor(Colors.green),
                  PickColor(Colors.blue[900]),
                  PickColor(Colors.yellow),
                  PickColor(Colors.purple),
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
                  decoration: InputDecoration(
                      hintText: 'Enter Brand color hex code',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))),
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
                      checkColor: Colors.black,
                      value: false,
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
                    Switch(value: false, onChanged: null),
                  ],
                ),
              ),
              SizedBox(height: 14),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                width: 150,
                child: OutlineButton(
                  onPressed: () => print('hello'),
                  child: Text('Save to Drafts'),
                  borderSide: BorderSide(color: Colors.blue[700]),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                width: 150,
                child: FlatButton(
                  onPressed: () => print('fd'),
                  color: Colors.blue[700],
                  child: Text(
                    'Generate to Receipt',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
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
    String dropdown;
    var mywidth = MediaQuery.of(context).size.width;
    return Center(
      child: DropdownButton<String>(
        hint: Container(
          margin: EdgeInsets.only(left:10,right:50),
          width:mywidth-100,
          child: Text('Select a Font')),
            onChanged: (String value){
          setState(() {
            dropdown = value;
          });
        },
        items: <String>['Default','Arial','Roman','Lucida'].map((String value) {
          return new DropdownMenuItem<String>(
            value:value,
            child: Text(value),
            );
        }).toList(),
      ),
    );
  }
}
