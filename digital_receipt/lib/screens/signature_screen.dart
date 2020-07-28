import 'dart:typed_data';
import 'dart:convert';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:digital_receipt/screens/account_page.dart';
import 'package:digital_receipt/screens/home_page.dart';
import 'package:digital_receipt/services/CarouselIndex.dart';
import 'package:digital_receipt/services/shared_preference_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui' as ui;
import 'package:signature/signature.dart';
import 'package:flutter/rendering.dart';

class SignatureScreen extends StatefulWidget {
  SignatureScreen({
    this.carouselController,
    this.carouselIndex,
  });

  // update signature
  bool updateSignature;
  SignatureScreen.update({
    this.updateSignature,
    this.carouselController,
    this.carouselIndex,
  });

  ///
  final CarouselController carouselController;
  final CarouselIndex carouselIndex;
  bool update;

  @override
  _SignatureScreenState createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => print("Value changed"));
  }

  SharedPreferenceService _preferenceService = SharedPreferenceService();

  ui.Image signatureImage;
  GlobalKey<_SignatureCanvasState> signatureCanvasKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
              child: Container(
          padding: EdgeInsets.all(16.0),
          child: Wrap(
            children: <Widget>[
              SizedBox(
                height: 14,
              ),
              Text('Append your signature',
                  style: Theme.of(context).textTheme.headline5),
              SizedBox(
                height: 5,
              ),
              Text('Provide your signature on the grey area below',
                  style: Theme.of(context).textTheme.subtitle2),
              SizedBox(
                height: 24,
              ),
              // Container(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: <Widget>[
              //       // Row(
              //       //   children: map<Widget>([0, 1, 2, 3], (index, url) {
              //       //     print(index);
              //       //     return GestureDetector(
              //       //       onTap: () {
              //       //         widget.carouselController.animateToPage(index);
              //       //       },
              //       //       child: Row(
              //       //         children: <Widget>[
              //       //           Container(
              //       //             height: 2,
              //       //             width: 10,
              //       //             decoration: BoxDecoration(
              //       //                 borderRadius: BorderRadius.circular(5),
              //       //                 color: widget.carouselIndex.index == index
              //       //                     ? Theme.of(context).accentColor
              //       //                     : Theme.of(context).disabledColor,
              //       //                 boxShadow: [
              //       //                   BoxShadow(
              //       //                       offset: Offset(0, 3),
              //       //                       blurRadius: 6,
              //       //                       color: Color.fromRGBO(0, 0, 0, 0.16))
              //       //                 ]),
              //       //           ),
              //       //           index != 3 ? SizedBox(width: 10) : SizedBox.shrink()
              //       //         ],
              //       //       ),
              //       //     );
              //       //   }),
              //       // ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 24,
              // ),

              // SignatureCanvas(key: signatureCanvasKey),
              //SIGNATURE CANVAS
              Signature(
                key: signatureCanvasKey,
                controller: _controller,
                height: 350,
                backgroundColor: Colors.blueGrey[100],
              ),
              SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
      persistentFooterButtons: <Widget>[
        SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "Add your signature",
                      style: TextStyle(
                        color: Color(0xff226EBE),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                        letterSpacing: 0.03,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: FlatButton(
                    child: Text(
                      "Clear",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                        letterSpacing: 0.03,
                      ),
                    ),
                    onPressed: () {
                      setState(() => _controller.clear());
                    },

                    // onPressed: () {
                    //   signatureCanvasKey.currentState.clearPoints();
                    // },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: FlatButton(
                    child: Text(
                      "Done",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                        letterSpacing: 0.03,
                      ),
                    ),
                    onPressed: () async {
                      if (_controller.isNotEmpty) {
                        saveImage(context);
                      }
                      //widget.carouselController.animateToPage(2);
                    },
                  ),
                )
              ],
            ))
      ],
    );
  }

  saveImage(BuildContext context) async {
    showImage(context);

    var data = await _controller.toPngBytes();
    String encode = base64Encode(data.buffer.asUint8List());
    _preferenceService.addStringToSF("ISSUER_SIGNATURE", encode);
  }

  Future<Null> showImage(BuildContext context) async {
    var data = await _controller.toPngBytes();
    print(data);
    String encode = base64Encode(data.buffer.asUint8List());
    return showDialog<Null>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Success!",
              style: TextStyle(
                color: Colors.green,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Montserrat',
                letterSpacing: 0.03,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  color: Colors.white60,
                  child: Image.memory(
                    base64Decode(encode),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FlatButton(
                    onPressed: () {
                      if (widget.updateSignature == true) {
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AccountPage()),
                        );
                        Fluttertoast.showToast(
                            msg: "signature updated successfully",
                            toastLength: Toast.LENGTH_LONG);
                      } else {
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      }
                    },
                    child: Text(
                      'DONE',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class SignatureCanvas extends StatefulWidget {
  SignatureCanvas({Key key}) : super(key: key);
  @override
  _SignatureCanvasState createState() => _SignatureCanvasState();
}

class _SignatureCanvasState extends State<SignatureCanvas> {
  List<Offset> _points = <Offset>[];

  Future<ui.Image> get rendered {
    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);
    SignaturePainter painter = SignaturePainter(points: _points);
    var size = context.size;
    painter.paint(canvas, size);
    return recorder
        .endRecording()
        .toImage(size.width.floor(), size.height.floor());
  }

  @override
  Widget build(BuildContext context) {
    Size appSize = MediaQuery.of(context).size;
    return GestureDetector(
      onPanUpdate: (DragUpdateDetails details) {
        setState(() {
          RenderBox _object = context.findRenderObject();
          Offset _locationPoints =
              _object.localToGlobal(details.globalPosition);
          _points = new List.from(_points)..add(_locationPoints);
        });
      },
      onPanEnd: (DragEndDetails details) {
        setState(() {
          _points.add(null);
        });
      },
      child: Container(
        color: Colors.blueGrey[100],
        height: 350,
        width: MediaQuery.of(context).size.width,
        child: CustomPaint(
          painter: SignaturePainter(points: _points, dimensions: appSize),
        ),
      ),
    );
  }

  void clearPoints() {
    setState(() {
      _points.clear();
    });
  }
}

class SignaturePainter extends CustomPainter {
  List<Offset> points = <Offset>[];
  Size dimensions;
  SignaturePainter({this.points, this.dimensions});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.square
      ..strokeWidth = 5.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        // Offset ofsett = Offset();
        // print(size.height);

        Offset dx = points[i]
            .translate(2, dimensions == null ? -280 : -dimensions.height / 2.3);
        Offset dy = points[i + 1]
            .translate(2, dimensions == null ? -280 : -dimensions.height / 2.3);

        canvas.drawLine(dx, dy, paint);
      }
    }
  }

  @override
  bool shouldRepaint(SignaturePainter oldDelegate) {
    return oldDelegate.points != points;
  }
}
