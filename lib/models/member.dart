// To parse this JSON data, do
//
//     final resMembers = resMembersFromJson(jsonString);

import 'dart:convert';

ResMembers resMembersFromJson(String str) =>
    ResMembers.fromJson(json.decode(str));

String resMembersToJson(ResMembers data) => json.encode(data.toJson());

class ResMembers {
  bool? success;
  List<Datum>? data;
  String? message;

  ResMembers({
    this.success,
    this.data,
    this.message,
  });

  factory ResMembers.fromJson(Map<String, dynamic> json) => ResMembers(
        success: json["success"],
        data: (json["data"] as List<dynamic>?)
                ?.map((x) => Datum.fromJson(x))
                .toList() ??
            [],
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

class Datum {
  String? id;
  String? regencyId;
  String? name;
  double? lat;
  double? long;
  int? membersCount;
  List<Member>? members;

  Datum({
    this.id,
    this.regencyId,
    this.name,
    this.lat,
    this.long,
    this.membersCount,
    this.members,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        regencyId: json["regency_id"],
        name: json["name"],
        lat: json["lat"] != null ? double.tryParse(json["lat"].toString()) : null,
        long: json["long"] != null ? double.tryParse(json["long"].toString()) : null,
        membersCount: json["members_count"],
    members: (json["members"] as List<dynamic>?)
      ?.map((x) => Member.fromJson(x))
      .toList() ?? [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "regency_id": regencyId,
        "name": name,
        "lat": lat,
        "long": long,
        "members_count": membersCount,
        "members": members == null
            ? []
            : List<dynamic>.from(members!.map((x) => x.toJson())),
      };
}

class Member {
  int? id;
  String? memberId;
  String? name;
  String? nik;
  String? birthplace;
  DateTime? birthdate;
  Religion? religion;
  Education? education;
  Occupation? occupation;
  String? address;
  dynamic organization;
  String? phone;
  String? districtId;
  String? regencyId;
  String? provinceId;
  String? note;
  String? photo;
  String? photoIdcard;
  DateTime? joinDate;
  int? status;
  int? createdBy;
  int? updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? jenisUsahaId;

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
        religion: json["religion"] != null
            ? religionValues.map[json["religion"]]
            : null,
        education: json["education"] != null
            ? educationValues.map[json["education"]]
            : null,
        occupation: json["occupation"] != null
            ? occupationValues.map[json["occupation"]]
            : null,
        address: json["address"],
        organization: json["organization"],
        phone: json["phone"],
        districtId: json["district_id"],
        regencyId: json["regency_id"],
        provinceId: json["province_id"],
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "member_id": memberId,
        "name": name,
        "nik": nik,
        "birthplace": birthplace,
        "birthdate":
            "${birthdate!.year.toString().padLeft(4, '0')}-${birthdate!.month.toString().padLeft(2, '0')}-${birthdate!.day.toString().padLeft(2, '0')}",
        "religion": religionValues.reverse[religion],
        "education": educationValues.reverse[education],
        "occupation": occupationValues.reverse[occupation],
        "address": address,
        "organization": organization,
        "phone": phone,
        "district_id": districtId,
        "regency_id": regencyId,
        "province_id": provinceId,
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
      };
}

enum Education {
  D1,
  D2,
  D3,
  D4,
  LAINNYA,
  PAKET_B,
  PAKET_C,
  PUTUS_SD,
  S1,
  S2,
  S3,
  SD_SEDERAJAT,
  SMA_SEDERAJAT,
  SMP_SEDERAJAT,
  TIDAK_DIISI,
  TIDAK_SEKOLAH
}

final educationValues = EnumValues({
  "D1": Education.D1,
  "D2": Education.D2,
  "D3": Education.D3,
  "D4": Education.D4,
  "Lainnya": Education.LAINNYA,
  "Paket B": Education.PAKET_B,
  "Paket C": Education.PAKET_C,
  "Putus SD": Education.PUTUS_SD,
  "S1": Education.S1,
  "S2": Education.S2,
  "S3": Education.S3,
  "SD / sederajat": Education.SD_SEDERAJAT,
  "SMA / sederajat": Education.SMA_SEDERAJAT,
  "SMP / sederajat": Education.SMP_SEDERAJAT,
  "(tidak diisi)": Education.TIDAK_DIISI,
  "Tidak sekolah": Education.TIDAK_SEKOLAH
});

enum Occupation {
  BURUH,
  DOSEN,
  GURU,
  KARYAWAN_SWASTA,
  LAINNYA,
  NELAYAN,
  PEDAGANG_BESAR,
  PEDAGANG_KECIL,
  PENSIUNAN,
  PETANI,
  PETERNAK,
  PNS_TNI_POLRI,
  TENAGA_KERJA_INDONESIA,
  TIDAK_BEKERJA,
  TIDAK_DIISI,
  WIRASWASTA,
  WIRAUSAHA
}

final occupationValues = EnumValues({
  "Buruh": Occupation.BURUH,
  "Dosen": Occupation.DOSEN,
  "Guru": Occupation.GURU,
  "Karyawan Swasta": Occupation.KARYAWAN_SWASTA,
  "Lainnya": Occupation.LAINNYA,
  "Nelayan": Occupation.NELAYAN,
  "Pedagang Besar": Occupation.PEDAGANG_BESAR,
  "Pedagang Kecil": Occupation.PEDAGANG_KECIL,
  "Pensiunan": Occupation.PENSIUNAN,
  "Petani": Occupation.PETANI,
  "Peternak": Occupation.PETERNAK,
  "PNS/TNI/Polri": Occupation.PNS_TNI_POLRI,
  "Tenaga Kerja Indonesia": Occupation.TENAGA_KERJA_INDONESIA,
  "Tidak bekerja": Occupation.TIDAK_BEKERJA,
  "(tidak diisi)": Occupation.TIDAK_DIISI,
  "Wiraswasta": Occupation.WIRASWASTA,
  "Wirausaha": Occupation.WIRAUSAHA
});

enum Religion { ISLAM, KATHOLIK, KRISTEN, TIDAK_DIISI }

final religionValues = EnumValues({
  "Islam": Religion.ISLAM,
  "Katholik": Religion.KATHOLIK,
  "Kristen": Religion.KRISTEN,
  "Tidak diisi": Religion.TIDAK_DIISI
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
