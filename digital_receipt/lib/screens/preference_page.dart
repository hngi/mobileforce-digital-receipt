import 'package:digital_receipt/widgets/export_option.dart';
import 'package:flutter/material.dart';

class PreferencePage extends StatefulWidget {
  @override
  _PreferencePageState createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
  bool _dark;

  @override
  void initState() {
    super.initState();
    _dark = false;
  }

  Brightness _getBrightness() {
    return _dark ? Brightness.dark : Brightness.light;
  }

  @override
  Widget build(BuildContext context) {
    return /* Theme(
      isMaterialAppTheme: true,
      data: ThemeData(
        brightness: _getBrightness(),
      ),
      child:  */
        Scaffold(
      //backgroundColor: Color(0xFFF2F8FF),
      appBar: AppBar(
          //backgroundColor: Color(0xFFF2F8FF),
          ),

      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    "Preferences",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(0, 16.0, 0, 16.0),
                  //alignment: FractionalOffset(0.5, 2.0),
                ),
                SwitchListTile(
                  activeColor: Color(0xFF25CCB3),
                  contentPadding: const EdgeInsets.all(0),
                  value: true,
                  title: Text('Dark Mode'),
                  onChanged: (val) {},
                ),
                SwitchListTile(
                  activeColor: Color(0xFF25CCB3),
                  contentPadding: const EdgeInsets.all(0),
                  value: false,
                  title: Text('Push Notifications'),
                  onChanged: (val) {},
                ),
                ExportOptionButton(),
              ],
            ),
          )
        ],
      ),
    );
    /* ); */
  }
}
