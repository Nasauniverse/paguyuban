import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paguyuban/others/colors.dart';
import 'package:paguyuban/provider/bagian_view_model.dart';
import 'package:paguyuban/provider/berita_view_model.dart';
import 'package:paguyuban/provider/infografis_view_model.dart';
import 'package:paguyuban/provider/jenis_usaha_view_model.dart';
import 'package:paguyuban/provider/kepengurusan_view_model.dart';
import 'package:paguyuban/provider/maps_view_model.dart';
import 'package:paguyuban/provider/profil_view_model.dart';
import 'package:paguyuban/provider/unit_paguyuban_view_model.dart';
import 'package:paguyuban/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as dev;

class SplashScreenViewModel extends ChangeNotifier {
  String route = "/home";
  bool isLoggedIn = false;

  setRoute(String route) {
    this.route = route;
    notifyListeners();
  }

  checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    notifyListeners();
  }
initSplash(context) async {
  final prefs = await SharedPreferences.getInstance();
  isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  // Tampilkan loading indicator sementara
        showDialog(
          context: context,
          barrierDismissible:
              false, // Mencegah dialog ditutup saat diklik di luar
          builder: (BuildContext context) {
            return AlertDialog(
                backgroundColor: Colors.transparent,
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 10,
                      // height: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/logo.png"),
                              fit: BoxFit.fitHeight)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 3),
                      child: LinearProgressIndicator(
                        color: ColorLibrary.primary,
                        borderRadius: BorderRadius.circular(5),
                        backgroundColor: ColorLibrary.third,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Memuat ulang halaman...",
                        style: GoogleFonts.robotoCondensed(
                            fontWeight: FontWeight.w700,
                            color: ColorLibrary.shadow),
                      ),
                    )
                  ],
                ));
          },
        );

  if (isLoggedIn) {
    try {
      await fulldata(context); 
      Navigator.pop(context); 
      Navigator.pushReplacementNamed(context, dashboardRoute);
    } catch (e) {
      Navigator.pop(context); 
      dev.log("Error: $e");
    }
  } else {
    Navigator.pop(context); 
    dev.log("data kosong");
    Navigator.pushReplacementNamed(context, loginRoute);
  }
}

  // );
// }
fulldata(context) async {
  try {
    await Future.wait<void>([
      Provider.of<JenisUsahaViewModel>(context, listen: false).dataJenisUsaha(),
      Provider.of<BagianViewModel>(context, listen: false).dataBagian(),
      Provider.of<ProfilViewModel>(context, listen: false).dataProfil(),
      Provider.of<BeritaViewModel>(context, listen: false).dataBerita(),
      Provider.of<InfografisViewModel>(context, listen: false).dataInfografis(),
      Provider.of<KepengurusanViewModel>(context, listen: false).dataKepengurusan(),
      Provider.of<MapsViewModel>(context, listen: false).dataMember(),
      Provider.of<UnitPaguyubanViewModel>(context, listen: false).dataUnit(),
    ]);
  } catch (e) {
    dev.log("Error: $e");
  }
}


}
