// To parse this JSON data, do
//
//     final resKecamatan = resKecamatanFromJson(jsonString);

import 'dart:convert';

ResKecamatan resKecamatanFromJson(String str) => ResKecamatan.fromJson(json.decode(str));

String resKecamatanToJson(ResKecamatan data) => json.encode(data.toJson());

class ResKecamatan {
    bool? success;
    List<DataKecamatan>? data;
    String? message;

    ResKecamatan({
        this.success,
        this.data = const [],
        this.message,
    });

    factory ResKecamatan.fromJson(Map<String, dynamic> json) => ResKecamatan(
        success: json["success"],
        data: json["data"] == null ? [] : List<DataKecamatan>.from(json["data"]!.map((x) => DataKecamatan.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
    };
}

class DataKecamatan {
    String? id;
    String? regencyId;
    String? name;

    DataKecamatan({
        this.id,
        this.regencyId,
        this.name,
    });

    factory DataKecamatan.fromJson(Map<String, dynamic> json) => DataKecamatan(
        id: json["id"],
        regencyId: json["regency_id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "regency_id": regencyId,
        "name": name,
    };
}
