// import 'dart:io';

// import 'package:docscan/component/theme.dart';
// import 'package:flutter/material.dart';

// import 'package:document_scanner/document_scanner.dart';
// import 'package:opencv/core/core.dart';

// import 'package:opencv/opencv.dart';
// import 'package:permission_handler/permission_handler.dart';

// class Scan extends StatefulWidget {
//   const Scan({Key? key}) : super(key: key);

//   @override
//   _ScanState createState() => _ScanState();
// }

// class _ScanState extends State<Scan> {
//   File? scannedDocument;
//   Future<PermissionStatus>? cameraPermissionFuture;
//   dynamic res;
//   Image? img;

//   @override
//   void initState() {
//     cameraPermissionFuture = Permission.camera.request();
//     super.initState();
//   }

//   useFilter() async {
//     res = await ImgProc.blur(await scannedDocument?.readAsBytes(), [45, 45],
//         [20, 30], Core.borderReflect);
//     setState(() {
//       // scannedDocument = res;

//       // ScannedImage(croppedImage: res);

//       // ga error tapi gaada perubahan

//       img = Image.memory(res);

//       //scannedDocument = Image.file(img);

//       // img: FileImage(scannedDocument!);
//       // img = res;
//       // Image(image: FileImage(scannedDocument!));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//           appBar: AppBar(
//             backgroundColor: purple,
//             title: const Text('Scanner App'),
//           ),
//           body: FutureBuilder<PermissionStatus>(
//             future: cameraPermissionFuture,
//             builder: (BuildContext context,
//                 AsyncSnapshot<PermissionStatus> snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 if (snapshot.data!.isGranted)
//                   return Stack(
//                     children: <Widget>[
//                       Column(
//                         children: <Widget>[
//                           Expanded(
//                             child: scannedDocument != null
//                                 ? Image(image: FileImage(scannedDocument!))
//                                 : DocumentScanner(
//                                     // documentAnimation: false,
//                                     // noGrayScale: false,
//                                     onDocumentScanned:
//                                         (ScannedImage scannedImage) {
//                                       print("document : " +
//                                           scannedImage.croppedImage!);

//                                       setState(() {
//                                         scannedDocument = scannedImage
//                                             .getScannedDocumentAsFile();

//                                         // imageLocation = image;
//                                       });
//                                     },
//                                   ),
//                           ),
//                         ],
//                       ),
//                       scannedDocument != null
//                           ? Positioned(
//                               bottom: 20,
//                               left: 0,
//                               right: 0,
//                               child: RaisedButton(
//                                 onPressed: () {
//                                   // loaded ? img : scannedDocument;
//                                   useFilter();

//                                   img = Image.file(scannedDocument!);
//                                   // setState(() {
//                                   //   scannedDocument = useFilter();
//                                   //   // useFilter();
//                                   //   // scannedImage = res;
//                                   // });
//                                 },
//                                 child: Text("Blur"),
//                               ),

//                               // RaisedButton(
//                               //     color: Colors.red,
//                               //     child: Text("Retry"),
//                               //     onPressed: () {
//                               //       setState(() {
//                               //         scannedDocument = null;
//                               //       });
//                               //     }),
//                               // RaisedButton(
//                               //   onPressed: () async {
//                               //     res = await ImgProc.dilate(
//                               //         await scannedDocument
//                               //             ?.readAsBytes(),
//                               //         [2, 2]);
//                               //   },
//                               //   child: Text("Dilate n 2D"),
//                               // ),
//                             )
//                           : Container(),
//                     ],
//                   );
//                 else
//                   return Center(
//                     child: Text("Camera permission denied"),
//                   );
//               } else {
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//             },
//           )),
//     );
//   }
// }

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
    StoreDataUserRequest? result = await ApiService()
        .createPresensiDatang(_nama, _description, _scannedImage);
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
