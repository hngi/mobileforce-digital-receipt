import 'package:digital_receipt/models/customer.dart';
import 'package:digital_receipt/models/receipt.dart';
import 'package:flutter/material.dart';

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
                  Padding(
                     padding: EdgeInsets.fromLTRB(16.0, 0, 16, 16),
                    child: SingleChildScrollView(child: ReceiptTab()),
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
  const ReceiptTab({Key key}) : super(key: key);

  Container _singleReceiptCard(Receipt receipt) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Color(0xFF539C30),
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Container(
        margin: EdgeInsets.only(left: 3.0),
        padding: EdgeInsets.all(8.0),
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
                  receipt.issuedDate,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
              receipt.customerName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(
              height: 4.0,
            ),
            Container(
              width: 250,
              child: Text(
                receipt.description,
              ),
            ),
            SizedBox(
              height: 4.0,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                'Total:\t\t \u{20A6}${receipt.totalAmount}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _singleReceiptCard(
          Receipt(
            receiptNo: '0021',
            issuedDate: '12-06-2020',
            customerName: 'Carole Froschauer',
            description: 'Cryptocurrency course, intro to after effects',
            totalAmount: '80,000',
          ),
        ),
      ],
    );
  }
}
