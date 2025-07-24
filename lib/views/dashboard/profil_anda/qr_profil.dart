import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paguyuban/others/colors.dart';
import 'package:paguyuban/provider/profil_view_model.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

class QrProfilpage extends StatelessWidget {
  const QrProfilpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfilViewModel>(
      builder: (context, model, _) => Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/backwhite.png"),
                fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Color.fromARGB(210, 255, 255, 255),
          appBar: AppBar(
            iconTheme: IconThemeData(color: ColorLibrary.shadow),
            backgroundColor: Colors.transparent,
            title: Text(
              'Qr WhatsApp',
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
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(20))),
            ),
          ),
          body: Screenshot(
            controller: model.screenshotController,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Scan kontak saya',
                  style: GoogleFonts.roboto(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: ColorLibrary.primary),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: ColorLibrary.primary),
                      color: ColorLibrary.shadow,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                      child: PrettyQrView.data(
                    data:
                        'https://wa.me/${model.formatPhoneNumber(model.profil!.phone)}',
                  )),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            margin: EdgeInsets.all(20),
            height: 60,
            child: InkWell(
              onTap: () {
                model.ceptureImage();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: ColorLibrary.primary,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Capture",
                    style: TextStyle(color: ColorLibrary.shadow),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
