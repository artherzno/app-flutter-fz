// To parse this JSON data, do
//
//     final getData = getDataFromJson(jsonString);

import 'dart:convert';

GetData getDataFromJson(String str) => GetData.fromJson(json.decode(str));

String getDataToJson(GetData data) => json.encode(data.toJson());

class GetData {
  GetData({
    this.status,
    this.data,
    this.info,
  });

  bool status;
  List<Datum> data;
  Info info;

  factory GetData.fromJson(Map<String, dynamic> json) => GetData(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        info: Info.fromJson(json["info"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "info": info.toJson(),
      };
}

class Datum {
  Datum({
    this.type,
    this.name,
    this.buttonTitle,
    this.buttonColor,
    this.bgColor,
    this.key,
    this.order,
    this.enable,
  });

  String type;
  String name;
  String buttonTitle;
  String buttonColor;
  String bgColor;
  String key;
  int order;
  int enable;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        type: json["type"],
        name: json["name"],
        buttonTitle: json["button_title"],
        buttonColor: json["button_color"],
        bgColor: json["bg_color"],
        key: json["key"],
        order: json["order"],
        enable: json["enable"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "name": name,
        "button_title": buttonTitle,
        "button_color": buttonColor,
        "bg_color": bgColor,
        "key": key,
        "order": order,
        "enable": enable,
      };
}

class Info {
  Info({
    this.branchId,
    this.branchName,
  });

  String branchId;
  String branchName;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        branchId: json["branchID"],
        branchName: json["branchName"],
      );

  Map<String, dynamic> toJson() => {
        "branchID": branchId,
        "branchName": branchName,
      };
}
