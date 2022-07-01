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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_genius_scan/flutter_genius_scan.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class Scan extends StatefulWidget {
  const Scan({Key? key}) : super(key: key);

  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('GS SDK Flutter Demo'),
          ),
          body: MyScaffoldBody()),
    );
  }
}

class MyScaffoldBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
      onPressed: () {
        copyLanguageFile().then((folder) {
          FlutterGeniusScan.scanWithConfiguration({
            'source': 'camera',
            'multiPage': true,
            'ocrConfiguration': {
              'languages': ['eng'],
              'languagesDirectoryUrl': folder.path
            }
          }).then((result) {
            String documentUrl = result['multiPageDocumentUrl'];
            OpenFile.open(documentUrl.replaceAll("file://", '')).then(
                (result) => debugPrint(result.toString()),
                onError: (error) => displayError(context, error));
          }, onError: (error) => displayError(context, error));
        });
      },
      child: Text("START SCANNING"),
    ));
  }

  Future<Directory> copyLanguageFile() async {
    Directory languageFolder = await getApplicationSupportDirectory();
    File languageFile = File(languageFolder.path + "/eng.traineddata");
    if (!languageFile.existsSync()) {
      ByteData data = await rootBundle.load("assets/eng.traineddata");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await languageFile.writeAsBytes(bytes);
    }
    return languageFolder;
  }

  void displayError(BuildContext context, PlatformException error) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(error.message!)));
  }
}
