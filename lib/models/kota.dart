// To parse this JSON data, do
//
//     final resKota = resKotaFromJson(jsonString);

import 'dart:convert';

ResKota resKotaFromJson(String str) => ResKota.fromJson(json.decode(str));

String resKotaToJson(ResKota data) => json.encode(data.toJson());

class ResKota {
    bool? success;
    List<DataKota>? data;
    String? message;

    ResKota({
        this.success,
        this.data= const [],
        this.message,
    });

    factory ResKota.fromJson(Map<String, dynamic> json) => ResKota(
        success: json["success"],
        data: json["data"] == null ? [] : List<DataKota>.from(json["data"]!.map((x) => DataKota.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
    };
}

class DataKota {
    String? id;
    String? provinceId;
    String? name;

    DataKota({
        this.id,
        this.provinceId,
        this.name,
    });

    factory DataKota.fromJson(Map<String, dynamic> json) => DataKota(
        id: json["id"],
        provinceId: json["province_id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "province_id": provinceId,
        "name": name,
    };
}
