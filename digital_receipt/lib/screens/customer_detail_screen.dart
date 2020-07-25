import 'dart:developer' as dev;
import 'dart:math';

import 'package:digital_receipt/models/customer.dart';
import 'package:digital_receipt/models/receipt.dart';
import 'package:digital_receipt/services/api_service.dart';
import 'package:digital_receipt/widgets/app_card.dart';
import 'package:digital_receipt/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constant.dart';

final ApiService _apiService = ApiService();
final numberFormat = new NumberFormat();
final dateFormat = DateFormat('dd-MM-yyyy');

class CustomerDetailScreen extends StatefulWidget {
  final Customer customer;

  CustomerDetailScreen({Key key, this.customer}) : super(key: key);

  @override
  _CustomerDetailScreenState createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Customer List',
          ),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 16,
                left: 16,
                right: 16,
              ),
              /*
              labelColor: Colors.grey[700],
                unselectedLabelColor: Colors.black,
                labelStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                ),
                indicatorColor: Theme.of(context).primaryColor,
              */
              child: TabBar(
                indicatorColor: Theme.of(context).tabBarTheme.labelColor,
                unselectedLabelColor: Theme.of(context).disabledColor,
                tabs: [
                  Tab(
                    text: 'Full Details',
                  ),
                  Tab(
                    text: 'Issued Receipts',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 0, 16, 16),
                    child: DetailTab(
                      customer: widget.customer,
                    ),
                  ),
                  ReceiptTab(
                    customer: widget.customer,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailTab extends StatelessWidget {
  final Customer customer;

  const DetailTab({Key key, this.customer}) : super(key: key);

  Container _buildInputField(
      {String label, String initialValue, bool readOnly = true}) {
    return Container(
      padding: EdgeInsets.only(bottom: 24.0),
      child: AppTextFormField(
        label: label,
        initialValue: initialValue,
        readOnly: readOnly,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildInputField(
            label: 'Customer name',
            initialValue: customer.name,
            readOnly: true),
        _buildInputField(
            label: 'Email', initialValue: customer.email, readOnly: true),
        _buildInputField(
            label: 'Phone Number',
            initialValue: customer.phoneNumber,
            readOnly: true),
        _buildInputField(
            label: 'Address', initialValue: customer.address, readOnly: true),
      ],
    );
  }
}

class ReceiptTab extends StatelessWidget {
  final Customer customer;

  const ReceiptTab({Key key, this.customer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Receipt>>(
        future: getCustomerReceipt(customer),
        builder: (context, snapshot) {
          print(snapshot.data);
          Widget content;
          if (snapshot.connectionState == ConnectionState.waiting) {
            // If Loading
            content = _buildLoadingState();
          } else if (!snapshot.hasData) {
            // If Empty
            content = Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(80),
                  child: kEmpty,
                ),
              ),
            );
          } else if (snapshot.hasData) {
            // If contains Data
            content = _buildReceiptList(context, snapshot.data);
          } else {
            // If Something went wrong
            content = _buildLoadingState();
          }
          return content;
        });
  }
}

/*Receipt(
receiptNo: '0021',
issuedDate: '12-06-2020',
customerName: 'Carole Froschauer',
description: 'Cryptocurrency course, intro to after effects',
totalAmount: '80,000',
),*/
Widget _buildReceiptList(
        BuildContext context, List<Receipt> customerReceiptList) =>
    ListView.builder(
      itemCount: customerReceiptList.length,
      padding: EdgeInsets.fromLTRB(16.0, 0, 16, 0),
      itemBuilder: (_, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: _buildReceiptCard(context, customerReceiptList[index]),
      ),
    );

Widget _buildReceiptCard(BuildContext context, Receipt receipt) {
  return AppCard(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Receipt No: ${receipt.receiptNo}',
                style: Theme.of(context).textTheme.subtitle2,
              ),
              Text(
                dateFormat.format(DateTime.parse(receipt.issuedDate)),
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            receipt.customerName,
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Container(
            width: 250,
            child: Text(
              receipt.descriptions,
              maxLines: 2,
            ),
          ),
          SizedBox(
            height: 4.0,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              'Total:\t\t ${numberFormat.format(double.parse(receipt.totalAmount))}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    ),
  );
}

Future<List<Receipt>> getCustomerReceipt(Customer customer) async {
  List<Receipt> issuedReceipts = await _apiService.getIssuedReceipts();
  if (issuedReceipts != null && issuedReceipts.length > 0) {
    dev.log('This..... ${issuedReceipts.toString()}');

    // FilterReceipts
    issuedReceipts.removeWhere((element) {
      return element.customer.email != customer.email;
    });
    return Future.value(issuedReceipts);
  } else {
    return Future.value();
  }
}

Widget _buildLoadingState() {
  return Center(
    child: CircularProgressIndicator(
      strokeWidth: 1.5,
    ),
  );
}
