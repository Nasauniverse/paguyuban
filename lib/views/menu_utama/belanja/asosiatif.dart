import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paguyuban/others/colors.dart';
import 'package:paguyuban/routes/routes.dart';

class AsosiatifPage extends StatelessWidget {
  const AsosiatifPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/backwhite.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
          backgroundColor: const Color.fromARGB(210, 255, 255, 255),
          appBar: AppBar(
            iconTheme: IconThemeData(color: ColorLibrary.shadow),
            backgroundColor: Colors.transparent,
            title: Text(
              "Asosiatif",
              style: GoogleFonts.dancingScript(
                  color: ColorLibrary.shadow,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    ColorLibrary.primarySuperDark,
                    ColorLibrary.primaryLow,
                    ColorLibrary.primary
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(29)),
            ),
          ),
          body: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(0, 0, 0, 0),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // mengubah posisi bayangan
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisSize: MainAxisSize
                        .min, // Biarkan kolom menentukan tinggi minimum
                    children: [
                      InkWell(
                        child: Card(
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          elevation: 3,
                          child: Container(
                            height: 70,
                            decoration: BoxDecoration(),
                            child: const Image(
                              image: AssetImage("assets/logo/logoUnpas.png"),
                              height: 30,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        height: 30,
                        child: AutoSizeText(
                          "Fisip",
                          maxLines: 2,
                          maxFontSize: 14,
                          minFontSize: 11,
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            color: ColorLibrary.textColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisSize: MainAxisSize
                        .min, // Biarkan kolom menentukan tinggi minimum
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, marketPlaceRoute);
                        },
                        child: Card(
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          elevation: 3,
                          child: Container(
                            height: 70,
                            decoration: BoxDecoration(),
                            child: const Image(
                              image: AssetImage("assets/logo/logoUnpas.png"),
                              height: 30,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        height: 30,
                        child: AutoSizeText(
                          "Unpas",
                          maxLines: 2,
                          maxFontSize: 14,
                          minFontSize: 11,
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            color: ColorLibrary.textColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, coffeeShopRoute);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize
                          .min, // Biarkan kolom menentukan tinggi minimum
                      children: [
                        InkWell(
                          child: Card(
                            color: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            elevation: 3,
                            child: Container(
                              height: 70,
                              decoration: BoxDecoration(),
                              child: const Image(
                                image: AssetImage(
                                    "assets/logo/logoSmkPasundan3.png"),
                                height: 30,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        SizedBox(
                          height: 30,
                          child: AutoSizeText(
                            "Smkn pas 3",
                            maxLines: 2,
                            maxFontSize: 14,
                            minFontSize: 11,
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              color: ColorLibrary.textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
