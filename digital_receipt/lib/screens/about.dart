import 'package:digital_receipt/constant.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info/package_info.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  PackageInfo packageInfo;

  setPackage() async {
    setState(() {
      packageInfo = PackageInfo();
    });
    var val = await PackageInfo.fromPlatform();
    setState(() {
      packageInfo = val;
    });
  }

  _launchURL(String url) async {
    //const url = url;
    if (await canLaunch(url)) {
      await launch(
        url,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    setPackage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat',
            letterSpacing: 0.03,
          ),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          //AboutListTile(),
          ListTile(
            title: Text(
              'Build version',
              style: TextStyle(
                fontFamily: 'Montserrat',
              ),
            ),
            subtitle: Text(
              packageInfo?.buildNumber ?? '',
              style: TextStyle(
                fontFamily: 'Montserrat',
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Open-source licences',
              style: TextStyle(
                fontFamily: 'Montserrat',
              ),
            ),
            subtitle: Text(
              'Licence detail for open-source software',
              style: TextStyle(
                fontFamily: 'Montserrat',
              ),
            ),
            onTap: () => showLicensePage(
                context: context,
                applicationIcon: Center(
                  child: Container(
                      height: 50,
                      width: 150,
                      color: Colors.white,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: kLogo1),
                )),
          ),
          ListTile(
              title: Text(
                'Privacy Policy',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                ),
              ),
              onTap: () {
                _launchURL('https://degeit.flycricket.io/privacy.html');
              }),
          ListTile(
              title: Text(
                'Terms of service',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                ),
              ),
              onTap: () {
                // _launchURL('https://flutter.dev');
              }

              //subtitle: Text(packageInfo?.buildNumber),
              ),
        ],
      )),
    );
  }
}
