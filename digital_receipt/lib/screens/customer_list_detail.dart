import 'dart:developer' as dev;
import 'dart:math';

import 'package:digital_receipt/models/customer.dart';
import 'package:digital_receipt/models/receipt.dart';
import 'package:digital_receipt/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constant.dart';

final ApiService _apiService = ApiService();
final numberFormat = new NumberFormat("\u20A6#,##0.#", "en_US");
final dateFormat = DateFormat('dd-MM-yyyy');

class CustomerDetail extends StatefulWidget {
  final Customer customer;

  CustomerDetail({Key key, this.customer}) : super(key: key);

  @override
  _CustomerDetailState createState() => _CustomerDetailState();
}

class _CustomerDetailState extends State<CustomerDetail> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Customer List',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: 'Montserrat',
              letterSpacing: 0.03,
            ),
          ),
          backgroundColor: Color(0xFF0B57A7),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 16,
                left: 16,
                right: 16,
              ),
              child: TabBar(
                labelColor: Colors.grey[700],
                unselectedLabelColor: Colors.black,
                labelStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                ),
                indicatorColor: Color(0xFF0B57A7),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(label),
          SizedBox(
            height: 8.0,
          ),
          TextFormField(
            initialValue: initialValue,
            readOnly: readOnly,
            style: TextStyle(
              color: Color(0xFF2B2B2B),
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Montserrat',
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Color(0xFFC8C8C8),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(),
              errorStyle: TextStyle(height: 0.5),
            ),
          ),
        ],
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
            content = _buildReceiptList(snapshot.data);
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
Widget _buildReceiptList(List<Receipt> customerReceiptList) => ListView.builder(
      itemCount: customerReceiptList.length,
      padding: EdgeInsets.fromLTRB(16.0, 0, 16, 0),
      itemBuilder: (_, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: _buildReceiptCard(customerReceiptList[index]),
      ),
    );

Container _buildReceiptCard(Receipt receipt) {
  return Container(
    decoration: BoxDecoration(
      color: Color(0xFF539C30),
      borderRadius: BorderRadius.circular(5.0),
    ),
    child: Container(
      margin: EdgeInsets.only(left: 5.0),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFFE3EAF1),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Receipt No: ${receipt.receiptNo}',
                style: TextStyle(color: Colors.grey[600]),
              ),
              Text(
                dateFormat.format(DateTime.parse(receipt.issuedDate)),
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            receipt.customerName,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
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
