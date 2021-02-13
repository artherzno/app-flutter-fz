import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'GetDataGen.dart';
import 'main.dart';
import 'QrPage.dart';

class OptionPage extends StatelessWidget {
  final String branchId;
  final String branchName;
  final String keyValue;
  final String jobName, buttonTitle;

  OptionPage({Key key, @required this.branchId, this.branchName, this.keyValue, this.jobName, this.buttonTitle}) : super(key: key);

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

  OptionInner({Key key, @required this.branchId, this.branchName, this.keyValue, this.jobName, this.buttonTitle}) : super(key: key);

  @override
  _OptionInnerState createState() => _OptionInnerState();
}

class _OptionInnerState extends State<OptionInner> {
  // Call Convert JSON to Dart
  GetData _dataFromAPI;
  Map<String, dynamic> dataMap;

  var now = DateTime.now();
  var selectDate = DateTime.now();
  var formatddMMyyyy = DateFormat('dd/MM/yyyy');
  var formatMMddyyyy = DateFormat('MM/dd/yyyy');

  String valueHrSelected = '08';
  List timeHr = [
    '08',
    '09',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15'
  ];

  String valueMinSelected = '00';
  List timeMin = [
    '00',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31',
    '32',
    '33',
    '34',
    '35',
    '36',
    '37',
    '38',
    '39',
    '40',
    '41',
    '42',
    '43',
    '44',
    '45',
    '46',
    '47',
    '48',
    '49',
    '50',
    '51',
    '52',
    '53',
    '54',
    '55',
    '56',
    '57',
    '58',
    '59',
  ];

  // Set Basic Auth
  String basicAuthenticationHeader(String username, String password) {
    return 'Basic ' + base64Encode(utf8.encode('$username:$password'));
  }

  // Get API
  Future<GetData> getAPI() async {
    // print(formatMMddyyyy.format(selectDate));
    var url = 'https://aotkios.web.app/api/v1/req_booking';
    var response = await http.post(url, headers: {
      'authorization': basicAuthenticationHeader('aotsmartq', 'RurFebScfw6u2wYeZL6a5rL5YKKHV5eG'),
      'x-api-key': 'bVYLDtJHzY4meuGatFmmqxufbPudY3H3'
    }, body: {
      "branchID": widget.branchId,
      "branchName": widget.branchName,
      "bookingTime": formatMMddyyyy.format(selectDate) + " " + valueHrSelected + ":" + valueMinSelected,
      "key": widget.keyValue,
      "token": "0819990011" + valueHrSelected + valueHrSelected,
      "jobName": widget.jobName
    });

    _dataFromAPI = getDataFromJson(response.body);
    setState(() {
      dataMap = jsonDecode(response.body);
    });
    // print(widget.keyValue);
    return _dataFromAPI;
  }

