import 'package:digital_receipt/screens/dashboard.dart';
import 'package:digital_receipt/services/notification.dart';
import 'package:digital_receipt/services/shared_preference_service.dart';
import 'package:digital_receipt/widgets/main_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'create_receipt_page.dart';

AppNotification appNotification = AppNotification();

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(

              //backgroundColor: Color(0xFF226EBE),
              ),
          drawer: MainDrawer(),
          body: SafeArea(
            child: DashBoard(),
          ),
          floatingActionButton: SafeArea(
            child: FloatingActionButton(
              onPressed: () async {
                /*  var connected = await Connected().checkInternet();
            if (!connected) {
              await showDialog(
                context: context,
                builder: (context) {
                  return NoInternet();
                },
              );
              return;
            } */
                print(await SharedPreferenceService()
                    .getStringValuesSF('AUTH_TOKEN'));
                /*  await appNotification.showNotification(
                title: 'food', body: 'green',); */
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateReceiptPage()));
              },
              child: Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ),
// <<<<<<< dev
        ));
// =======
/*         ),
      ),
      )
    ); */
//>>>>>>> dev
  }
}
