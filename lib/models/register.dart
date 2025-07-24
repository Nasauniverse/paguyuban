// To parse this JSON data, do
//
//     final resRegister = resRegisterFromJson(jsonString);

import 'dart:convert';

ResRegister resRegisterFromJson(String str) => ResRegister.fromJson(json.decode(str));

String resRegisterToJson(ResRegister data) => json.encode(data.toJson());

class ResRegister {
    bool? success;
    Data? data;
    String? message;

    ResRegister({
        this.success,
        this.data,
        this.message,
    });

    factory ResRegister.fromJson(Map<String, dynamic> json) => ResRegister(
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
    String? name;
    String? nik;
    DateTime? birthdate;
    String? address;
    String? religion;
    String? districtId;
    String? regencyId;
    String? provinceId;
    String? phone;
    String? occupation;
    String? education;
    String? memberId;
    int? status;
    int? createdBy;
    int? updatedBy;
    DateTime? joinDate;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;

    Data({
        this.name,
        this.nik,
        this.birthdate,
        this.address,
        this.religion,
        this.districtId,
        this.regencyId,
        this.provinceId,
        this.phone,
        this.occupation,
        this.education,
        this.memberId,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.joinDate,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        nik: json["nik"],
        birthdate: json["birthdate"] == null ? null : DateTime.parse(json["birthdate"]),
        address: json["address"],
        religion: json["religion"],
        districtId: json["district_id"],
        regencyId: json["regency_id"],
        provinceId: json["province_id"],
        phone: json["phone"],
        occupation: json["occupation"],
        education: json["education"],
        memberId: json["member_id"],
        status: json["status"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        joinDate: json["join_date"] == null ? null : DateTime.parse(json["join_date"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "nik": nik,
        "birthdate": "${birthdate!.year.toString().padLeft(4, '0')}-${birthdate!.month.toString().padLeft(2, '0')}-${birthdate!.day.toString().padLeft(2, '0')}",
        "address": address,
        "religion": religion,
        "district_id": districtId,
        "regency_id": regencyId,
        "province_id": provinceId,
        "phone": phone,
        "occupation": occupation,
        "education": education,
        "member_id": memberId,
        "status": status,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "join_date": "${joinDate!.year.toString().padLeft(4, '0')}-${joinDate!.month.toString().padLeft(2, '0')}-${joinDate!.day.toString().padLeft(2, '0')}",
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };
}
