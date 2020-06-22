import 'package:flutter/material.dart';

class CardTile extends StatelessWidget {
  final String label;
  final String amount;


  CardTile({this.label, this.amount});


  @override
  Widget build(BuildContext context) {
    // return Container(
    //   child: Card(
    //     elevation: 0,
    //     color: Color(0xFFeaf1f8),
    //     child: Padding(
    //       padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: <Widget>[
    //           Text(label, style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w600, fontSize: 20)),
    //           Text(amount, style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600, fontSize: 20),)
    //         ],
    //       ),
    //     ),
    //   ),
    return Card(
      elevation: 0,
      color: Color(0xFFeaf1f8),
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: ListTile(
          leading: Text(label, style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w600, fontSize: 18)),
          trailing: Text(amount, style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600, fontSize: 18),),
          onTap: () => print('edit'),
        ),
      ),
    );
  }
}
