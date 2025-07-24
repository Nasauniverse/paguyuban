// To parse this JSON data, do
//
//     final resProvinsi = resProvinsiFromJson(jsonString);

import 'dart:convert';

ResProvinsi resProvinsiFromJson(String str) =>
    ResProvinsi.fromJson(json.decode(str));

String resProvinsiToJson(ResProvinsi data) => json.encode(data.toJson());

DataProvinsi provinsiFromJson(String str) => DataProvinsi.fromJson(json.decode(str));

String provinsiToJson(DataProvinsi data) => json.encode(data.toJson());

class ResProvinsi {
  bool? success;
  List<DataProvinsi>? data;
  String? message;

  ResProvinsi({
    this.success,
    this.data = const [],
    this.message,
  });

  factory ResProvinsi.fromJson(Map<String, dynamic> json) => ResProvinsi(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<DataProvinsi>.from(json["data"]!.map((x) => DataProvinsi.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class DataProvinsi {
  String? id;
  String? name;

  DataProvinsi({
    this.id,
    this.name,
  });

  factory DataProvinsi.fromJson(Map<String, dynamic> json) => DataProvinsi(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
