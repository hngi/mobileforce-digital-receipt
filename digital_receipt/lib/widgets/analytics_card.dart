import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnalyticsCard extends StatelessWidget {
  String totalSales;

  AnalyticsCard(
    this.totalSales, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/Merchant_Identity.png')),
        borderRadius: BorderRadius.circular(7.0),
        color: Color(0xFF0B57A7),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Total Sales',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                  Text(
                    totalSales,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: FaIcon(
                      FontAwesomeIcons.opencart,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Geek',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                            text: 'Tutor',
                            style: TextStyle(
                                color: Colors.grey[300],
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
