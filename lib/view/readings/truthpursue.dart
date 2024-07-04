import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class TruthPursuePage extends StatefulWidget {
  @override
  _TruthPursuePageState createState() => _TruthPursuePageState();
}

class _TruthPursuePageState extends State<TruthPursuePage> {
  String? localPath;

  @override
  void initState() {
    super.initState();
    _loadPdfFromAssets();
  }

  Future<void> _loadPdfFromAssets() async {
    try {
      final byteData = await rootBundle.load('readingMaterials/test.pdf');
      final file = File('${(await getTemporaryDirectory()).path}/test.pdf');
      await file.writeAsBytes(byteData.buffer.asUint8List());
      setState(() {
        localPath = file.path;
      });
    } catch (e) {
      print("Error loading PDF: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: Center(
        child: localPath == null
            ? CircularProgressIndicator()
            : Container(
          height: double.infinity,
          width: double.infinity,
          child: PDFView(
            filePath: localPath,
            fitPolicy: FitPolicy.WIDTH,
          ),
        ),
      ),
    );
  }
}
