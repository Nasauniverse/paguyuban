import 'package:flutter/material.dart';
import 'package:paguyuban/models/bagian.dart';
import 'package:paguyuban/models/kepengurusan.dart';
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;
import 'package:paguyuban/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KepengurusanViewModel extends ChangeNotifier {
  ResKepengurusan resKepengurusan = ResKepengurusan();
  List<DataKepengurusan> kepengurusan = [];
  int currentPage = 1;
  int? lastPage;
  bool isLoading = false;

  ResBagian resBagian = ResBagian();

  // dataBagian({int page = 1}) async {
  //   try {
  //     http.Response hasil = await http.get(
  //         Uri.parse("${Api.server}api/member/bagian?page=$page"),
  //         headers: {
  //           "Accept": "application/json",
  //           "Authorization":
  //               "Bearer 3037|znH4VczhJn3nbgEASTU9zxEpBcC1vUI82tyswblb"
  //         });
  //     if (hasil.statusCode == 200) {
  //       resBagian = resBagianFromJson(hasil.body);
  //       bagian = resBagian.data!.data!;

  //       dev.log("${bagian.first.nama}");
  //     }
  //   } catch (e) {
  //     dev.log('error $e');
  //   }
  // }

  dataKepengurusan({int page = 1}) async {
     final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    isLoading = true;
    notifyListeners();
    try {
      http.Response hasil = await http.get(
          Uri.parse("${Api.server}api/member/kepengurusan?page=$page"),
          headers: {
            "Accept": "application/json",
            "Authorization":
                "Bearer $token"
          });
      if (hasil.statusCode == 200) {
        resKepengurusan = resKepengurusanFromJson(hasil.body);
        currentPage = resKepengurusan.data!.currentPage ?? 1;
        lastPage = resKepengurusan.data!.lastPage;
        kepengurusan = resKepengurusan.data!.data!;
        kepengurusan.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
        dev.log("berhasil menampilkan data kepengurusan");
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
      dataKepengurusan(page: currentPage + 1);
    }
  }

  forwardPage() {
    if (currentPage > 1) {
      dataKepengurusan(page: currentPage - 1);
    }
  }
}
