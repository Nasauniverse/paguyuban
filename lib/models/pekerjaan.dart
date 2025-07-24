// To parse this JSON data, do
//
//     final resPekerjaan = resPekerjaanFromJson(jsonString);

import 'dart:convert';

ResPekerjaan resPekerjaanFromJson(String str) =>
    ResPekerjaan.fromJson(json.decode(str));

String resPekerjaanToJson(ResPekerjaan data) => json.encode(data.toJson());

class ResPekerjaan {
  bool? success;
  List<String>? data;
  String? message;

  ResPekerjaan({
    this.success,
    this.data = const [],
    this.message,
  });

  factory ResPekerjaan.fromJson(Map<String, dynamic> json) => ResPekerjaan(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<String>.from(json["data"]!.map((x) => x)),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
        "message": message,
      };
}
