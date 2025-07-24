import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paguyuban/others/colors.dart';
import 'package:paguyuban/provider/profil_view_model.dart';
import 'package:provider/provider.dart';

class EditNama extends StatelessWidget {
  const EditNama({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfilViewModel>(
      builder: (context, model, _) => PopScope(
        onPopInvokedWithResult: (didPop, result) {
          model.deleteUpdate();
        },
        canPop: true,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/backwhite.png"),
                  fit: BoxFit.cover)),
          child: Scaffold(
            backgroundColor: Color.fromARGB(210, 255, 255, 255),
            appBar: AppBar(
              iconTheme: IconThemeData(color: ColorLibrary.shadow),
              backgroundColor: Colors.transparent,
              title: FittedBox(
                child: Text(
                  "Edit Profil",
                  style: GoogleFonts.dancingScript(
                      color: ColorLibrary.shadow,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
              ),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      ColorLibrary.primarySuperDark,
                      ColorLibrary.primaryLow,
                      ColorLibrary.primary
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(20))),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 100, right: 20, left: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Nama Lengkap",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.roboto(
                              color: ColorLibrary.primary,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.none,
                              fontSize: 16)),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border:
                                Border.all(width: 1, color: Colors.black38)),
                        child: Material(
                          color: const Color.fromARGB(35, 248, 248, 248),
                          borderRadius: BorderRadius.circular(10.0),
                          child: TextField(
                            controller: model.nameUpdate,
                            showCursor: true,
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontSize: 14,
                                    color: ColorLibrary.textColor)),
                            textInputAction: TextInputAction.next,
                            cursorColor: Colors.black38,
                            cursorWidth: 1,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              hintStyle: TextStyle(color: Colors.black87),
                              hintText: "Masukkan nama lengkap anda yang baru",
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text("Email ",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.roboto(
                              color: ColorLibrary.primary,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.none,
                              fontSize: 16)),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border:
                                Border.all(width: 1, color: Colors.black38)),
                        child: Material(
                          color: const Color.fromARGB(35, 248, 248, 248),
                          borderRadius: BorderRadius.circular(10.0),
                          child: TextField(
                            controller: model.emailUpdate,
                            showCursor: true,
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontSize: 14,
                                    color: ColorLibrary.textColor)),
                            textInputAction: TextInputAction.next,
                            cursorColor: Colors.black38,
                            cursorWidth: 1,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              hintStyle: TextStyle(color: Colors.black87),
                              hintText: "Masukkan email lengkap anda yang baru",
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text("Alamat",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.roboto(
                              color: ColorLibrary.primary,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.none,
                              fontSize: 16)),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        height: 110,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0),
                                topLeft: Radius.circular(10.0),
                                bottomLeft: Radius.circular(10.0)),
                            border:
                                Border.all(width: 1, color: Colors.black87)),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          physics: const ClampingScrollPhysics(),
                          child: TextField(
                            controller: model.alamatUpdate,
                            showCursor: true,
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontSize: 14,
                                    color: ColorLibrary.textColor)),
                            textInputAction: TextInputAction.newline,
                            cursorColor: ColorLibrary.grey,
                            maxLines: 100,
                            cursorWidth: 1,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              hintStyle: TextStyle(color: Colors.black87),
                              hintText: "Masukkan alamat anda disini",
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                model.alertCameraAndImageUser(context);
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 10),
                                height: MediaQuery.of(context).size.height / 10,
                                width: MediaQuery.of(context).size.width / 3.5,
                                decoration: BoxDecoration(
                                  color: ColorLibrary.primary,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Ambil Foto User",
                                      style: GoogleFonts.robotoCondensed(
                                          fontWeight: FontWeight.bold,
                                          color: ColorLibrary.shadow),
                                    ),
                                    Icon(
                                      Icons.camera_alt,
                                      color: ColorLibrary.shadow,
                                      size: MediaQuery.of(context).size.height /
                                          15,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 190,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: ColorLibrary.primary,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 1, color: Colors.black38)),
                                child: Column(
                                  children: [
                                    Text("Foto Anda",
                                        style: GoogleFonts.roboto(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: ColorLibrary.shadow)),
                                    const SizedBox(height: 10),
                                    Expanded(
                                        child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              width: 0.5,
                                              color: ColorLibrary.shadow)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: model.userImageUpdate != null
                                            ? Image.file(
                                                File(model
                                                    .userImageUpdate!.path),
                                                width: 200,
                                                height: 200,
                                                fit: BoxFit.cover,
                                              )
                                            : model.userCameraUpdate != null
                                                ? Image.file(
                                                    File(model.userCameraUpdate!
                                                        .path),
                                                    width: 200,
                                                    height: 200,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Center(
                                                    child: Text(
                                                        "Belum ada gambar"),
                                                  ),
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            model.updateProfil(context);
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 20, bottom: 20),
                            height: MediaQuery.of(context).size.height / 22,
                            width: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                                color: ColorLibrary.primary,
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 3),
                                      color: Colors.black26,
                                      blurRadius: 10)
                                ],
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                              child: Text(
                                "Selesai",
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.bold,
                                    color: ColorLibrary.shadow),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
