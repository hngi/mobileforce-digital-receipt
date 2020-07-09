import 'dart:convert';

import 'package:digital_receipt/models/product.dart';
import 'package:digital_receipt/models/receipt.dart';
import 'package:digital_receipt/models/receipt.dart';
import 'package:digital_receipt/models/receipt.dart';
import 'package:intl/intl.dart';
import 'package:digital_receipt/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';
import '../constant.dart';
import '../widgets/analytics_card.dart';

final ApiService _apiService = ApiService();

class Analytics extends StatefulWidget {
  @override
  _AnalyticsState createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  final numberFormat = new NumberFormat("₦#,##0.#", "en_US");

  Future<AnalyticsData> generateContent() async {
    List<Receipt> issuedReceipts = await _apiService.getIssuedReceipts();
    if (issuedReceipts != null && issuedReceipts.length > 0) {
      return await generateDataFromReceipts(issuedReceipts);
    } else {
      return Future.value();
    }
  }

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
      body: FutureBuilder<AnalyticsData>(
          future: generateContent(),
          builder: (context, snapshot) {
            Widget content;
            if (snapshot.connectionState == ConnectionState.waiting) {
              content = _buildLoadingState();
            } else if (!snapshot.hasData) {
              // If Empty
              content = Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
                child: Column(
                  children: <Widget>[
                    _buildTopContent(totalSales: '₦ 0'),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(80),
                        child: kEmpty,
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasData) {
              // Contains Data
              content = _buildGridView(snapshot.data);
            } else {
              // If Something went wrong
              content = _buildLoadingState();
            }
            return content;
          },
      ),
    );
  }

  Widget _buildTopContent({@required String totalSales}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AnalyticsCard(totalSales),
        SizedBox(
          height: 20,
        ),
        Text(
          'Sales via categories',
          style: TextStyle(
            color: Color(0xFF0C0C0C),
            fontSize: 16,
            fontWeight: FontWeight.w300,
            fontFamily: 'Montserrat',
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Container buildCard(String title, String subTitle, Color sideColor) {
    return Container(
      decoration: BoxDecoration(
        color: sideColor,
        borderRadius: BorderRadius.circular(5.0),
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

  Widget _buildLoadingState() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
      child: Column(
        children: <Widget>[
          _buildTopContent(totalSales: '₦ ------'),
          Expanded(
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(kPrimaryColor),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildGridView(AnalyticsData data) {
    List<Widget> items = [];
    RandomColor _color = RandomColor();
    data.gridItems.forEach((key, value) {
      items.add(buildCard(key, numberFormat.format(value),
          _color.randomColor(colorBrightness: ColorBrightness.light)));
    });
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AnalyticsCard(data.totalSales),
            SizedBox(
              height: 20,
            ),
            Text(
              'Sales via categories',
              style: TextStyle(
                color: Color(0xFF0C0C0C),
                fontSize: 16,
                fontWeight: FontWeight.w300,
                fontFamily: 'Montserrat',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GridView.count(
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                children: items)
          ],
        ),
      ),
    );
  }

  Future<AnalyticsData> generateDataFromReceipts(
      List<Receipt> issuedReceipts) async {
    print(issuedReceipts);

    Map<String, double> gridItems = {};
    double totalSales = 0;

    issuedReceipts.forEach((Receipt receipt) {
      try {
        double newAmount = double.parse(receipt.totalAmount);
        totalSales += newAmount;
        //print("This: $newAmount");

        switch (receipt.category) {
          case ReceiptCategory.WHATSAPP:
            gridItems.update('WhatsApp', (former) => former + newAmount,
                ifAbsent: () => newAmount);
            break;
          case ReceiptCategory.INSTAGRAM:
            gridItems.update('Instagram', (former) => former + newAmount,
                ifAbsent: () => newAmount);
            break;
          case ReceiptCategory.FACEBOOK:
            gridItems.update('Facebook', (former) => former + newAmount,
                ifAbsent: () => newAmount);
            break;
          case ReceiptCategory.TWITTER:
            gridItems.update('Twitter', (former) => former + newAmount,
                ifAbsent: () => newAmount);
            break;
          case ReceiptCategory.REDIT:
            gridItems.update('Redit', (former) => former + newAmount,
                ifAbsent: () => newAmount);
            break;
          case ReceiptCategory.OTHERS:
            gridItems.update('Others', (former) => former + newAmount,
                ifAbsent: () => newAmount);
            break;
        }
      } catch (e) {
        print(e);
      }
    });

    return Future.value(AnalyticsData(
        totalSales: numberFormat.format(totalSales), gridItems: gridItems));
  }
}

class AnalyticsData {
  final String totalSales;
  final Map<String, double> gridItems;

  AnalyticsData({this.totalSales, this.gridItems});
}
