// To parse this JSON data, do
//
//     final resEdukasi = resEdukasiFromJson(jsonString);

import 'dart:convert';

ResEdukasi resEdukasiFromJson(String str) =>
    ResEdukasi.fromJson(json.decode(str));

String resEdukasiToJson(ResEdukasi data) => json.encode(data.toJson());

class ResEdukasi {
  bool? success;
  List<String>? data;
  String? message;

  ResEdukasi({
    this.success,
    this.data = const [],
    this.message,
  });

  factory ResEdukasi.fromJson(Map<String, dynamic> json) => ResEdukasi(
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
