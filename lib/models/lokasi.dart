// To parse this JSON data, do
//
//     final resLocation = resLocationFromJson(jsonString);

import 'dart:convert';

ResLocation resLocationFromJson(String str) =>
    ResLocation.fromJson(json.decode(str));

String resLocationToJson(ResLocation data) => json.encode(data.toJson());

class ResLocation {
  bool? success;
  List<Maps>? data;
  String? message;

  ResLocation({
    this.success,
    this.data,
    this.message = "",
  });

  factory ResLocation.fromJson(Map<String, dynamic> json) => ResLocation(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<Maps>.from(json["data"]!.map((x) => Maps.fromJson(x))),
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

class Maps {
  String? id;
  String? regencyId;
  String? name;
  double? lat;
  double? long;
  int? membersCount;

  Maps({
    this.id = "",
    this.regencyId = "",
    this.name = "",
    this.lat ,
    this.long ,
    this.membersCount = 0,
  });

  factory Maps.fromJson(Map<String, dynamic> json) => Maps(
        id: json["id"] ?? "",
        regencyId: json["regency_id"] ?? "",
        name: json["name"] ?? "",
        lat: json["lat"] != null ? double.parse(json["lat"]) : 0.0,
        long: json["long"] != null ? double.parse(json["long"]) : 0.0,
        membersCount: json["members_count"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? "",
        "regency_id": regencyId ?? "",
        "name": name ?? "",
        "lat": lat ?? "",
        "long": long ?? "",
        "members_count": membersCount ?? 0,
      };
}
