import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:digital_receipt/models/account.dart';
import 'package:digital_receipt/models/receipt.dart';
import 'package:digital_receipt/providers/business.dart';
import 'package:digital_receipt/screens/generate_pdf.dart';
import 'package:digital_receipt/screens/no_internet_connection.dart';
import 'package:digital_receipt/services/api_service.dart';
import 'package:digital_receipt/services/shared_preference_service.dart';
import 'package:digital_receipt/utils/connected.dart';
import 'package:digital_receipt/widgets/button_loading_indicator.dart';
import 'package:digital_receipt/widgets/receipt_item.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';
import 'package:pdf/widgets.dart' as pw;
import '../constant.dart';
import 'package:intl/intl.dart';

final pdf = pw.Document();

class ReceiptScreenFromCustomer extends StatefulWidget {
  final Receipt receipt;
  final String from;

  const ReceiptScreenFromCustomer({Key key, this.receipt, this.from})
      : super(key: key);

  @override
  _ReceiptScreenFromCustomerState createState() =>
      _ReceiptScreenFromCustomerState();
}

GlobalKey _globalKey = new GlobalKey();
Uint8List receiptPdf;

class _ReceiptScreenFromCustomerState extends State<ReceiptScreenFromCustomer> {
  Future<Uint8List> receiptPdfFuture;

  bool _loading = false;
  String logo;
  /*void generatePdf(BuildContext context) async {
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '$dir/receipt.pdf';
    final File file = File(path);
    final invoice = await generateInvoice(PdfPageFormat.a4);
    await file.writeAsBytes(invoice);

    await shareFile(invoice);
//  Navigator.push(context,
//      MaterialPageRoute(builder: (_) => PdfViewerScreen(path: path)));
  }*/

  Future<void> savePdf(Uint8List pdf) async {
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '$dir/receipt.pdf';
    final File file = File(path);
    await file.writeAsBytes(pdf);
    receiptPdf = pdf;
  }

  init() async {
    var val = await SharedPreferenceService().getStringValuesSF('LOGO');
    setState(() {
      logo = val;
    });
  }

