import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class mainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.only(top: 30.0, left: 2.0),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text(
                'Reecpy',
                style: TextStyle(
                    fontFamily: 'LibreBaskerville',
                    fontSize: 25.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.6
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.account_circle,
                color: Colors.white,
                size: 20.0,
              ),
              title: Text(
                'Profile',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    letterSpacing: 0.5
                ),
              ),
              onTap: (){},
            ),
            ListTile(
              leading: Icon(
                Icons.receipt,
                color: Colors.white,
                size: 20.0,
              ),
              title: Text(
                'Receipts',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    letterSpacing: 0.5
                ),
              ),
              onTap: (){},
            ),
            ListTile(
              leading: Icon(
                Icons.history,
                color: Colors.white,
                size: 20.0,
              ),
              title: Text(
                'History',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    letterSpacing: 0.5
                ),
              ),
              onTap: (){},
            ),
            ListTile(
              leading: Icon(
                Icons.show_chart,
                color: Colors.white,
                size: 20.0,
              ),
              title: Text(
                'Analytics',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    letterSpacing: 0.5
                ),
              ),
              onTap: (){},
            ),
            ListTile(
              leading: Icon(
                Icons.description,
                color: Colors.white,
                size: 20.0,
              ),
              title: Text(
                'Drafts',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    letterSpacing: 0.5
                ),
              ),
              onTap: (){},
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.white,
                size: 20.0,
              ),
              title: Text(
                'Settings',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    letterSpacing: 0.5
                ),
              ),
              onTap: (){},
            ),
          ],
        ),
      ),
    );
  }
}

