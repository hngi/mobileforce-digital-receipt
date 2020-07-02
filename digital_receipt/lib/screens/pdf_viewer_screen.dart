import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';

class PdfViewerScreen extends StatelessWidget {
  final String path;
  const PdfViewerScreen({Key key, this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PDFViewerScaffold(
        path: path,
        appBar: AppBar(
          //  backgroundColor: Color(0xFF0b56a7),
          automaticallyImplyLeading: true,
          title: Text(
            'Receipt Preview',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: 'Montserrat',
              letterSpacing: 0.03,
            ),
          ),
        ),
      ),
    );
  }
}