  // Get Dialog send data
  Future<void> _showSendDataDialog() async {
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
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, height: 1.2),
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Flexible(
                      child: Container(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(style: TextStyle(fontFamily: 'Kanit'), children: <TextSpan>[
                            TextSpan(
                              text: 'วันที่ ',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: HexColor.fromHex('#002358')),
                            ),
                            TextSpan(
                              text: formatddMMyyyy.format(selectDate),
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: HexColor.fromHex('#4472C4')),
                            ),
                            TextSpan(
                              text: ' เวลา ',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: HexColor.fromHex('#002358')),
                            ),
                            TextSpan(
                              text: valueHrSelected + ":" + valueMinSelected,
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: HexColor.fromHex('#4472C4')),
                            ),
                            TextSpan(
                              text: ' น.',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: HexColor.fromHex('#002358')),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FlatButton(
                      // minWidth: double.infinity,
                      child: Text(
                        'ยกเลิก',
                        style: TextStyle(color: HexColor.fromHex('#888888'), fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    FlatButton(
                      // minWidth: double.infinity,
                      child: Text(
                        'ยืนยัน',
                        style: TextStyle(color: HexColor.fromHex('#002358'), fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QrPage(
                              dataGen: dataMap['data']['data']['bookingNo'],
                              jobName: widget.jobName,
                              buttonTitle: widget.buttonTitle,
                              branchName: widget.branchName,
                              selectDate: formatddMMyyyy.format(selectDate),
                              selectTime: valueHrSelected + ":" + valueMinSelected,
                            ),
                          ),
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

  // Get Dialog
  Future<void> _showDisableDateDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'ไม่สามารถทำรายการได้',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'กรุณาเลือกจองคิวในวันทำการ',
                  style: TextStyle(color: HexColor.fromHex('#4472C4'), fontSize: 22, fontWeight: FontWeight.w500, height: 1.2),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'จันทร์ - ศุกร์',
                  style: TextStyle(color: HexColor.fromHex('#4472C4'), fontSize: 22, fontWeight: FontWeight.w500, height: 1.2),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FlatButton(
                      // minWidth: double.infinity,
                      child: Text(
                        'ตกลง',
                        style: TextStyle(color: HexColor.fromHex('#002358'), fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
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

  Future<void> showDateDialog(BuildContext context) async {
    // print('hi calendar');
    var picked = await showDatePicker(
      context: context,
      initialDate: selectDate,
      firstDate: now,
      cancelText: 'ยกเลิก',
      confirmText: 'ตกลง',
      lastDate: DateTime(now.year, now.month + 1, now.day),
      // selectableDayPredicate: (DateTime val) =>
      //     val.weekday == 6 || val.weekday == 7 ? false : true,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xFF4472C4),
            accentColor: const Color(0xFF4472C4),
            colorScheme: ColorScheme.light(primary: const Color(0xFF4472C4)),
            textTheme: TextTheme(
              button: TextStyle(fontFamily: 'Kanit'),
            ),
          ),
          child: child,
        );
      },
    );

    // print(picked);

    // var pickedSelectd = DateTime.parse(picked.toString());
    // print(pickedSelectd.weekday);
    if (picked == null) {
      picked = selectDate;
      // print(picked);
    } else if (picked != null && picked != selectDate) {
      if (picked.weekday == DateTime.sunday || picked.weekday == DateTime.saturday) {
        _showDisableDateDialog();
      } else {
        setState(() {
          selectDate = picked;
        });
      }
    }

    // print(picked.weekday);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex('#4472C4'),
      body: Center(
        child: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(fit: BoxFit.cover, image: AssetImage('assets/images/bg-aot.jpg')),
            ),
            child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
              // Body
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                  constraints: BoxConstraints.expand(),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                  child: Column(
                    children: [
                      Text(
                        '${widget.buttonTitle}. ${widget.jobName}',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, height: 1.2),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            child: Column(
                              children: [
                                Text(
                                  'กรุณาเลือกวันจองคิว',
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.left,
                                ),
                                // Text(
                                //   '- วันที่ปัจจุบัน: ${formatddMMyyyy.format(now)} -',
                                //   style: TextStyle(fontSize: 16),
                                //   textAlign: TextAlign.left,
                                // ),
                                Text(
                                  'หมายเหตุ: จองคิวล่วงหน้าได้ไม่เกิน 30 วัน',
                                  style: TextStyle(color: HexColor.fromHex('#888888')),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                // showDatePicker(context: context),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                        color: HexColor.fromHex('#4472C4'),
                                        width: 1,
                                      )),
                                  child: FlatButton(
                                    // minWidth: double.infinity,
                                    onPressed: () async {
                                      await showDateDialog(context);
                                    },
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            formatddMMyyyy.format(selectDate),
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: HexColor.fromHex('#002358'),
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.calendar_today_sharp,
                                          size: 20,
                                          color: HexColor.fromHex('#002358'),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'กรุณาเลือกเวลาจองคิว',
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  'หมายเหตุ: เวลาทำการ 08:00 น. - 16:00 น.',
                                  style: TextStyle(color: HexColor.fromHex('#888888')),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: Container(
                                        padding: EdgeInsets.only(left: 10, right: 4),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.0),
                                          border: Border.all(
                                            color: HexColor.fromHex('#4472C4'),
                                            width: 1,
                                          ),
                                        ),
                                        child: DropdownButton(
                                            isExpanded: true,
                                            underline: SizedBox(),
                                            icon: Icon(
                                              // Add this
                                              Icons.timer_outlined, // Add this
                                              color: HexColor.fromHex('#002358'), // Add this
                                            ),
                                            items: timeHr
                                                .map(
                                                  (valueItem) => DropdownMenuItem(
                                                    child: Text(valueItem),
                                                    value: valueItem,
                                                  ),
                                                )
                                                .toList(),
                                            value: valueHrSelected,
                                            style: TextStyle(
                                              fontFamily: 'Kanit',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: HexColor.fromHex('#002358'),
                                            ),
                                            onChanged: (newVal) {
                                              setState(() {
                                                valueHrSelected = newVal;
                                              });
                                            }),
                                      ),
                                    ),
                                    Text(
                                      ' : ',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Flexible(
                                      child: Container(
                                        padding: EdgeInsets.only(left: 10, right: 4),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.0),
                                            border: Border.all(
                                              color: HexColor.fromHex('#4472C4'),
                                              width: 1,
                                            )),
                                        child: DropdownButton(
                                            isExpanded: true,
                                            underline: SizedBox(),
                                            icon: Icon(
                                              // Add this
                                              Icons.timer_sharp, // Add this
                                              color: HexColor.fromHex('#002358'), // Add this
                                            ),
                                            items: timeMin
                                                .map((valueMinItem) => DropdownMenuItem(
                                                      child: Text(valueMinItem),
                                                      value: valueMinItem,
                                                    ))
                                                .toList(),
                                            value: valueMinSelected,
                                            style: TextStyle(
                                              fontFamily: 'Kanit',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: HexColor.fromHex('#002358'),
                                            ),
                                            onChanged: (newMinVal) {
                                              setState(() {
                                                valueMinSelected = newMinVal;
                                              });
                                            }),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                FlatButton(
                                  // minWidth: double.infinity,
                                  padding: EdgeInsets.all(0.0),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  onPressed: () {
                                    getAPI();

                                    selectDate.weekday == 6 || selectDate.weekday == 7 ? _showDisableDateDialog() : _showSendDataDialog();
                                  },
                                  child: Ink(
                                    width: 600,
                                    height: 60,
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xff4FD1FF),
                                            Color(0xff4472C4)
                                          ],
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
                                  // minWidth: double.infinity,
                                  padding: EdgeInsets.all(0.0),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                                          style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                                        ),
                                      )),
                                ),
                                SizedBox(
                                  height: 30,
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
