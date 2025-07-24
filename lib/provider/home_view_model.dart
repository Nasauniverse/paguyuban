import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paguyuban/others/colors.dart';
import 'package:paguyuban/provider/akun_view_model.dart';
import 'package:paguyuban/provider/profil_view_model.dart';
import 'package:paguyuban/routes/routes.dart';
import 'package:provider/provider.dart';

class HomeViewModel extends ChangeNotifier {
  final PageController pageController = PageController(initialPage: 0);
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    pageController.jumpToPage(index);
    notifyListeners();
  }

  homePageView(int type) {}

//drawer
  Widget drawer(context) {
    final profil = Provider.of<ProfilViewModel>(context, listen: false);
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: ColorLibrary.primary),
      child: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                  top: 60, bottom: 20, left: 20, right: 20),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                ColorLibrary.primarySuperDark,
                ColorLibrary.primaryLow,
                ColorLibrary.primary
              ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
              child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 70,
                        child: CircleAvatar(
                          radius: 35,
                          backgroundColor: ColorLibrary.primary,
                          child: CircleAvatar(
                            foregroundColor: Colors.white,
                            radius: 34,
                            backgroundColor: Colors.white,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(200),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        profil.profil!.name!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.roboto(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 1.0,
                      ),
                      Text(
                        profil.profil!.phone!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.roboto(
                            fontSize: 14, color: Colors.white),
                      )
                    ],
                  )),
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: ColorLibrary.primary,
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, qrProfilRoute);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, top: 20, bottom: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: ColorLibrary.primary, width: 2)),
                      child: Row(
                        children: [
                          Icon(
                            Icons.message,
                            size: 18,
                            color: ColorLibrary.primary,
                          ),
                          SizedBox(width: 10),
                          Text('Qr Whatsapp',
                              style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  color: ColorLibrary.primary,
                                  fontWeight: FontWeight.w700)),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios_sharp,
                            size: 18,
                            color: ColorLibrary.primary,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border:
                            Border.all(color: ColorLibrary.primary, width: 2)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 18,
                          color: ColorLibrary.primary,
                        ),
                        SizedBox(width: 10),
                        Text(profil.profil!.nik!,
                            style: GoogleFonts.roboto(
                                fontSize: 14,
                                color: ColorLibrary.primary,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border:
                            Border.all(color: ColorLibrary.primary, width: 2)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.home,
                          color: ColorLibrary.primary,
                          size: 18,
                        ),
                        SizedBox(width: 10),
                        Text(profil.profil!.address!,
                            style: GoogleFonts.roboto(
                                fontSize: 14,
                                color: ColorLibrary.primary,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border:
                            Border.all(color: ColorLibrary.primary, width: 2)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.cake,
                          color: ColorLibrary.primary,
                          size: 18,
                        ),
                        SizedBox(width: 10),
                        Text(profil.profil!.birthdate.toString(),
                            style: GoogleFonts.roboto(
                                fontSize: 14,
                                color: ColorLibrary.primary,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border:
                            Border.all(color: ColorLibrary.primary, width: 2)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.school,
                          color: ColorLibrary.primary,
                          size: 18,
                        ),
                        SizedBox(width: 10),
                        Text(profil.profil!.education.toString(),
                            style: GoogleFonts.roboto(
                                fontSize: 14,
                                color: ColorLibrary.primary,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border:
                            Border.all(color: ColorLibrary.primary, width: 2)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.work,
                          color: ColorLibrary.primary,
                          size: 18,
                        ),
                        SizedBox(width: 10),
                        Text(profil.profil!.occupation.toString(),
                            style: GoogleFonts.roboto(
                                fontSize: 14,
                                color: ColorLibrary.primary,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Provider.of<AkunViewModel>(context, listen: false)
                          .alertLogout(context);
                      // Navigator.pushReplacementNamed(context, loginRoute);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, top: 10, bottom: 10),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 3),
                                color: Colors.black26,
                                blurRadius: 10)
                          ],
                          color: ColorLibrary.primary,
                          borderRadius: BorderRadius.circular(10)),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 19,
                      child: Center(
                          child: Text(
                        "Logout",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            color: ColorLibrary.shadow),
                      )),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Text("Ver 1.0.1.0",
                  style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w400)),
            ),
          ],
        ),
      ),
    );
  }
}
