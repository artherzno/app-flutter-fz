import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'GetData.dart';
import 'OptionPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FZ Smart Que',
      home: HomePage(),
      theme: new ThemeData(
        fontFamily: 'Kanit',
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Call Convert JSON to Dart
  GetData _dataFromAPI;

  @override
  void initState() {
    super.initState();
    getAPI();
  }

  // Set Basic Auth
  String basicAuthenticationHeader(String username, String password) {
    return 'Basic ' + base64Encode(utf8.encode('$username:$password'));
  }

  // Get API
  Future<GetData> getAPI() async {
    var url = 'https://aotkios.web.app/api/v1/getservice';
    var response = await http.post(url, headers: {
      'authorization': basicAuthenticationHeader(
          'aotsmartq', 'RurFebScfw6u2wYeZL6a5rL5YKKHV5eG'),
      'x-api-key': 'bVYLDtJHzY4meuGatFmmqxufbPudY3H3'
    }, body: {
      'branchID': '0001'
    });

    _dataFromAPI = getDataFromJson(response.body);

    return _dataFromAPI;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        'ระบบจองคิวล่วงหน้า',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w400,
                            color: HexColor.fromHex('#002358')),
                      ),
                      Flexible(
                        child: FutureBuilder(
                          future: getAPI(),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              var result = snapshot.data;
                              return ListView.builder(
                                  itemCount: result.data.length,
                                  // ignore: missing_return
                                  itemBuilder: (BuildContext context, i) {
                                    if (result.data[i].enable == 1 &&
                                        result.data[i].order < 5) {
                                      // Main Button
                                      return Column(
                                        children: [
                                          FlatButton(
                                            padding: EdgeInsets.all(0.0),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        OptionPage(
                                                            branchId: result
                                                                .info.branchId,
                                                            branchName: result
                                                                .info
                                                                .branchName,
                                                            keyValue: result
                                                                .data[i].key,
                                                            jobName: result
                                                                .data[i].name,
                                                            buttonTitle: result
                                                                .data[i]
                                                                .buttonTitle)),
                                              );
                                            },
                                            child: Ink(
                                              height: 60,
                                              padding: EdgeInsets.fromLTRB(
                                                  6, 4, 6, 4),
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color(0xff4FD1FF),
                                                      Color(0xff4472C4)
                                                    ],
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0)),
                                              child: Row(
                                                children: [
                                                  Container(
                                                      width: 50,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        color: HexColor.fromHex(
                                                            result.data[i]
                                                                .buttonColor),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                4, 6, 4, 6),
                                                        child: Text(
                                                          result.data[i]
                                                              .buttonTitle,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 24,
                                                          ),
                                                        ),
                                                      )),
                                                  Flexible(
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              6, 0, 6, 0),
                                                      child: Text(
                                                        result.data[i].name,
                                                        style: TextStyle(
                                                          height: 1.2,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 18,
                                                          shadows: [
                                                            Shadow(
                                                              blurRadius: 1.0,
                                                              color:
                                                                  Colors.black,
                                                              offset: Offset(
                                                                  1.0, 1.0),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      );
                                    }
                                  });
                            }
                            return Center(child: CircularProgressIndicator());
                          },
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
    );
  }
}

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
