import 'dart:convert';

import 'package:digital_receipt/models/product.dart';
import 'package:digital_receipt/models/receipt.dart';
import 'package:digital_receipt/models/receipt.dart';
import 'package:digital_receipt/models/receipt.dart';
import 'package:digital_receipt/utils/receipt_util.dart';
import 'package:intl/intl.dart';
import 'package:digital_receipt/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';
import 'package:digital_receipt/services/hiveDb.dart';
import 'package:connectivity/connectivity.dart';
import '../constant.dart';
import '../widgets/analytics_card.dart';

final ApiService _apiService = ApiService();
final HiveDb hiveDb = HiveDb();

class Analytics extends StatefulWidget {
  @override
  _AnalyticsState createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  final numberFormat = new NumberFormat("₦#,##0.#", "en_US");

  // Future<AnalyticsData> generateContent() async {
  //   List<Receipt> issuedReceipts = await _apiService.getIssuedReceipts();
  //   if (issuedReceipts != null && issuedReceipts.length > 0) {
  //     return await generateDataFromReceipts(issuedReceipts);
  //   } else {
  //     return Future.value();
  //   }
  // }

  Future<List<Receipt>> getReceipts() async {
    // Receipts from API/database
    List<Receipt> issuedReceipts = [];
    // Receipts from Local Database
    List<Receipt> issuedReceiptsDB = [];

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // gets receipts from API
      Map receiptsAPI = await _apiService.getIssuedReceipt2();
      // Convert API/database data to a receipt
      receiptsAPI['data'].forEach((receipt) {
        issuedReceipts.add(Receipt.fromJson(receipt));
      });
      //  stores API/database data into local database
      await hiveDb.addReceiptAnalytic(receiptsAPI['data']);
      //  gets data from local database
      List receiptsFromDB = await hiveDb.getAnalyticData();
      // Convert local database data to a receipt
      receiptsFromDB.forEach((receipt) {
        issuedReceiptsDB.add(Receipt.fromJson(receipt));
      });

      issuedReceipts = issuedReceiptsDB;
    } else {
      //  gets data from local database
      List receiptsFromDB = await hiveDb.getAnalyticData();
      // Convert local database data to a receipt
      receiptsFromDB.forEach((receipt) {
        issuedReceipts.add(Receipt.fromJson(receipt));
      });
      issuedReceipts = issuedReceipts;
    }
    return issuedReceipts;
  }

  Future<AnalyticsData> generateContent() async {
    List<Receipt> issuedReceipts = await getReceipts();
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
                      margin: EdgeInsets.all(30),
                      child: kEmpty,
                    ),
                  ),
                  Text('There are no receipts created')
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
          mainAxisAlignment: MainAxisAlignment.center,
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
                '₦$subTitle',
                textScaleFactor: 0.8,
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
                strokeWidth: 1.5,
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
    //print(value);
      items.add(buildCard(key, Utils.formatNumber(value),
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
