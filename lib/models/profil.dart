// To parse this JSON data, do
//
//     final resProfil = resProfilFromJson(jsonString);

import 'dart:convert';

ResProfil resProfilFromJson(String str) => ResProfil.fromJson(json.decode(str));

String resProfilToJson(ResProfil data) => json.encode(data.toJson());

Member profilFromJson(String str) => Member.fromJson(json.decode(str));

String profilToJson(ResProfil data) => json.encode(data.toJson());

class ResProfil {
  bool? success;
  Data? data;
  String? message;

  ResProfil({
    this.success,
    this.data,
    this.message,
  });

  factory ResProfil.fromJson(Map<String, dynamic> json) => ResProfil(
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
  Member? member;
  String? appVersion;

  Data({
    this.member,
    this.appVersion,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        member: json["member"] == null ? null : Member.fromJson(json["member"]),
        appVersion: json["app_version"],
      );

  Map<String, dynamic> toJson() => {
        "member": member?.toJson(),
        "app_version": appVersion,
      };
}

class Member {
  int? id;
  String? memberId;
  String? name;
  String? nik;
  dynamic birthplace;
  DateTime? birthdate;
  String? religion;
  dynamic education;
  dynamic occupation;
  String? address;
  dynamic organization;
  String? phone;
  String? districtId;
  String? regencyId;
  String? provinceId;
  String? jabatan;
  String? email;
  dynamic note;
  dynamic photo;
  dynamic photoIdcard;
  DateTime? joinDate;
  int? status;
  int? createdBy;
  int? updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  dynamic jenisUsahaId;
  Provinsi? provinsi;
  Kabkot? kabkot;
  Kecamatan? kecamatan;

  Member({
    this.id,
    this.memberId,
    this.name,
    this.nik,
    this.birthplace,
    this.birthdate,
    this.religion,
    this.education,
    this.occupation,
    this.address,
    this.organization,
    this.phone,
    this.districtId,
    this.regencyId,
    this.provinceId,
    this.jabatan,
    this.email,
    this.note,
    this.photo,
    this.photoIdcard,
    this.joinDate,
    this.status,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.jenisUsahaId,
    this.provinsi,
    this.kabkot,
    this.kecamatan,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json["id"],
        memberId: json["member_id"],
        name: json["name"],
        nik: json["nik"],
        birthplace: json["birthplace"],
        birthdate: json["birthdate"] == null
            ? null
            : DateTime.parse(json["birthdate"]),
        religion: json["religion"],
        education: json["education"],
        occupation: json["occupation"],
        address: json["address"],
        organization: json["organization"],
        phone: json["phone"],
        districtId: json["district_id"],
        regencyId: json["regency_id"],
        provinceId: json["province_id"],
        jabatan: json["jabatan"],
        email: json["email"],
        note: json["note"],
        photo: json["photo"],
        photoIdcard: json["photo_idcard"],
        joinDate: json["join_date"] == null
            ? null
            : DateTime.parse(json["join_date"]),
        status: json["status"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        jenisUsahaId: json["jenis_usaha_id"],
        provinsi: json["provinsi"] == null
            ? null
            : Provinsi.fromJson(json["provinsi"]),
        kabkot: json["kabkot"] == null ? null : Kabkot.fromJson(json["kabkot"]),
        kecamatan: json["kecamatan"] == null
            ? null
            : Kecamatan.fromJson(json["kecamatan"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "member_id": memberId,
        "name": name,
        "nik": nik,
        "birthplace": birthplace,
        "birthdate":
            "${birthdate!.year.toString().padLeft(4, '0')}-${birthdate!.month.toString().padLeft(2, '0')}-${birthdate!.day.toString().padLeft(2, '0')}",
        "religion": religion,
        "education": education,
        "occupation": occupation,
        "address": address,
        "organization": organization,
        "phone": phone,
        "district_id": districtId,
        "regency_id": regencyId,
        "province_id": provinceId,
        "jabatan": jabatan,
        "email": email,
        "note": note,
        "photo": photo,
        "photo_idcard": photoIdcard,
        "join_date":
            "${joinDate!.year.toString().padLeft(4, '0')}-${joinDate!.month.toString().padLeft(2, '0')}-${joinDate!.day.toString().padLeft(2, '0')}",
        "status": status,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "jenis_usaha_id": jenisUsahaId,
        "provinsi": provinsi?.toJson(),
        "kabkot": kabkot?.toJson(),
        "kecamatan": kecamatan?.toJson(),
      };
}

class Kabkot {
  String? id;
  String? provinceId;
  String? name;

  Kabkot({
    this.id,
    this.provinceId,
    this.name,
  });

  factory Kabkot.fromJson(Map<String, dynamic> json) => Kabkot(
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

class Kecamatan {
  String? id;
  String? regencyId;
  String? name;
  String? lat;
  String? long;

  Kecamatan({
    this.id,
    this.regencyId,
    this.name,
    this.lat,
    this.long,
  });

  factory Kecamatan.fromJson(Map<String, dynamic> json) => Kecamatan(
        id: json["id"],
        regencyId: json["regency_id"],
        name: json["name"],
        lat: json["lat"],
        long: json["long"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "regency_id": regencyId,
        "name": name,
        "lat": lat,
        "long": long,
      };
}

class Provinsi {
  String? id;
  String? name;

  Provinsi({
    this.id,
    this.name,
  });

  factory Provinsi.fromJson(Map<String, dynamic> json) => Provinsi(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
