import 'package:digital_receipt/widgets/export_option.dart';
import 'package:flutter/material.dart';
import '../services/shared_preference_service.dart';

class PreferencePage extends StatefulWidget {
  @override
  _PreferencePageState createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
  bool _dark;
  bool _currentAutoLogoutStatus = false;

  getCurrentAutoLogoutStatus() async {
    var _logoutStatus =
        await _sharedPreferenceService.getBoolValuesSF("AUTO_LOGOUT") ?? false;
    setState(() {
      _currentAutoLogoutStatus = _logoutStatus;
    });
  }

  @override
  void initState() {
    super.initState();
    _dark = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCurrentAutoLogoutStatus();
    });
  }

  Brightness _getBrightness() {
    return _dark ? Brightness.dark : Brightness.light;
  }

  static SharedPreferenceService _sharedPreferenceService =
      SharedPreferenceService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFFF2F8FF),
      appBar: AppBar(
          //backgroundColor: Color(0xFFF2F8FF),
          ),

      body: SafeArea(
        child: Stack(
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
                  // SwitchListTile(
                  //   activeColor: Color(0xFF25CCB3),
                  //   contentPadding: const EdgeInsets.all(0),
                  //   value: false,
                  //   title: Text('Dark Mode'),
                  //   onChanged: (val) {},
                  // ),
                  // SwitchListTile(
                  //   activeColor: Color(0xFF25CCB3),
                  //   contentPadding: const EdgeInsets.all(0),
                  //   value: false,
                  //   title: Text('Push Notifications'),
                  //   onChanged: (val) {},
                  // ),
                  SwitchListTile(
                      activeColor: Color(0xFF25CCB3),
                      contentPadding: const EdgeInsets.all(0),
                      value: _currentAutoLogoutStatus,
                      title: Text('Enable Auto Logout'),
                      onChanged: (value) {
                        _sharedPreferenceService.addBoolToSF(
                            "AUTO_LOGOUT", value);
                        getCurrentAutoLogoutStatus();
                      }),
                  ExportOptionButton(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
