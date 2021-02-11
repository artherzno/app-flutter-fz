// import 'dart:convert';

import 'package:flutter/material.dart';
import 'main.dart';

class SuccessPage extends StatelessWidget {
  final String jobName, buttonTitle;

  SuccessPage({Key key, this.jobName, this.buttonTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FZ Smart Que',
      theme: new ThemeData(
          fontFamily: 'Kanit',
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: HexColor.fromHex('#002358'),
                displayColor: HexColor.fromHex('#002358'),
              )),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: HexColor.fromHex('#4472C4'),
        body: Center(
          child: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/bg-aot.png')),
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
                        'By Airports of Thailand Public Co.,Ltd. (v.1.0.1).',
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
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Column(
                      children: [
                        Text(
                          buttonTitle + '. ' + jobName,
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              height: 1.2),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'บันทึก QR Code เรียบร้อย',
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w400,
                              color: HexColor.fromHex('#3BB7E8')),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'บริษัท ท่าอากาศยานไทย จำกัด (มหาชน)',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: HexColor.fromHex('#002358')),
                        ),
                        Text(
                          'ขอขอบคุณที่ใช้บริการ',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: HexColor.fromHex('#002358')),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        FlatButton(
                          padding: EdgeInsets.all(0.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyApp()),
                            );
                          },
                          child: Ink(
                            width: 600,
                            height: 60,
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xffE2E2E2),
                                    Color(0xffB8B8B8)
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: BorderRadius.circular(30.0)),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'กลับหน้าแรก',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.grey[600]),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
