// To parse this JSON data, do
//
//     final resAgama = resAgamaFromJson(jsonString);

import 'dart:convert';

ResAgama resAgamaFromJson(String str) => ResAgama.fromJson(json.decode(str));

String resAgamaToJson(ResAgama data) => json.encode(data.toJson());

class ResAgama {
    bool? success;
    List<String>? data;
    String? message;

    ResAgama({
        this.success,
        this.data = const [],
        this.message,
    });

    factory ResAgama.fromJson(Map<String, dynamic> json) => ResAgama(
        success: json["success"],
        data: json["data"] == null ? [] : List<String>.from(json["data"]!.map((x) => x)),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
        "message": message,
    };
}
