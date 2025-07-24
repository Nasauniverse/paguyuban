import 'package:flutter/material.dart';
import 'package:paguyuban/models/jenis_usaha.dart';
import 'package:http/http.dart' as http;

import 'package:paguyuban/services/api.dart';
import 'dart:developer' as dev;

import 'package:shared_preferences/shared_preferences.dart';

class JenisUsahaViewModel extends ChangeNotifier {
  List<DataJenisUsaha> jenisUsaha = [];
  ResJenisUsaha resJenisUsaha = ResJenisUsaha();

  dataJenisUsaha() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      http.Response hasil = await http.get(
          Uri.parse("${Api.server}api/member/jenis-usaha?page=1"),
          headers: {
            "accept": "application/json",
            "Authorization": "Bearer $token"
          });
      if (hasil.statusCode == 200) {
        resJenisUsaha = resJenisUsahaFromJson(hasil.body);
        jenisUsaha = resJenisUsaha.data!.data!;
        notifyListeners();
      }
    } catch (e) {
      dev.log("error $e");
    }
  }

   String getNameJenisUsaha(String? jenisUsahaId) {
    if (jenisUsahaId == null) return 'ID tidak valid';

    // Trim dan log ID yang diterima
    jenisUsahaId = jenisUsahaId.trim();
    dev.log("jenisUsahaId: $jenisUsahaId");

    // Konversi jenisUsahaId ke integer
    int? idInt;
    try {
      idInt = int.parse(jenisUsahaId);
    } catch (e) {
      dev.log('Error parsing ID: $e');
      return 'ID tidak valid';
    }

    // Log daftar jenis usaha untuk verifikasi
    dev.log("Daftar jenis usaha: ${jenisUsaha.map((item) => 'ID: ${item.id}, Nama: ${item.nama}').toList()}");

    // Loop melalui jenis usaha untuk mencari ID yang cocok
    for (var jenisItem in jenisUsaha) {
      dev.log('Memeriksa jenisItem dengan ID: ${jenisItem.id}');
      if (jenisItem.id == idInt) {
        return jenisItem.nama ?? 'Nama tidak tersedia';
      }
    }
    return 'Nama tidak ditemukan';
  }
}
