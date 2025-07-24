import 'package:flutter/material.dart';
import 'package:paguyuban/models/unit.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;

import 'package:paguyuban/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UnitPaguyubanViewModel extends ChangeNotifier {
  ResUnit resUnit = ResUnit();
  List<DataUnit> unit = [];
  int currentPage = 1;
  int? lastPage;
  bool isLoading = false;

  dataUnit({int page = 1}) async {
     final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    isLoading = true;
    notifyListeners();
    try {
      http.Response hasil = await http
          .get(Uri.parse("${Api.server}api/member/unit?page=$page"), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      });
      if (hasil.statusCode == 200) {
        resUnit = resUnitFromJson(hasil.body);
        currentPage = resUnit.data!.currentPage ?? 1;
        lastPage = resUnit.data!.lastPage;
        unit = resUnit.data!.data!;
        unit.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
        // dev.log(hasil.body);
        dev.log("data unit berhasil tampil");
        notifyListeners();
      }
    } catch (e) {
      dev.log('error $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  nextPage() {
    if (currentPage < (lastPage ?? 1)) {
      dataUnit(page: currentPage + 1);
    }
  }

  forwardPage() {
    if (currentPage < 1) {
      dataUnit(page: currentPage - 1);
    }
  }
}
