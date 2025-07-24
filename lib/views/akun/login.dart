import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paguyuban/provider/akun_view_model.dart';
import 'package:paguyuban/provider/berita_view_model.dart';
import 'package:paguyuban/provider/home_view_model.dart';
import 'package:paguyuban/provider/infografis_view_model.dart';
import 'package:paguyuban/provider/kepengurusan_view_model.dart';
import 'package:paguyuban/provider/maps_view_model.dart';
import 'package:paguyuban/provider/profil_view_model.dart';
import 'package:paguyuban/provider/unit_paguyuban_view_model.dart';
import 'package:paguyuban/routes/routes.dart';
import 'package:provider/provider.dart';

import '../../others/colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeViewModel, AkunViewModel>(
      builder: (context, model, modelLogin, _) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/backwhite.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    color: const Color.fromARGB(50, 0, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 27),
                            Image.asset(
                              "assets/images/logo.png",
                              width: 120,
                            ),
                            SizedBox(height: 7),
                            Text(
                              "Aplikasi Keanggotaan",
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                decoration: TextDecoration.none,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "PAGUYUBAN PASUNDAN",
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.none,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 50),
                        Text(
                          "Sign In",
                          style: GoogleFonts.roboto(
                            color: ColorLibrary.third,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.w700,
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "No. Keanggotaan",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  decoration: TextDecoration.none,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border:
                                    Border.all(width: 1, color: Colors.white),
                              ),
                              child: Material(
                                color: const Color.fromARGB(35, 248, 248, 248),
                                borderRadius: BorderRadius.circular(10.0),
                                child: TextField(
                                  // controller: tecUsername,
                                  style: GoogleFonts.roboto(
                                    textStyle: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                  controller: modelLogin.username,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: Colors.white,
                                  cursorWidth: 1,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.all(5),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                    hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 143, 143, 143),
                                    ),
                                    // hintText: "Email",
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "Kata Sandi",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  decoration: TextDecoration.none,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border:
                                    Border.all(width: 1, color: Colors.white),
                              ),
                              child: Material(
                                color: const Color.fromARGB(35, 248, 248, 248),
                                borderRadius: BorderRadius.circular(10.0),
                                child: TextField(
                                  // controller: tecPassword,
                                  style: GoogleFonts.roboto(
                                    textStyle: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                  controller: modelLogin.password,
                                  cursorColor: Colors.white,
                                  cursorWidth: 1,
                                  obscureText: modelLogin.isObscured,
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(10),
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.lock_outline,
                                        color: Colors.white,
                                      ),
                                      suffixIcon: IconButton(
                                          onPressed: modelLogin.toggleObscured,
                                          icon: Icon(
                                            modelLogin.isObscured
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Colors.white,
                                          ))),
                                ),
                              ),
                            ),
                            SizedBox(height: 25),
                            InkWell(
                              borderRadius: BorderRadius.circular(20),
                              highlightColor: ColorLibrary.primarySuperDark,
                              onTap: () {
                                Provider.of<AkunViewModel>(context,
                                        listen: false)
                                    .datumShared();
                                // fulldata(context);
                                Provider.of<AkunViewModel>(context,
                                        listen: false)
                                    .loginPaguyuban(context);
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                height: 50,
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        ColorLibrary.primarySuperDark,
                                        ColorLibrary
                                            .primaryLow, // Warna hijau sedikit lebih gelap
                                        ColorLibrary
                                            .primary, // Warna hijau utama
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.login_outlined,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Masuk",
                                      style: GoogleFonts.roboto(
                                          textStyle: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Belum punya akun?",
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    decoration: TextDecoration.none,
                                    fontSize: 17,
                                  ),
                                ),
                                SizedBox(width: 5),
                                InkWell(
                                  onTap: () {
                                    //provider
                                    Provider.of<AkunViewModel>(context,
                                            listen: false)
                                        .dataAgama(context);
                                    Provider.of<AkunViewModel>(context,
                                            listen: false)
                                        .dataEdukasi(context);
                                    Provider.of<AkunViewModel>(context,
                                            listen: false)
                                        .dataPekerjaan(context);
                                    Provider.of<AkunViewModel>(context,
                                            listen: false)
                                        .dataProvinsi(context);
                                    Provider.of<AkunViewModel>(context,
                                            listen: false)
                                        .dataKota(context);
                                    Provider.of<AkunViewModel>(context,
                                            listen: false)
                                        .dataKecamatan(context);
                                    //Navigator
                                    Navigator.pushNamed(context, signUpRoute);
                                  },
                                  child: Text(
                                    "Daftar disini",
                                    textAlign: TextAlign.right,
                                    style: GoogleFonts.roboto(
                                      color: ColorLibrary.third,
                                      fontWeight: FontWeight.w700,
                                      decoration: TextDecoration.none,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 35),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // fulldata(context) {
  //   Provider.of<ProfilViewModel>(context, listen: false).dataProfil();
  //   Provider.of<BeritaViewModel>(context, listen: false).dataBerita();
  //   Provider.of<InfografisViewModel>(context, listen: false).dataInfografis();
  //   Provider.of<KepengurusanViewModel>(context, listen: false)
  //       .dataKepengurusan();
  //   Provider.of<MapsViewModel>(context, listen: false).dataMember();
  //   Provider.of<UnitPaguyubanViewModel>(context, listen: false).dataUnit();
  // }
}
