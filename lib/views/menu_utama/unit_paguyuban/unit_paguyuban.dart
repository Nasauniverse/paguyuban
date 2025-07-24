import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paguyuban/others/colors.dart';
import 'package:paguyuban/provider/jenis_usaha_view_model.dart';
import 'package:paguyuban/provider/unit_paguyuban_view_model.dart';
import 'package:paguyuban/widget/loading.dart';
import 'package:provider/provider.dart';

class UnitPaguyubanPage extends StatelessWidget {
  const UnitPaguyubanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<UnitPaguyubanViewModel, JenisUsahaViewModel>(builder: (context, model, modelJenisUsaha,_) {
      if (model.isLoading) {
        return LoadingWidget();
      }
      return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/backwhite.png"),
                fit: BoxFit.cover)),
        child: Scaffold(
            backgroundColor: const Color.fromARGB(210, 255, 255, 255),
            appBar: AppBar(
              iconTheme: IconThemeData(color: ColorLibrary.shadow),
              backgroundColor: Colors.transparent,
              title: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Unit Paguyuban ',
                  style: GoogleFonts.dancingScript(
                      color: ColorLibrary.shadow,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
              ),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ColorLibrary.primarySuperDark,
                        ColorLibrary.primaryLow,
                        ColorLibrary.primary
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(20))),
              ),
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                Provider.of<UnitPaguyubanViewModel>(context, listen: false)
                    .dataUnit();
              },
              child: ListView.builder(
                  itemCount: model.unit.length,
                  itemBuilder: (context, index) => Container(
                        decoration: BoxDecoration(
                            color: ColorLibrary.shadow,
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 3),
                                  blurRadius: 10,
                                  color: Colors.black38),
                            ],
                            borderRadius: BorderRadius.circular(20)),
                        margin: EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("Nama Tempat :",
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold,
                                          color: ColorLibrary.textColor,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              100 *
                                              4)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      model.unit[index].namaTempat!,
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold,
                                          color: ColorLibrary.textColor,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              100 *
                                              4),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text("Alamat :",
                                      style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w700,
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                100 *
                                                4,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      model.unit[index].alamat!,
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold,
                                          color: ColorLibrary.textColor,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              100 *
                                              4),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                decoration: BoxDecoration(
                                  color: ColorLibrary.primary,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(modelJenisUsaha.getNameJenisUsaha(model.unit[index].jenisUsaha),
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                100 *
                                                4,
                                        color: ColorLibrary.shadow)),
                              ),
                            ],
                          ),
                        ),
                      )),
            )),
      );
    });
  }
}
