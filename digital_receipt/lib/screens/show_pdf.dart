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

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> generateInvoice(PdfPageFormat pageFormat) async {
  final lorem = pw.LoremText();

  final products = <Product>[
    Product('19874', lorem.sentence(4), 3.99, 2),
    Product('98452', lorem.sentence(6), 15, 2),
    Product('28375', lorem.sentence(4), 6.95, 3),
    Product('95673', lorem.sentence(3), 49.99, 4),
    Product('23763', lorem.sentence(2), 560.03, 1),
    Product('55209', lorem.sentence(5), 26, 1),
    Product('09853', lorem.sentence(5), 26, 1),
    Product('23463', lorem.sentence(5), 34, 1),
    Product('56783', lorem.sentence(5), 7, 4),
    Product('78256', lorem.sentence(5), 23, 1),
    Product('23745', lorem.sentence(5), 94, 1),
    Product('07834', lorem.sentence(5), 12, 1),
    Product('23547', lorem.sentence(5), 34, 1),
    Product('98387', lorem.sentence(5), 7.99, 2),
  ];

  final invoice = Invoice(
    invoiceNumber: '982347',
    products: products,
    customerName: 'Abraham Swearegin',
    customerAddress: '54 rue de Rivoli\n75001 Paris, France',
    paymentInfo:
        '4509 Wiseman Street\nKnoxville, Tennessee(TN), 37929\n865-372-0425',
    tax: .15,
    baseColor: PdfColors.teal,
    accentColor: PdfColors.blueGrey900,
  );

  return await invoice.buildPdf(pageFormat);
}

class Invoice {
  Invoice({
    this.products,
    this.customerName,
    this.customerAddress,
    this.invoiceNumber,
    this.tax,
    this.paymentInfo,
    this.baseColor,
    this.accentColor,
  });

  final List<Product> products;
  final String customerName;
  final String customerAddress;
  final String invoiceNumber;
  final double tax;
  final String paymentInfo;
  final PdfColor baseColor;
  final PdfColor accentColor;

  static const _darkColor = PdfColors.blueGrey800;
  static const _lightColor = PdfColors.white;

  PdfColor get _baseTextColor =>
      baseColor.luminance < 0.5 ? _lightColor : _darkColor;

  PdfColor get _accentTextColor =>
      baseColor.luminance < 0.5 ? _lightColor : _darkColor;

  double get _total =>
      products.map<double>((p) => p.total).reduce((a, b) => a + b);

  double get _grandTotal => _total * (1 + tax);

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
    doc.addPage(
      pw.MultiPage(
        pageTheme: _buildTheme(
          pageFormat,
          font1 != null ? pw.Font.ttf(font1) : null,
          font2 != null ? pw.Font.ttf(font2) : null,
          font3 != null ? pw.Font.ttf(font3) : null,
        ),
        build: (context) => [
          _contentHeaderTop(),
          _buildDashSeparator(pageFormat, PdfColor.fromHex('#B6B6B6'),
              height: 1),
          _contentHeaderBottom(),
          pw.Divider(color: PdfColor.fromHex('#E3E3E3')),
          _contentList(context),
          pw.SizedBox(height: 8),
          _contentTotal(context),
          _contentFooter(context),
        ],
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
          color: PdfColor.fromHex('#F2F8FF'),
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
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      mainAxisSize: pw.MainAxisSize.max,
      mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
      children: [
        pw.Container(
          color: PdfColor.fromHex('#539C30'),
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
            'Geek Tutor',
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
            '2118 Thornridge Cir. Syracuse, Connecticut 35624',
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
            'Tel No: (603) 555-0123',
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
            'Email: cfroschauerc@ucoz.ru',
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
              'Date: 17-06-2020',
              style: pw.TextStyle(
                color: PdfColors.black,
                fontSize: 13,
                letterSpacing: 0.03,
                fontWeight: pw.FontWeight.normal,
                height: 1.43,
              ),
            ),
          ),
          pw.Text(
            'Reciept No: 10334',
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
              'Name: Denys Wilacot',
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
              'Email: zpopley3@nifty.com',
              style: pw.TextStyle(
                  color: PdfColors.black,
                  fontSize: 14,
                  letterSpacing: 0.03,
                  fontWeight: pw.FontWeight.normal,
                  height: 1.43),
            ),
          ),
          pw.Text(
            'Phone No: 741-142-4459',
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

  pw.Widget _contentTotal(pw.Context context) {
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
                  '₦80,000',
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

  pw.Widget _contentFooter(pw.Context context) {
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

  pw.Widget _contentList(pw.Context context) {
    return pw.ListView.builder(
      itemCount: 3,
      itemBuilder: (buildContext, index) {
        return _buildProductItem();
      },
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

  pw.Widget _buildProductItem() {
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
                      '1',
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
                    'After effects for dummies course',
                    maxLines: 2,
                    //overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              pw.SizedBox(
                width: 15,
              ),
              pw.Container(
                child: pw.Text('₦50,000'),
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
                  'X 1',
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
                  '₦50,000',
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
}

String _formatCurrency(double amount) {
  return '\$${amount.toStringAsFixed(2)}';
}

String _formatDate(DateTime date) {
  final format = DateFormat.yMMMMd('en_US');
  return format.format(date);
}

class Product {
  const Product(
    this.sku,
    this.productName,
    this.price,
    this.quantity,
  );

  final String sku;
  final String productName;
  final double price;
  final int quantity;
  double get total => price * quantity;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return sku;
      case 1:
        return productName;
      case 2:
        return _formatCurrency(price);
      case 3:
        return quantity.toString();
      case 4:
        return _formatCurrency(total);
    }
    return '';
  }
}
