/*
 * Copyright (C) 2017, David PHAM-VAN <dev.nfet.net@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// ignore_for_file: always_specify_types

import 'dart:typed_data';

import 'package:digital_receipt/models/account.dart';
import 'package:digital_receipt/models/product.dart';
import 'package:digital_receipt/models/receipt.dart';
import 'package:digital_receipt/providers/business.dart';
import 'package:digital_receipt/utils/receipt_util.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';

Future<Uint8List> generatePdf(
    {PdfPageFormat pageFormat,
    Receipt receipt,
    AccountData accountData}) async {
  final lorem = pw.LoremText();

  final invoice = Invoice(receipt, accountData);

  return await invoice.buildPdf(pageFormat);
}

class Invoice {
  final Receipt receipt;
  final AccountData accountData;
  Invoice(this.receipt, this.accountData);

  static final _backgroundColor = PdfColor.fromHex('#F2F8FF');
  static const _lightColor = PdfColors.white;
  /*
  THERE IS A BUG HERE I DON'T KNOW HOW TO FIX IT THE TOTAL AMOUNT IS NULL I DON'T KNOW WHY
*/

  double get _total => receipt.products.map<double>((p) {
        if (p.amount != null) {
          return p.amount.roundToDouble();
        } else {
          return (p.unitPrice * p.quantity);
        }
      }).reduce((a, b) => a + b);

  //double get _grandTotal => _total * (1 + tax);

  PdfImage _paidStamp;

  Future<Uint8List> buildPdf(PdfPageFormat pageFormat) async {
    // Create a PDF document.
    final doc = pw.Document();

    final font1 =
        await rootBundle.load('assets/fonts/Montserrat/Montserrat-Regular.ttf');
    final font2 =
        await rootBundle.load('assets/fonts/Montserrat/Montserrat-Bold.ttf');
    final font3 =
        await rootBundle.load('assets/fonts/Montserrat/Montserrat-Italic.ttf');

    _paidStamp = PdfImage.file(
      doc.document,
      bytes: (await rootBundle.load('assets/images/paid-stamp.png'))
          .buffer
          .asUint8List(),
    );

    // Add page to the PDF
    List<pw.Widget> contents;

    contents = [
      // Top contents first
      _contentHeaderTop(),
      _buildDashSeparator(pageFormat, PdfColor.fromHex('#B6B6B6'), height: 1),
      _contentHeaderBottom(),
      pw.Divider(color: PdfColor.fromHex('#E3E3E3')),
    ];

    // Product list at the middle
    contents.addAll(_contentList());

    // Finally the bottom part
    contents.addAll(
      <pw.Widget>[
        pw.SizedBox(height: 8),
        _contentTotal(),
        _contentFooter(),
      ],
    );

    // This is done to avoid pagebreak distortion on the pdf file

    doc.addPage(
      pw.MultiPage(
        pageTheme: _buildTheme(
          pageFormat,
          font1 != null ? pw.Font.ttf(font1) : null,
          font2 != null ? pw.Font.ttf(font2) : null,
          font3 != null ? pw.Font.ttf(font3) : null,
        ),
        build: (context) => contents,
      ),
    );

    // Return the PDF file content
    return doc.save();
  }

  pw.PageTheme _buildTheme(
      PdfPageFormat pageFormat, pw.Font base, pw.Font bold, pw.Font italic) {
    return pw.PageTheme(
      pageFormat: pageFormat,
      theme: pw.ThemeData.withFont(
        base: base,
        bold: bold,
        italic: italic,
      ),
      buildBackground: (context) => pw.FullPage(
        ignoreMargins: true,
        child: pw.Container(
          color: _backgroundColor,
          /*child: pw.Stack(
            children: [
              pw.Positioned(
                bottom: 0,
                left: 0,
                child: pw.Container(
                  height: 20,
                  width: pageFormat.width / 2,
                  decoration: pw.BoxDecoration(
                    gradient: pw.LinearGradient(
                      colors: [baseColor, PdfColors.white],
                    ),
                  ),
                ),
              ),
              pw.Positioned(
                bottom: 20,
                left: 0,
                child: pw.Container(
                  height: 20,
                  width: pageFormat.width / 4,
                  decoration: pw.BoxDecoration(
                    gradient: pw.LinearGradient(
                      colors: [accentColor, PdfColors.white],
                    ),
                  ),
                ),
              ),
              pw.Positioned(
                top: pageFormat.marginTop + 72,
                left: 0,
                right: 0,
                child: pw.Container(
                  height: 3,
                  color: baseColor,
                ),
              ),
            ],
          ),*/
        ),
      ),
    );
  }

  pw.Widget _contentHeaderTop() {
    /* final AccountData businessInfo =
      Provider.of<Business>(context, listen: false).accountData; */
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      mainAxisSize: pw.MainAxisSize.max,
      mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
      children: [
        pw.Container(
          color: receipt.primaryColorHexCode != null
              ? PdfColor.fromHex(receipt.primaryColorHexCode)
              : _backgroundColor,
          height: 13,
          width: double.infinity,
        ),
        pw.SizedBox(
          height: 15,
        ),
        pw.Container(
            //padding: const EdgeInsets.all(10),
            child: pw.Center(
          child: pw.Text(
            accountData.name,
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 16,
            ),
          ),
        )),
        pw.SizedBox(
          height: 5,
        ),
        pw.Center(
          child: pw.Text(
            accountData.address,
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
                color: PdfColors.black,
                fontWeight: pw.FontWeight.normal,
                fontSize: 13,
                letterSpacing: 0.03,
                height: 1.43),
          ),
        ),
        pw.SizedBox(
          height: 5,
        ),
        pw.Center(
          child: pw.Text(
            'Tel No: ${accountData.phone}',
            style: pw.TextStyle(
                color: PdfColors.black,
                fontSize: 13,
                fontWeight: pw.FontWeight.normal,
                letterSpacing: 0.03,
                height: 1.43),
          ),
        ),
        pw.SizedBox(
          height: 5,
        ),
        pw.Center(
          child: pw.Text(
            'Email: ${accountData.email}',
            style: pw.TextStyle(
                color: PdfColors.black,
                fontSize: 13,
                letterSpacing: 0.03,
                fontWeight: pw.FontWeight.normal,
                height: 1.43),
          ),
        ),
        pw.SizedBox(
          height: 20,
        ),
      ],
    );
  }

  pw.Widget _contentHeaderBottom() {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(10.0),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: <pw.Widget>[
          pw.SizedBox(
            height: 10,
          ),
          pw.Container(
            padding: pw.EdgeInsets.only(bottom: 8),
            child: pw.Text(
              'Date: ${receipt.issuedDate}',
              style: pw.TextStyle(
                color: PdfColors.black,
                fontSize: 13,
                letterSpacing: 0.03,
                fontWeight: pw.FontWeight.normal,
                height: 1.43,
              ),
            ),
          ),
          receipt.receiptNo == null
              ? pw.SizedBox.shrink()
              : pw.Text(
                  'Reciept No: ${receipt.receiptNo}',
                  style: pw.TextStyle(
                      color: PdfColors.black,
                      fontSize: 13,
                      letterSpacing: 0.03,
                      fontWeight: pw.FontWeight.normal,
                      height: 1.43),
                ),
          pw.Container(
            padding: pw.EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: pw.Text(
              'Customer Information',
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          pw.Container(
            padding: pw.EdgeInsets.only(bottom: 8),
            child: pw.Text(
              'Name: ${receipt.customer.name}',
              style: pw.TextStyle(
                  color: PdfColors.black,
                  fontSize: 14,
                  letterSpacing: 0.03,
                  fontWeight: pw.FontWeight.normal,
                  height: 1.43),
            ),
          ),
          pw.Container(
            padding: pw.EdgeInsets.only(bottom: 8),
            child: pw.Text(
              'Email: ${receipt.customer.email}',
              style: pw.TextStyle(
                  color: PdfColors.black,
                  fontSize: 14,
                  letterSpacing: 0.03,
                  fontWeight: pw.FontWeight.normal,
                  height: 1.43),
            ),
          ),
          pw.Text(
            'Phone No: ${receipt.customer.phoneNumber}',
            style: pw.TextStyle(
                color: PdfColors.black,
                fontSize: 14,
                letterSpacing: 0.03,
                fontWeight: pw.FontWeight.normal,
                height: 1.43),
          ),
          pw.Container(
            padding: pw.EdgeInsets.only(top: 25),
            child: pw.Text(
              'Product details',
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<pw.Widget> _contentList() {
    List<pw.Widget> items = [];
    for (int i = 0; i < receipt.products.length; i++) {
      items.add(_buildProductItem(i));
    }
    return items;
  }

  pw.Widget _buildProductItem(int index) {
    Product thisProduct = receipt.products[index];
    return pw.Column(
      children: <pw.Widget>[
        pw.Padding(
          padding: const pw.EdgeInsets.fromLTRB(10.0, 10, 10, 5),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: <pw.Widget>[
              pw.Row(
                children: <pw.Widget>[
                  pw.Padding(
                    padding: const pw.EdgeInsets.fromLTRB(0, 0, 8, 0),
                    child: pw.Text(
                      '${index + 1}',
                      style: pw.TextStyle(
                          color: PdfColors.black,
                          fontSize: 13,
                          letterSpacing: 0.03,
                          fontWeight: pw.FontWeight.normal,
                          height: 1.43),
                    ),
                  ),
                  pw.Text(
                    'Description',
                    style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 10,
                        letterSpacing: 0.03,
                        fontWeight: pw.FontWeight.normal,
                        height: 1.43),
                  ),
                ],
              ),
              pw.Text(
                'Unit Price',
                style: pw.TextStyle(
                    color: PdfColors.black,
                    fontSize: 10,
                    letterSpacing: 0.03,
                    fontWeight: pw.FontWeight.normal,
                    height: 1.43),
              ),
            ],
          ),
        ),
        pw.Padding(
          padding: pw.EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: <pw.Widget>[
              pw.Expanded(
                //flex: 3,
                child: pw.Container(
                  padding: const pw.EdgeInsets.fromLTRB(23, 0, 0, 10),
                  child: pw.Text(
                    '${thisProduct.productDesc}',
                    maxLines: 2,
                    //overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              pw.SizedBox(
                width: 15,
              ),
              pw.Container(
                child: pw.Text('₦${Utils.formatNumber(thisProduct.unitPrice)}'),
              ),
            ],
          ),
        ),

        //quantity of products order and the total price (HEADER)

        pw.Padding(
          padding: const pw.EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: <pw.Widget>[
              pw.Expanded(
                  child: pw.Container(
                padding: const pw.EdgeInsets.fromLTRB(23, 0, 8, 0),
                child: pw.Text(
                  'Qty',
                  style: pw.TextStyle(
                      color: PdfColors.black,
                      fontSize: 10,
                      letterSpacing: 0.03,
                      fontWeight: pw.FontWeight.normal,
                      height: 1.43),
                ),
              )),
              pw.Container(
                child: pw.Text(
                  'Total',
                  style: pw.TextStyle(
                      color: PdfColors.black,
                      fontSize: 10,
                      letterSpacing: 0.03,
                      fontWeight: pw.FontWeight.normal,
                      height: 1.43),
                ),
              ),
            ],
          ),
        ),
        pw.SizedBox(
          height: 5,
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: <pw.Widget>[
              pw.Expanded(
                  child: pw.Container(
                padding: const pw.EdgeInsets.fromLTRB(23, 0, 8, 0),
                child: pw.Text(
                  'X${thisProduct.quantity}',
                  style: pw.TextStyle(
                    color: PdfColors.black,
                    fontSize: 14,
                    letterSpacing: 0.03,
                    fontWeight: pw.FontWeight.normal,
                    height: 1.43,
                  ),
                ),
              )),
              pw.Container(
                child: pw.Text(
                  "${productAmount(thisProduct)}",
                  style: pw.TextStyle(
                    color: PdfColors.black,
                    fontSize: 14,
                    letterSpacing: 0.03,
                    fontWeight: pw.FontWeight.normal,
                    height: 1.43,
                  ),
                ),
              ),
            ],
          ),
        ),
        pw.Divider(color: PdfColor.fromHex('#E3E3E3')),
      ],
    );
  }

  pw.Widget _contentTotal() {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(right: 10.0),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: <pw.Widget>[
          pw.SizedBox(
            width: 1,
          ),
          pw.Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: <pw.Widget>[
              pw.Padding(
                padding: const pw.EdgeInsets.only(top: 15.0),
                child: pw.Text(
                  'Total',
                  style: pw.TextStyle(
                    color: PdfColors.black,
                    fontSize: 14,
                    letterSpacing: 0.03,
                    fontWeight: pw.FontWeight.normal,
                    height: 1.43,
                  ),
                ),
              ),
              pw.Image(_paidStamp),
              pw.Padding(
                padding: const pw.EdgeInsets.only(top: 15.0),
                child: pw.Text(
                  '₦${Utils.formatNumber(_total)}',
                  style: pw.TextStyle(
                    color: PdfColors.black,
                    fontSize: 14,
                    letterSpacing: 0.03,
                    fontWeight: pw.FontWeight.bold,
                    height: 1.43,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

/*
  THERE IS A BUG HERE I DON'T KNOW HOW TO FIX IT THE TOTAL AMOUNT IS NULL I DON'T KNOW WHY
*/
  String productAmount(Product product) {
    if (product.amount != null) {
      print("product amount ${product.amount}");
      return '₦${Utils.formatNumber(product.amount)}';
    } else {
      print("product amount ${product.amount}");
      return '₦${Utils.formatNumber((product.unitPrice * product.quantity))}';
    }
  }

  pw.Widget _contentFooter() {
    return pw.Padding(
      padding: const pw.EdgeInsets.fromLTRB(10, 0, 0, 15),
      child: pw.Column(
        children: <pw.Widget>[
          pw.Text(
            'Denny',
            style: pw.TextStyle(
              color: PdfColors.black,
              fontSize: 27,
              letterSpacing: 0.03,
              //fontFamily: 'Southampton',
              fontWeight: pw.FontWeight.normal,
              height: 1.43,
            ),
          ),
          pw.SizedBox(
            height: 2,
          ),
          pw.Container(
            height: 1,
            color: PdfColor.fromHex('#E3E3E3'),
            width: 107,
          ),
          pw.SizedBox(
            height: 2,
          ),
          pw.Text(
            'Signature',
            style: pw.TextStyle(
              color: PdfColors.black,
              fontSize: 13,
              letterSpacing: 0.03,
              fontWeight: pw.FontWeight.normal,
              height: 1.43,
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildDashSeparator(PdfPageFormat pageFormat, PdfColor color,
      {double height}) {
    final boxWidth = pageFormat.width;
    final dashWidth = 10.0;
    final dashHeight = height;
    final dashCount = (boxWidth / (2 * dashWidth)).floor();

    final List<pw.SizedBox> dashes = [];

    for (int i = 0; i < dashCount; i++) {
      dashes.add(pw.SizedBox(
        width: dashWidth,
        height: dashHeight,
        child: pw.DecoratedBox(
          decoration: pw.BoxDecoration(color: color),
        ),
      ));
    }

    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: dashes,
    );
  }
}

String _formatCurrency(double amount) {
  return '\$${amount.toStringAsFixed(2)}';
}

String _formatDate(DateTime date) {
  final format = DateFormat.yMMMMd('en_US');
  return format.format(date);
}
