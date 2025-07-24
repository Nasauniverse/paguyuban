// To parse this JSON data, do
//
//     final resKepengurusan = resKepengurusanFromJson(jsonString);

import 'dart:convert';

ResKepengurusan resKepengurusanFromJson(String str) => ResKepengurusan.fromJson(json.decode(str));

String resKepengurusanToJson(ResKepengurusan data) => json.encode(data.toJson());

class ResKepengurusan {
    int? status;
    Data? data;

    ResKepengurusan({
        this.status,
        this.data,
    });

    factory ResKepengurusan.fromJson(Map<String, dynamic> json) => ResKepengurusan(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
    };
}

class Data {
    int? currentPage;
    List<DataKepengurusan>? data;
    String? firstPageUrl;
    int? from;
    int? lastPage;
    String? lastPageUrl;
    List<Link>? links;
    dynamic nextPageUrl;
    String? path;
    int? perPage;
    dynamic prevPageUrl;
    int? to;
    int? total;

    Data({
        this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<DataKepengurusan>.from(json["data"]!.map((x) => DataKepengurusan.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
    };
}

class DataKepengurusan {
    int? id;
    String? nama;
    String? jabatan;
    String? bagian;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? image;

    DataKepengurusan({
        this.id,
        this.nama,
        this.jabatan,
        this.bagian,
        this.createdAt,
        this.updatedAt,
        this.image,
    });

    factory DataKepengurusan.fromJson(Map<String, dynamic> json) => DataKepengurusan(
        id: json["id"],
        nama: json["nama"],
        jabatan: json["jabatan"],
        bagian: json["bagian"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "jabatan": jabatan,
        "bagian": bagian,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "image": image,
    };
}

class Link {
    String? url;
    String? label;
    bool? active;

    Link({
        this.url,
        this.label,
        this.active,
    });

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
    };
}
