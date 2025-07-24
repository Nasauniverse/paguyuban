import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paguyuban/others/colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/backwhite.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(210, 255, 255, 255),
        body: Column(
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
                    fontWeight: FontWeight.w700, color: ColorLibrary.primary),
              ),
            )
          ],
        ),
      ),
    );
  }
}
