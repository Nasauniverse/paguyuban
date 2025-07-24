import 'package:flutter/material.dart';
import 'package:paguyuban/models/infografis.dart';
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;
import 'package:paguyuban/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfografisViewModel extends ChangeNotifier {
  List<DataInfografis> infografis = [];
  ResInfografis resInfografis = ResInfografis();
  DataInfografis detailInfografis = DataInfografis();
  int currentPage = 1;
  int? lastPage;
  bool isLoading = false;
  Future<void> dataInfografis({int page = 1}) async {
     final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    isLoading = true;
    notifyListeners();
    try {
      http.Response hasil = await http.get(
        Uri.parse("${Api.server}api/member/infografis?page=$page"),
        headers: {
          "Accept": "application/json",
          "Authorization":
              "Bearer $token",
        },
      );

      if (hasil.statusCode == 200) {
        resInfografis = resInfografisFromJson(hasil.body);
        currentPage = resInfografis.data?.currentPage ?? 1;
        lastPage = resInfografis.data?.lastPage;
        infografis = resInfografis.data?.data ?? [];

        // Sort the infografis based on createdAt if it's not null
        infografis.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
        dev.log("data infografis berhasil tampil");
        // dev.log('data pada bagian $currentPage: ${infografis.length} item');
      } else {
        dev.log('Error fetching data: ${hasil.statusCode}');
      }
    } catch (e) {
      dev.log('Error: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void getDetailInfografis(DataInfografis detailInfografisprm) {
    detailInfografis = detailInfografisprm;
    notifyListeners();
  }

  Future<void> nextPage() async {
    if (currentPage < (lastPage ?? 1)) {
      await dataInfografis(page: currentPage + 1);
    }
  }

  Future<void> forwardPage() async {
    if (currentPage > 1) {
      await dataInfografis(page: currentPage - 1);
    }
  }

  Future<void> goToPage(int page) async {
    if (page > 0 && page <= (lastPage ?? 1)) {
      currentPage = page;
      await dataInfografis(page: currentPage);
    }
  }
}
