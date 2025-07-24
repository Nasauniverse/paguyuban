import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paguyuban/models/berita.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;
import 'package:paguyuban/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BeritaViewModel extends ChangeNotifier {
  List<Berita> berita = [];
  ResBerita resBerita = ResBerita();
  Berita detailBerita = Berita();
  var search = TextEditingController();
  bool isSearching = false;
  int currentPage = 1;
  int? lastPage;
  bool isLoading = false;

  Future<void> dataBerita({int page = 1}) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    isLoading = true;
    notifyListeners();
    // String token = await TokenShared.getToken();
    // EasyLoading.show(status: 'Loading...');
    try {
      isSearching = search.text.isNotEmpty;
      http.Response hasil = await http.get(
          Uri.parse('${Api.server}api/member/berita?q=${search.text}'),
          headers: {
            "accept": "application/json",
            "Authorization": "Bearer $token"
          });
      // dev.log(hasil.body);
      if (hasil.statusCode == 200) {
        resBerita = resBeritaFromJson(hasil.body);
        currentPage = resBerita.data!.currentPage ?? 1;
        lastPage = resBerita.data!.lastPage;
        berita = resBerita.data!.data!;
        berita.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
        // dev.log(hasil.body);
        dev.log("data berita berhasil tampil");
        notifyListeners();
      }
    } catch (e) {
      dev.log('error : $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

String formattedNews(int index) {
  if (berita != null && berita.isNotEmpty && berita[index].createdAt != null) {
    return DateFormat('yyyy MMMM dd', 'id_ID').format(berita[index].createdAt!);
  }
  return 'Tanggal berita tidak tersedia';
}



  resetSearch() {
    search.clear();
    isSearching = false;
    notifyListeners();
  }

  getDetailBerita(Berita detailBerita) {
    this.detailBerita = detailBerita;
    notifyListeners();
  }

  nextPage() {
    if (currentPage < (lastPage ?? 1)) {
      dataBerita(page: currentPage + 1);
    }
  }

  forwardPage() {
    if (currentPage > 1) {
      dataBerita(page: currentPage - 1);
    }
  }
}
