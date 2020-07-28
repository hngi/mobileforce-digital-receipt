import 'package:digital_receipt/models/receipt.dart';
import 'package:digital_receipt/utils/connected.dart';
import 'package:digital_receipt/utils/receipt_util.dart';
import 'package:digital_receipt/widgets/app_card.dart';
import 'package:intl/intl.dart';
import 'package:digital_receipt/services/api_service.dart';
import 'package:flutter/material.dart';
import '../services/shared_preference_service.dart';
import 'package:random_color/random_color.dart';
import 'package:digital_receipt/services/hiveDb.dart';

import '../constant.dart';
import '../widgets/analytics_card.dart';

final ApiService _apiService = ApiService();
final HiveDb hiveDb = HiveDb();

class Analytics extends StatefulWidget {
  @override
  _AnalyticsState createState() => _AnalyticsState();
}

String currency = '';

class _AnalyticsState extends State<Analytics> {
  final numberFormat = new NumberFormat();
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

    var connectivityResult = await Connected().checkInternet();
    if (connectivityResult) {
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

  setCurrency() async {
    currency = await SharedPreferenceService().getStringValuesSF('Currency');
  }

  @override
  void initState() {
    setCurrency();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Analytics',
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
                  _buildTopContent(totalSales: '0'),
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
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AnalyticsCard('$currency$totalSales'),
        SizedBox(
          height: 20,
        ),
        Text(
          'Sales via categories',
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget buildCard(
      String title, String currency, String subTitle, Color sideColor) {
    return AppCard(
      liningColor: sideColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
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
              '$currency$subTitle',
              textScaleFactor: 0.8,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
      child: Column(
        children: <Widget>[
          _buildTopContent(totalSales: '------'),
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
      items.add(buildCard(key, currency, Utils.formatNumber(value),
          _color.randomColor(colorBrightness: ColorBrightness.light)));
    });
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTopContent(totalSales: data.totalSales),
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
