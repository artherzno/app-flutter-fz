import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'GetDataGen.dart';
import 'main.dart';
import 'QrPage.dart';

class OptionPage extends StatelessWidget {
  final String branchId;
  final String branchName;
  final String keyValue;
  final String jobName, buttonTitle;

  OptionPage(
      {Key key,
      @required this.branchId,
      this.branchName,
      this.keyValue,
      this.jobName,
      this.buttonTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FZ Smart Que',
      home: OptionInner(
        branchId: branchId,
        branchName: branchName,
        keyValue: keyValue,
        jobName: jobName,
        buttonTitle: buttonTitle,
      ),
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

class OptionInner extends StatefulWidget {
  final String branchId;
  final String branchName;
  final String keyValue;
  final String jobName, buttonTitle;

  OptionInner(
      {Key key,
      @required this.branchId,
      this.branchName,
      this.keyValue,
      this.jobName,
      this.buttonTitle})
      : super(key: key);

  @override
  _OptionInnerState createState() => _OptionInnerState();
}

class _OptionInnerState extends State<OptionInner> {
  // Call Convert JSON to Dart
  GetData _dataFromAPI;
  Map<String, dynamic> dataMap;

  // Set Basic Auth
  String basicAuthenticationHeader(String username, String password) {
    return 'Basic ' + base64Encode(utf8.encode('$username:$password'));
  }

  // Get API
  Future<GetData> getAPI() async {
    var url = 'https://aotkios.web.app/api/v1/req_booking';
    var response = await http.post(url, headers: {
      'authorization': basicAuthenticationHeader(
          'aotsmartq', 'RurFebScfw6u2wYeZL6a5rL5YKKHV5eG'),
      'x-api-key': 'bVYLDtJHzY4meuGatFmmqxufbPudY3H3'
    }, body: {
      "branchID": widget.branchId,
      "branchName": widget.branchName,
      "bookingTime": "12/17/2021 12:08",
      "key": widget.keyValue,
      "token": "0819990011",
      "jobName": widget.jobName
    });

    _dataFromAPI = getDataFromJson(response.body);
    dataMap = jsonDecode(response.body);
    // print(dataMap);
    return _dataFromAPI;
  }

  // Get Dialog
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'คุณได้ทำการจองคิวรายการ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  '${widget.buttonTitle}. ${widget.jobName}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                    color: HexColor.fromHex('#002358'),
                  ),
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Text('วันที่ '),
                    Text(
                      '12/02/2021',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: HexColor.fromHex('#4472C4')),
                    ),
                    Text(' เวลา '),
                    Text(
                      '08.00',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: HexColor.fromHex('#4472C4')),
                    ),
                    Text(' น.'),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FlatButton(
                      child: Text(
                        'ยกเลิก',
                        style: TextStyle(
                            color: HexColor.fromHex('#888888'), fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    FlatButton(
                      child: Text(
                        'ยืนยัน',
                        style: TextStyle(
                            color: HexColor.fromHex('#002358'), fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QrPage(
                                  dataGen: dataMap['data']['data']['bookingNo'],
                                  jobName: widget.jobName,
                                  buttonTitle: widget.buttonTitle)),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

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
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
              // Body
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
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            height: 1.2),
                      ),
                      FlatButton(
                        padding: EdgeInsets.all(0.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          getAPI();
                          _showMyDialog();
                        },
                        child: Ink(
                          width: 600,
                          height: 60,
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xff4FD1FF), Color(0xff4472C4)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'จองคิว',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                shadows: [
                                  Shadow(
                                    blurRadius: 1.0,
                                    color: Colors.black,
                                    offset: Offset(1.0, 1.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
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
                                'ยกเลิก',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.grey[600]),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ])),
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
