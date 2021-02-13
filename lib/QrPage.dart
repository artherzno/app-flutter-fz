// import 'dart:convert';

import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'SuccessPage.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter/rendering.dart';

class QrPage extends StatelessWidget {
  final String dataGen, jobName, buttonTitle, branchName, selectDate, selectTime;

  QrPage({Key key, @required this.dataGen, this.jobName, this.buttonTitle, this.branchName, this.selectDate, this.selectTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FZ Smart Que',
      home: QrGenerator(dataGen: dataGen, jobName: jobName, buttonTitle: buttonTitle, branchName: branchName, selectDate: selectDate, selectTime: selectTime),
      theme: new ThemeData(
          fontFamily: 'Kanit',
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: HexColor.fromHex('#002358'),
                displayColor: HexColor.fromHex('#002358'),
              )),
      debugShowCheckedModeBanner: false,
    );
  }
}

class QrGenerator extends StatefulWidget {
  final String dataGen, jobName, buttonTitle, branchName, selectDate, selectTime;

  QrGenerator({Key key, @required this.dataGen, this.jobName, this.buttonTitle, this.branchName, this.selectDate, this.selectTime}) : super(key: key);

  @override
  _QrGeneratorState createState() => _QrGeneratorState();
}

class _QrGeneratorState extends State<QrGenerator> {
  // GlobalKey globalKey = GlobalKey();

  // Future<Uint8List> _capturePng() async {
  //   RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();

  //   if (boundary.debugNeedsPaint) {
  //     print("Waiting for boundary to be painted.");
  //     await Future.delayed(const Duration(milliseconds: 20));
  //     return _capturePng();
  //   }

  //   var image = await boundary.toImage();
  //   var byteData = await image.toByteData(format: ImageByteFormat.png);
  //   return byteData.buffer.asUint8List();
  // }

  // void _printPngBytes() async {
  //   var pngBytes = await _capturePng();
  //   var bs64 = base64Encode(pngBytes);
  //   print(pngBytes);
  //   print(bs64);
  // }

  Uint8List _imageFile;

  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex('#4472C4'),
      body: Center(
        child: Screenshot(
          controller: screenshotController,
          child: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(fit: BoxFit.cover, image: AssetImage('assets/images/bg-aot.jpg')),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Header
                Container(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 20.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/logo-aot-w.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Text(
                        'FZ Smart Que',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Kanit',
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 1.0,
                              color: Colors.black,
                              offset: Offset(1.0, 1.0),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'By Airports of Thailand Public Co.,Ltd. (v.1.0.2).',
                        style: TextStyle(
                          height: 0.8,
                          fontSize: 10,
                          fontWeight: FontWeight.w100,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 1.0,
                              color: Colors.black,
                              offset: Offset(1.0, 1.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    constraints: BoxConstraints.expand(),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                    child: Column(
                      children: [
                        Text(
                          '${widget.buttonTitle}. ${widget.jobName}',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, height: 1.2),
                          textAlign: TextAlign.center,
                        ),
                        Flexible(
                          child: SizedBox(
                            height: 10,
                          ),
                        ),
                        Container(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(style: TextStyle(fontFamily: 'Kanit'), children: <TextSpan>[
                              TextSpan(
                                text: 'วันที่ ',
                                style: TextStyle(fontSize: 18, height: 1, fontWeight: FontWeight.w500, color: HexColor.fromHex('#002358')),
                              ),
                              TextSpan(
                                text: widget.selectDate,
                                style: TextStyle(fontSize: 22, height: 1, fontWeight: FontWeight.w500, color: HexColor.fromHex('#4472C4')),
                              ),
                              TextSpan(
                                text: ' เวลา ',
                                style: TextStyle(fontSize: 18, height: 1, fontWeight: FontWeight.w500, color: HexColor.fromHex('#002358')),
                              ),
                              TextSpan(
                                text: widget.selectTime,
                                style: TextStyle(fontSize: 22, height: 1, fontWeight: FontWeight.w500, color: HexColor.fromHex('#4472C4')),
                              ),
                              TextSpan(
                                text: ' น.',
                                style: TextStyle(fontSize: 18, height: 1, fontWeight: FontWeight.w500, color: HexColor.fromHex('#002358')),
                              ),
                            ]),
                          ),
                        ),
                        Container(
                          child: QrImage(
                            data: widget.dataGen,
                            version: QrVersions.auto,
                            size: 200.0,
                          ),
                        ),
                        Flexible(
                          child: SizedBox(
                            height: 10,
                          ),
                        ),
                        Text(
                          'กรุณาบันทึก QR Code นี้ เพื่อใช้ยืนยันการจองคิวล่วงหน้า ภายใน 10 นาที ก่อนเวลานัดหมายที่เครื่องออกบัตรคิว ${widget.branchName}',
                          style: TextStyle(height: 1.2, fontSize: 16),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _imageFile = null;
          screenshotController.capture().then((Uint8List image) async {
            //print("Capture Done");
            setState(() {
              _imageFile = image;
            });
            final result = await ImageGallerySaver.saveImage(image); // Save image to gallery,  Needs plugin  https://pub.dev/packages/image_gallery_saver
            // print("File Saved to Gallery");
            // print(result);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SuccessPage(
                  jobName: widget.jobName,
                  buttonTitle: widget.buttonTitle,
                ),
              ),
            );
          }).catchError((onError) {
            print(onError);
          });
        },
        child: Container(
          width: 56,
          height: 56,
          child: Icon(Icons.save_alt),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Color(0xff64B6FF),
                Color(0xff374ABE)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),

        // backgroundColor: HexColor.fromHex('#002358'),
      ),
    );
  }
}

// Convert Hex Color
extension HexColor on Color {
  // final Color color = HexColor.fromHex('#aabbcc');

  // print(color.toHex());
  // print(const Color(0xffaabbcc).toHex());

  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
