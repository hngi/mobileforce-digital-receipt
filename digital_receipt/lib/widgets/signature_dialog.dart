import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:digital_receipt/services/shared_preference_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui' as ui;
import 'package:signature/signature.dart';
import 'package:flutter/rendering.dart';
import '../services/api_service.dart';

final SignatureController _controller = SignatureController(
  penStrokeWidth: 2,
  penColor: Colors.black,
  exportBackgroundColor: Colors.white,
);

GlobalKey<_SignatureCanvasState> signatureCanvasKey = GlobalKey();

class SignatureDialog extends StatefulWidget {
  const SignatureDialog({this.from});
  final String from;
  @override
  SignatureDialogState createState() => SignatureDialogState();
}

SharedPreferenceService _preferenceService = SharedPreferenceService();

ui.Image signatureImage;

class SignatureDialogState extends State<SignatureDialog> {
  saveImage(BuildContext context) async {
    var data = await _controller.toPngBytes();
    String encode = base64Encode(data.buffer.asUint8List());
    if (widget.from == 'setup') {
      await SharedPreferenceService().addStringToSF('ISSUER_SIGNATURE', encode);
      Navigator.pop(context);
      return;
    }

    var res = await ApiService().updateSignature(encode);
    print('reshvh: $res');
    if (res != null) {
      await SharedPreferenceService().addStringToSF('ISSUER_SIGNATURE', encode);
      Navigator.pop(context);
      await Fluttertoast.showToast(
          msg: "Signature saved", toastLength: Toast.LENGTH_LONG);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width * 0.75,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(),
                Text(
                  'Append your signature',
                  style: Theme.of(context).textTheme.headline5.copyWith(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Provide your signature below',
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                        color: Colors.black,
                      ),
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      /*   DashedSeparator(
                        color: Colors.grey,
                      ), */

                      Flexible(
                        child: Signature(
                          key: signatureCanvasKey,
                          controller: _controller,
                          height:
                              MediaQuery.of(context).size.height * 0.75 - 114,
                          width:
                              (MediaQuery.of(context).size.width * 0.75) - 20,
                          backgroundColor: Colors.white,
                        ),
                      ),
                      /*  DashedSeparator(
                        color: Colors.grey,
                      ), */
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 30,
                        ),
                        onPressed: () async {
                          setState(() => _controller.clear());
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 30,
                        ),
                        onPressed: () async {
                          if (_controller.isNotEmpty) {
                            saveImage(context);
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
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
      ..color = Colors.red
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.0;

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