  @override
  void initState() {
    super.initState();
    init();
    receiptPdfFuture = generatePdf(
      pageFormat: PdfPageFormat.a4,
      receipt: Provider.of<Receipt>(context, listen: false),
      accountData: Provider.of<Business>(context, listen: false).accountData,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ApiService _apiService = ApiService();
    return Scaffold(
      backgroundColor: Color(0xFFF2F8FF),
      appBar: AppBar(
        //  backgroundColor: Color(0xFF0b56a7),
        automaticallyImplyLeading: true,
        title: Text(
          'Create Receipt',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat',
            letterSpacing: 0.03,
          ),
        ),
      ),
      body: FutureBuilder<Uint8List>(
        future: receiptPdfFuture,
        builder: (context, snapshot) {
          Widget body;
          if (snapshot.hasData) {
            savePdf(snapshot.data);
            body = SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    ReceiptScreenLayout(context, _loading, logo, widget.from,
                        () {
                      setState(() {
                        _loading = true;
                      });
                    }, () {
                      setState(() {
                        _loading = false;
                      });
                    })
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            body = Column(
              children: <Widget>[
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                )
              ],
            );
          } else {
            body = Column(
              children: <Widget>[
                SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting result...'),
                )
              ],
            );
          }
          return body;
        },
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget ReceiptScreenLayout(
    [BuildContext context,
    bool loading,
    String logo,
    String from,
    Function loadingStart,
    Function loadingStop]) {
  Future sendMail() async {
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '$dir/receipt.pdf';
    MailOptions mailOptions = MailOptions();
    mailOptions = MailOptions(
      body: "Receipt issued",
      subject: "new Receipt",
      recipients: [
        Provider.of<Receipt>(context, listen: false).customer.email.toString()
      ],
      isHTML: false,
      attachments: [path],
    );
    String platformResponse;

    try {
      await FlutterMailer.send(mailOptions);
      platformResponse = "success";
      print(platformResponse);
    } catch (e) {
      platformResponse = "failed";
      print(platformResponse);
      print("error: $e");
    }
  }

  sendPDF(BuildContext context) async {
    print('inside');
    RenderRepaintBoundary boundary =
        _globalKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    var pngBytes = byteData.buffer.asUint8List();

    final images = PdfImage.file(
      pdf.document,
      bytes: pngBytes,
    );

    pdf.addPage(pw.Page(build: (pw.Context context) {
      return pw.Center(
        child: pw.Image(images),
      ); // Center
    }));

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/receipt.pdf");

    var f = await file.writeAsBytes(pdf.save());
    print(f);

    var res = await ApiService().sendPDF(
        Provider.of<Receipt>(context, listen: false).customer.email.toString(),
        file.path,
        'Receipt from Degeit');

    return res;
  }

  final ApiService _apiService = ApiService();
  final AccountData businessInfo =
      Provider.of<Business>(context, listen: false).accountData;
  return Column(children: <Widget>[
    SizedBox(
      height: 14,
    ),
    Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'All Done, share!',
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    SizedBox(
      height: 24,
    ),

    //Main part of the receipt page

    RepaintBoundary(
      key: _globalKey,
      child: Container(
        // margin: EdgeInsets.fromLTRB(10,20,10,20),
        padding: EdgeInsets.all(0),
        alignment: Alignment.topCenter,
        // width: 325,
        decoration: BoxDecoration(
          //  color: Color(int.parse("0xFF"+Provider.of<Receipt>(context,listen: false).primaryColorHexCode)),
          border: Border.all(
            color: Colors.grey[500],
          ),
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      color: Color(int.parse("0xFF" +
                          Provider.of<Receipt>(context, listen: false)
                              .primaryColorHexCode)),
                      height: 13,
                      width: double.infinity,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 15,
                                ),
                                Container(

                                    //padding: const EdgeInsets.all(10),

                                    child: Text(
                                  businessInfo.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                )),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  businessInfo.address,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13,
                                      letterSpacing: 0.03,
                                      height: 1.43),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Tel No: ${businessInfo.phone}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal,
                                      letterSpacing: 0.03,
                                      height: 1.43),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Email: ${businessInfo.email}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      letterSpacing: 0.03,
                                      fontWeight: FontWeight.normal,
                                      height: 1.43),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: logo != null && logo.isNotEmpty
                              ? Image.file(
                                  File(logo),
                                  height: 50,
                                  width: 50,
                                )
                              : SizedBox.shrink(),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DashedSeparator(
                      color: Color(0xFFB6B6B6),
                      height: 1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Text(
                              "Date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(Provider.of<Receipt>(context, listen: false).issuedDate))} ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                letterSpacing: 0.03,
                                fontWeight: FontWeight.normal,
                                height: 1.43,
                              ),
                            ),
                          ),
                          Text(
                            'Receipt No : ' +
                                Provider.of<Receipt>(context, listen: false)
                                    .receiptNo
                                    .toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                letterSpacing: 0.03,
                                fontWeight: FontWeight.normal,
                                height: 1.43),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                            child: Text(
                              'Customer Information',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Text(
                              'Name: ' +
                                  Provider.of<Receipt>(context, listen: false)
                                      .customer
                                      .name
                                      .toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  letterSpacing: 0.03,
                                  fontWeight: FontWeight.normal,
                                  height: 1.43),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Text(
                              'Email: ' +
                                  Provider.of<Receipt>(context, listen: false)
                                      .customer
                                      .email
                                      .toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  letterSpacing: 0.03,
                                  fontWeight: FontWeight.normal,
                                  height: 1.43),
                            ),
                          ),
                          Text(
                            'Phone No: ' +
                                Provider.of<Receipt>(context, listen: false)
                                    .customer
                                    .phoneNumber
                                    .toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                letterSpacing: 0.03,
                                fontWeight: FontWeight.normal,
                                height: 1.43),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 25),
                            child: Text(
                              'Product details',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    ReceiptItem(),
                    SizedBox(
                      //toatal payment and stamp

                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            width: 1,
                          ),
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Text(
                                  'Total',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    letterSpacing: 0.03,
                                    fontWeight: FontWeight.normal,
                                    height: 1.43,
                                  ),
                                ),
                              ),
                              Provider.of<Receipt>(context, listen: false)
                                          .paidStamp !=
                                      false
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: SizedBox(
                                        height: 65,
                                        width: 65,
                                        child: kPaidStamp(Provider.of<Receipt>(
                                                context,
                                                listen: false)
                                            .primaryColorHexCode
                                            .toLowerCase()),
                                      ),
                                    )
                                  : Container(),
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Text(
                                  Provider.of<Receipt>(context, listen: false)
                                          .getCurrency()
                                          .currencySymbol +
                                      Provider.of<Receipt>(context,
                                              listen: false)
                                          .getTotal()
                                          .toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    letterSpacing: 0.03,
                                    fontWeight: FontWeight.w600,
                                    height: 1.43,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 15),
                      child: Column(
                        children: <Widget>[
                          Text(
                            (businessInfo.name
                                  .split(" ")[0]
                                  .toLowerCase()
                                    .toString()
                                    .split(" ")[0])
                                .toLowerCase(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 27,
                              letterSpacing: 0.03,
                              fontFamily: 'Southampton',
                              fontWeight: FontWeight.w300,
                              height: 1.43,
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Container(
                            height: 1,
                            color: Color(0xFFE3E3E3),
                            width: 107,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            'Signature',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              letterSpacing: 0.03,
                              fontWeight: FontWeight.w300,
                              height: 1.43,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ))
              ],
            ),
          ],
        ),
      ),
    ),

    //SIGNATURE section

    //SHARE BUTTON
    SizedBox(
      height: 45,
    ),
    /* SizedBox(
      width: double.infinity,
      height: 45,
      child: FlatButton(
        //padding: EdgeInsets.all(5.0),
        color: Colors.white,
        textTheme: ButtonTextTheme.primary,
        //minWidth: 350,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          'Send',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        onPressed: () async {
          await sendMail();
          bool load = true;
          // await  _apiService.saveReceipt();

          Provider.of<Receipt>(context, listen: false).showJson();
          Provider.of<Receipt>(context, listen: false).saveReceipt();
        },
      ),
    ), */
    SizedBox(
      height: 15,
    ),
    SizedBox(
      width: double.infinity,
      height: 45,
      child: FlatButton(
        //padding: EdgeInsets.all(5.0),
        color: Color(0xFF0b56a7),
        textTheme: ButtonTextTheme.primary,
        //minWidth: 350,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: loading == false
            ? Text(
                'Share',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              )
            : ButtonLoadingIndicator(
                color: Colors.white, height: 20, width: 20),
        onPressed: () async {
          //take this action
          //print(Provider.of<Receipt>(context, listen: false));
          //await shareFile();
          loadingStart();
          var connected = await Connected().checkInternet();
          if (!connected) {
            await showDialog(
              context: context,
              builder: (context) {
                return NoInternet();
              },
            );
            loadingStop();
            return;
          }
          if (from == null) {
            var res = await Provider.of<Receipt>(context, listen: false)
                .updatedReceipt(
                    Provider.of<Receipt>(context, listen: false).receiptId);

            if (res == 200) {
              await sendPDF(context);
              loadingStop();
            }
          }else if(from == 'receipt_history'){
             await sendPDF(context);
              loadingStop();
          }
        },
      ),
    ),
    SizedBox(
      height: 15,
    ),
  ]);
}

Future<void> shareFile() async {
  try {
    await Share.file('Receipt', 'receipt.pdf', receiptPdf, 'application/pdf',
        text: 'My optional text.');
  } catch (e) {
    print('error: $e');
  }
}

class DashedSeparator extends StatelessWidget {
  final double height;
  final Color color;

  const DashedSeparator({this.height = 1, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
