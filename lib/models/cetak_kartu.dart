// To parse this JSON data, do
//
//     final resCetakKartu = resCetakKartuFromJson(jsonString);

import 'dart:convert';

ResCetakKartu resCetakKartuFromJson(String str) => ResCetakKartu.fromJson(json.decode(str));

String resCetakKartuToJson(ResCetakKartu data) => json.encode(data.toJson());

class ResCetakKartu {
    bool? success;
    Data? data;
    String? message;

    ResCetakKartu({
        this.success,
        this.data,
        this.message,
    });

    factory ResCetakKartu.fromJson(Map<String, dynamic> json) => ResCetakKartu(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "message": message,
    };
}

class Data {
    String? url;

    Data({
        this.url,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
    };
}
