import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:paguyuban/models/bagian.dart';
import 'package:paguyuban/services/api.dart';
import 'dart:developer' as dev;

import 'package:shared_preferences/shared_preferences.dart';

class BagianViewModel extends ChangeNotifier {
  List<Databagian> bagian = [];
  ResBagian resbagian = ResBagian();
  int currentPage = 1;
  int? lastPage;
  dataBagian() async {
     final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      http.Response hasil = await http.get(
        Uri.parse("${Api.server}api/member/bagian?page=1"),
        headers: {
          "Accept": "application/json",
          "Authorization":
              "Bearer $token",
        },
      );
      if (hasil.statusCode == 200) {
        resbagian =
            resBagianFromJson(hasil.body); 
        bagian = resbagian.data?.data ??
            []; 
        currentPage =
            resbagian.data?.currentPage ?? 1; 
        lastPage = resbagian.data?.lastPage; 
        notifyListeners(); 
      }
    } catch (e) {
      print('Error: $e');
    }
  } 

 String getNamaBagianById(String? bagianId) {
  if (bagianId == null) return 'ID tidak valid';

  
  bagianId = bagianId.trim();
  dev.log("bagianId: $bagianId");

 
  int? idInt;
  try {
    idInt = int.parse(bagianId);
  } catch (e) {
    dev.log('Error parsing ID: $e');
    return 'ID tidak valid';
  }

  
  dev.log("Daftar bagian: ${bagian.map((item) => 'ID: ${item.id}, Nama: ${item.nama}').toList()}");

 
  for (var bagianItem in bagian) {
    dev.log('Memeriksa bagianItem dengan ID: ${bagianItem.id}');
    if (bagianItem.id == idInt) {
      return bagianItem.nama ?? 'Nama tidak tersedia';
    }
  }
  return 'Nama tidak ditemukan';
}

}
