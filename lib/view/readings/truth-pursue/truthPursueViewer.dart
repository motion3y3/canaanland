import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class TruthPursuePage extends StatelessWidget {
  final String filePath;

  TruthPursuePage({required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: PDFView(
            filePath: filePath,
            fitPolicy: FitPolicy.WIDTH,
          ),
        ),
      ),
    );
  }
}
