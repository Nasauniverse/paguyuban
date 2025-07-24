// To parse this JSON data, do
//
//     final resLogin = resLoginFromJson(jsonString);

import 'dart:convert';

ResLogin resLoginFromJson(String str) => ResLogin.fromJson(json.decode(str));

String resLoginToJson(ResLogin data) => json.encode(data.toJson());

class ResLogin {
    bool? success;
    Data? data;
    List<String>? message;

    ResLogin({
        this.success,
        this.data,
        this.message,
    });

    factory ResLogin.fromJson(Map<String, dynamic> json) => ResLogin(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
             message: json["message"] == null
            ? null
            : (json["message"] is String)
                ? [json["message"]] // Menangani kasus ketika message adalah string tunggal
                : List<String>.from(json["message"]), // Menangani kasus ketika message adalah list
    );


    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "message": message != null ? List<dynamic>.from(message!) : null,
    };
}

class Data {
    LoginMember? member;
    String? token ;
    String? appVersion;

    Data({
        this.member,
        this.token="",
        this.appVersion="",
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        member: json["member"] == null ? null : LoginMember.fromJson(json["member"]),
        token: json["token"] ??"",
        appVersion: json["app_version"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "member": member?.toJson(),
        "token": token??"",
        "app_version": appVersion??"",
    };
}
class LoginMember {
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
    Provinsi? provinsi;
    Kabkot? kabkot;
    Kecamatan? kecamatan;

    LoginMember({
        this.id=0,
        this.memberId="",
        this.name="",
        this.nik="",
        this.birthplace="",
        this.birthdate,
        this.religion="",
        this.education="",
        this.occupation="",
        this.address="",
        this.organization="",
        this.phone="",
        this.districtId="",
        this.regencyId="",
        this.provinceId="",
        this.note="",
        this.photo="",
        this.photoIdcard="",
        this.joinDate,
        this.status=0,
        this.createdBy=0,
        this.updatedBy=0,
        this.createdAt,
        this.updatedAt,
        this.deletedAt="",
        this.provinsi,
        this.kabkot,
        this.kecamatan,
    });

    factory LoginMember.fromJson(Map<String, dynamic> json) => LoginMember(
        id: json["id"]??0,
        memberId: json["member_id"]??"",
        name: json["name"]??"",
        nik: json["nik"]??"",
        birthplace: json["birthplace"]??"",
        birthdate: json["birthdate"] == null ? null : DateTime.parse(json["birthdate"]),
        religion: json["religion"]??"",
        education: json["education"]??"",
        occupation: json["occupation"]??"",
        address: json["address"]??"",
        organization: json["organization"]??"",
        phone: json["phone"]??"",
        districtId: json["district_id"]??"",
        regencyId: json["regency_id"]??"",
        provinceId: json["province_id"]??"",
        note: json["note"]??"",
        photo: json["photo"]??"",
        photoIdcard: json["photo_idcard"]??"",
        joinDate: json["join_date"] == null ? null : DateTime.parse(json["join_date"]),
        status: json["status"]??0,
        createdBy: json["created_by"]??0,
        updatedBy: json["updated_by"]??0,
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"]??"",
        provinsi:  json["provinsi"] == null ? null : Provinsi.fromJson(json["provinsi"]),
        kabkot: json["kabkot"] == null ? null : Kabkot.fromJson(json["kabkot"]),
        kecamatan: json["kecamatan"] == null ? null : Kecamatan.fromJson(json["kecamatan"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id??0,
        "member_id": memberId??"",
        "name": name??"",
        "nik": nik??"",
        "birthplace": birthplace??"",
        "birthdate": birthdate == null ? "" : "${birthdate!.year.toString().padLeft(4, '0')}-${birthdate!.month.toString().padLeft(2, '0')}-${birthdate!.day.toString().padLeft(2, '0')}",
        "religion": religion??"",
        "education": education??"",
        "occupation": occupation??"",
        "address": address??"",
        "organization": organization??"",
        "phone": phone??"",
        "district_id": districtId??"",
        "regency_id": regencyId??"",
        "province_id": provinceId??"",
        "note": note??"",
        "photo": photo??"",
        "photo_idcard": photoIdcard??"",
        "join_date": joinDate == null ? "" : "${joinDate!.year.toString().padLeft(4, '0')}-${joinDate!.month.toString().padLeft(2, '0')}-${joinDate!.day.toString().padLeft(2, '0')}",
        "status": status??0,
        "created_by": createdBy??0,
        "updated_by": updatedBy??0,
        "created_at": createdAt?.toIso8601String()??"",
        "updated_at": updatedAt?.toIso8601String()??"",
        "deleted_at": deletedAt ??"",
        "provinsi": provinsi?.toJson()??"",
        "kabkot": kabkot?.toJson()??"",
        "kecamatan": kecamatan?.toJson()??"",
    };
}

class Kabkot {
    String? id;
    String? provinceId;
    String? name;

    Kabkot({
        this.id="",
        this.provinceId="",
        this.name="",
    });

    factory Kabkot.fromJson(Map<String, dynamic> json) => Kabkot(
        id: json["id"]??"",
        provinceId: json["province_id"]??"",
        name: json["name"]??"",
    );

    Map<String, dynamic> toJson() => {
        "id": id??"",
        "province_id": provinceId??"",
        "name": name??"",
    };
}

class Kecamatan {
    String? id;
    String? regencyId;
    String? name;
    String? lat;
    String? long;

    Kecamatan({
        this.id="",
        this.regencyId="",
        this.name="",
        this.lat="",
        this.long="",
    });

    factory Kecamatan.fromJson(Map<String, dynamic> json) => Kecamatan(
        id: json["id"]??"",
        regencyId: json["regency_id"]??"",
        name: json["name"]??"",
        lat: json["lat"]??"",
        long: json["long"]??"",
    );

    Map<String, dynamic> toJson() => {
        "id": id??"",
        "regency_id": regencyId??"",
        "name": name??"",
        "lat": lat??"",
        "long": long??"",
    };
}

class Provinsi {
    String? id;
    String? name;

    Provinsi({
        this.id="",
        this.name="",
    });

    factory Provinsi.fromJson(Map<String, dynamic> json) => Provinsi(
        id: json["id"]??"",
        name: json["name"]??"",
    );

    Map<String, dynamic> toJson() => {
        "id": id ??"",
        "name": name??"",
    };
}
