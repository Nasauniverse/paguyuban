// To parse this JSON data, do
//
//     final resBerita = resBeritaFromJson(jsonString);

import 'dart:convert';

ResBerita resBeritaFromJson(String str) => ResBerita.fromJson(json.decode(str));

String resBeritaToJson(ResBerita data) => json.encode(data.toJson());

class ResBerita {
    int? status;
    Data? data;

    ResBerita({
        this.status,
        this.data,
    });

    factory ResBerita.fromJson(Map<String, dynamic> json) => ResBerita(
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
    List<Berita>? data;
    String? firstPageUrl;
    int? from;
    int? lastPage;
    String? lastPageUrl;
    List<Link>? links;
    String? nextPageUrl;
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
        data: json["data"] == null ? [] : List<Berita>.from(json["data"]!.map((x) => Berita.fromJson(x))),
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

class Berita {
    int? id;
    String? judul;
    String? slug;
    String? description;
    String? attachment;
    DateTime? createdAt;
    DateTime? updatedAt;

    Berita({
        this.id,
        this.judul,
        this.slug,
        this.description,
        this.attachment,
        this.createdAt,
        this.updatedAt,
    });

    factory Berita.fromJson(Map<String, dynamic> json) => Berita(
        id: json["id"],
        judul: json["judul"],
        slug: json["slug"],
        description: json["description"],
        attachment: json["attachment"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "judul": judul,
        "slug": slug,
        "description": description,
        "attachment": attachment,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
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
