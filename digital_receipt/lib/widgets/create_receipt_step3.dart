import 'dart:typed_data';
import 'dart:convert';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:digital_receipt/services/CarouselIndex.dart';
import 'package:digital_receipt/services/shared_preference_service.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';

class SellerSignatureScreen extends StatefulWidget {
  SellerSignatureScreen({
    this.carouselController,
    this.carouselIndex,
  });
  final CarouselController carouselController;
  final CarouselIndex carouselIndex;

  @override
  _SellerSignatureScreenState createState() => _SellerSignatureScreenState();
}

class _SellerSignatureScreenState extends State<SellerSignatureScreen> {
  SharedPreferenceService _preferenceService = SharedPreferenceService();

  ui.Image signatureImage;
  GlobalKey<_SignatureCanvasState> signatureCanvasKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    List<T> map<T>(List list, Function handler) {
      List<T> result = [];
      for (var i = 0; i < list.length; i++) {
        result.add(handler(i, list[i]));
      }
      return result;
    }

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
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
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: map<Widget>([0, 1, 2, 3], (index, url) {
                      print(index);
                      return GestureDetector(
                        onTap: () {
                          widget.carouselController.animateToPage(index);
                        },
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 2,
                              width: 10,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: widget.carouselIndex.index == index
                                      ? Theme.of(context).accentColor
                                      : Theme.of(context).disabledColor,
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 3),
                                        blurRadius: 6,
                                        color: Color.fromRGBO(0, 0, 0, 0.16))
                                  ]),
                            ),
                            index != 3 ? SizedBox(width: 10) : SizedBox.shrink()
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            SignatureCanvas(key: signatureCanvasKey),
            SizedBox(
              height: 24,
            ),
          ],
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
                      signatureCanvasKey.currentState.clearPoints();
                    },
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
                    onPressed: () {
                      saveImage(context);
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
    ui.Image renderedImage = await signatureCanvasKey.currentState.rendered;
    print(renderedImage.toByteData().toString());

    setState(() {
      signatureImage = renderedImage;
    });

    showImage(context);
    ByteData pngBytes =
        await signatureImage.toByteData(format: ui.ImageByteFormat.png);
    // function to be performed on gotten image to be placed below
    String encode = base64Encode(pngBytes.buffer.asUint8List());
    _preferenceService.addStringToSF("ISSUER_SIGNATURE", encode);
  }

  Future<Null> showImage(BuildContext context) async {
    ByteData pngBytes =
        await signatureImage.toByteData(format: ui.ImageByteFormat.png);
    print(pngBytes);
    String encode = base64Encode(pngBytes.buffer.asUint8List());
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
                      Navigator.pop(context);
                      widget.carouselController.animateToPage(3);
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
