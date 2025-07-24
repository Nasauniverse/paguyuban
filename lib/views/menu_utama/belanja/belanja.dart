import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paguyuban/media_query/size_config.dart';
import 'package:paguyuban/others/colors.dart';
import 'package:paguyuban/routes/routes.dart';

class BelanjaPage extends StatelessWidget {
  const BelanjaPage({super.key});

  @override
  Widget build(BuildContext context) {
    Query.init(context);
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
            title: Text(
              'belanja',
              style: GoogleFonts.dancingScript(
                  color: ColorLibrary.shadow,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
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
          body: Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, asosiatifRoute);
                    },
                    child: Container(
                      height: Query.bagiHeight(4),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 3),
                                blurRadius: 10)
                          ]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "assets/buku_infografis/logoCoffee.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, asosiatifRoute);
                    },
                    child: Container(
                      height: Query.bagiHeight(4),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 3),
                                blurRadius: 10)
                          ]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "assets/buku_infografis/logoPasundanMart.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
