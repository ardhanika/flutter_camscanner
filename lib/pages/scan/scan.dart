import 'dart:io';
import 'dart:math';

import 'package:docscan/model/store_data_user_request.dart';
import 'package:docscan/network/api_service.dart';
import 'package:document_scanner_flutter/document_scanner_flutter.dart';
import 'package:document_scanner_flutter/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

class Scan extends StatefulWidget {
  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  StoreDataUserRequest? scan;
  ApiService _apiService = ApiService();
  PDFDocument? _scannedDocument;
  File? _scannedDocumentFile;
  File? _scannedImage;

  var _nama = "";
  var _description = "";
  var _image = "";

  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  // openPdfScanner(BuildContext context) async {
  //   var doc = await DocumentScannerFlutter.launchForPdf(
  //     context,
  //     labelsConfig: {
  //       ScannerLabelsConfig.ANDROID_NEXT_BUTTON_LABEL: "Next Steps",
  //       ScannerLabelsConfig.PDF_GALLERY_FILLED_TITLE_SINGLE: "Only 1 Page",
  //       ScannerLabelsConfig.PDF_GALLERY_FILLED_TITLE_MULTIPLE:
  //           "Only {PAGES_COUNT} Page"
  //     },
  //     //source: ScannerFileSource.CAMERA
  //   );
  //   if (doc != null) {
  //     _scannedDocument = null;
  //     setState(() {});
  //     await Future.delayed(Duration(milliseconds: 100));
  //     _scannedDocumentFile = doc;
  //     _scannedDocument = await PDFDocument.fromFile(doc);
  //     setState(() {});
  //   }
  // }

  Future<void> submit() async {
    bool showSpinner = true;
    StoreDataUserRequest? result =
        await ApiService().createDataUser(_nama, _description, _scannedImage);
    if (result != null) {
      setState(() {
        scan = result;
      });
    }
  }

  openImageScanner(BuildContext context) async {
    var image = await DocumentScannerFlutter.launch(context,
        //source: ScannerFileSource.CAMERA,
        labelsConfig: {
          ScannerLabelsConfig.ANDROID_NEXT_BUTTON_LABEL: "Next Step",
          ScannerLabelsConfig.ANDROID_OK_LABEL: "OK"
        });
    if (image != null) {
      _scannedImage = image;
      setState(() {
        _nama = getRandomString(5);
        _description = getRandomString(10);

        submit();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Document Scanner'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (_scannedDocument != null || _scannedImage != null) ...[
              if (_scannedImage != null)
                Image.file(_scannedImage!,
                    width: 300, height: 300, fit: BoxFit.contain),
              if (_scannedDocument != null)
                Expanded(
                    child: PDFViewer(
                  document: _scannedDocument!,
                )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    _scannedDocumentFile?.path ?? _scannedImage?.path ?? ''),
              ),
            ],
            // Center(
            //   child: Builder(builder: (context) {
            //     return ElevatedButton(
            //         onPressed: () => openPdfScanner(context),
            //         child: Text("PDF Scan"));
            //   }),
            // ),
            Center(
              child: Builder(builder: (context) {
                return ElevatedButton(
                    onPressed: () => openImageScanner(context),
                    child: Text("Image Scan"));
              }),
            )
          ],
        ),
      ),
    );
  }
}
