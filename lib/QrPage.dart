// import 'dart:convert';

import 'package:flutter/material.dart';
import 'SuccessPage.dart';

class QrPage extends StatelessWidget {
  final String dataGen, jobName, buttonTitle;

  QrPage({Key key, @required this.dataGen, this.jobName, this.buttonTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FZ Smart Que',
      home: QrGenerator(
          dataGen: dataGen, jobName: jobName, buttonTitle: buttonTitle),
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
  final String dataGen, jobName, buttonTitle;

  QrGenerator({Key key, @required this.dataGen, this.jobName, this.buttonTitle})
      : super(key: key);

  @override
  _QrGeneratorState createState() => _QrGeneratorState();
}

class _QrGeneratorState extends State<QrGenerator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        '${widget.buttonTitle}. ${widget.jobName}',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            height: 1.2),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        children: [
                          Text(
                            'จองคิววันที่ ',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            '12/02/2021',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: HexColor.fromHex('#4472C4')),
                          ),
                          Text(
                            ' เวลา ',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            '08.00',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: HexColor.fromHex('#4472C4')),
                          ),
                          Text(
                            ' น.',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Text(widget.dataGen),
                      Text(
                        'กรุณาบันทึก QR Code นี้ เพื่อใช้ยืนยันการจองคิวล่วงหน้า ภายใน 10 นาที ก่อนเวลานัดหมายที่เครื่องออกบัตรคิว ณ เขตปลอดอากร ณ ท่าอากาศยานสุวรรณภูมิ',
                        style: TextStyle(fontSize: 16),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SuccessPage(
                      jobName: widget.jobName,
                      buttonTitle: widget.buttonTitle,
                    )),
          );
        },
        child: Container(
          width: 56,
          height: 56,
          child: Icon(Icons.save_sharp),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xff64B6FF), Color(0xff374ABE)],
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
