import 'dart:typed_data';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:digital_receipt/services/CarouselIndex.dart';
import 'package:digital_receipt/services/shared_preference_service.dart';
import 'package:digital_receipt/widgets/submit_button.dart';
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
            Text(
              'Append your signature',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
                fontSize: 22,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Provide your signature on the grey area below',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w300,
                letterSpacing: 0.3,
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: map<Widget>([1, 1, 2], (index, url) {
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
                                      ? Color(0xFF25CCB3)
                                      : Color.fromRGBO(0, 0, 0, 0.12),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 3),
                                        blurRadius: 6,
                                        color: Color.fromRGBO(0, 0, 0, 0.16))
                                  ]),
                            ),
                            index != 2 ? SizedBox(width: 10) : SizedBox.shrink()
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

    setState(() {
      signatureImage = renderedImage;
    });

    showImage(context);
    var pngBytes =
        await signatureImage.toByteData(format: ui.ImageByteFormat.png);

    //_preferenceService
    // function to be performed on gotten image to be placed below
  }

  Future<Null> showImage(BuildContext context) async {
    ByteData pngBytes =
        await signatureImage.toByteData(format: ui.ImageByteFormat.png);
    print(pngBytes);
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
            content: Image.memory(Uint8List.view(pngBytes.buffer)),
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
        height: 150,
        width: MediaQuery.of(context).size.width,
        child: CustomPaint(
          painter: SignaturePainter(points: _points),
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

  SignaturePainter({this.points});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.square
      ..strokeWidth = 5.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(SignaturePainter oldDelegate) {
    return oldDelegate.points != points;
  }
}
