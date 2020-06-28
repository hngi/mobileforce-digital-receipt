import 'package:flutter/material.dart';
import '../widgets/analytics_card.dart';



class Analytics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Analytics',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
            fontSize: 16,
            //color: Colors.white,
          ),
        ),
      ),
      body:  SingleChildScrollView(
              child: Padding(
          padding: const EdgeInsets.fromLTRB(20 , 20, 20, 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AnalyticsCard(),
              SizedBox(height: 20,),
              Text(
            'Sales via categories',
            style: TextStyle(color: Color(0xFF0C0C0C), fontSize: 16, fontWeight: FontWeight.w300, fontFamily: 'Montserrat',
            ),
          ),
           SizedBox(height: 20,),

           GridView.count(
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            children: <Widget>[

          buildCard('WhatsApp', 'N80,000', Color(0xFF25CCB3)),
          buildCard('Instagram', 'N50,000', Color(0xFFE897A0)),
          buildCard('Twitter', 'N20,000', Color(0xFF00B6FF)),
            ]
           )
            ],
          ),
        ),
      ),
    );
  }

  Container buildCard(String title, String subTitle, Color sideColor) {
    return Container(
    decoration: BoxDecoration(
      color: sideColor,
      borderRadius: BorderRadius.circular(7.0),
    ),
    child: Container(
      margin: EdgeInsets.only(left: 5.0),
      decoration: BoxDecoration(
          color: Color(0xFFE3EAF1),
          borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 50),
            Text(
              '$title',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                '$subTitle',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28.0,
                ),
              ),
            ),
          ],
      ),
    ),
         );
  }
}

