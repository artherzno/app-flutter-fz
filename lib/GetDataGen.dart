// To parse this JSON data, do
//
//     final getData = getDataFromJson(jsonString);

import 'dart:convert';

GetData getDataFromJson(String str) => GetData.fromJson(json.decode(str));

String getDataToJson(GetData data) => json.encode(data.toJson());

class GetData {
  GetData({
    this.data,
  });

  GetDataData data;

  factory GetData.fromJson(Map<String, dynamic> json) => GetData(
        data: GetDataData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class GetDataData {
  GetDataData({
    this.status,
    this.result,
    this.data,
    this.message,
  });

  bool status;
  bool result;
  DataData data;
  String message;

  factory GetDataData.fromJson(Map<String, dynamic> json) => GetDataData(
        status: json["status"],
        result: json["result"],
        data: DataData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "result": result,
        "data": data.toJson(),
        "message": message,
      };
}

class DataData {
  DataData({
    this.bookingNo,
    this.key,
    this.branchId,
  });

  String bookingNo;
  String key;
  String branchId;

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        bookingNo: json["bookingNo"],
        key: json["key"],
        branchId: json["branchID"],
      );

  Map<String, dynamic> toJson() => {
        "bookingNo": bookingNo,
        "key": key,
        "branchID": branchId,
      };
}
