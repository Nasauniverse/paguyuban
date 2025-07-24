import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paguyuban/others/colors.dart';
import 'package:paguyuban/provider/akun_view_model.dart';
import 'package:paguyuban/provider/home_view_model.dart';
import 'package:paguyuban/provider/profil_view_model.dart';
import 'package:paguyuban/routes/routes.dart';
import 'package:paguyuban/views/dashboard/home/home.dart';
import 'package:paguyuban/views/dashboard/profil_anda/profil.dart';
import 'package:paguyuban/views/menu_utama/infografis/infografis.dart';
import 'package:paguyuban/views/menu_utama/kepengurusan/kepengurusan.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ProfilViewModel>(context, listen: false).dataProfil();
    return Consumer3<HomeViewModel, AkunViewModel, ProfilViewModel>(
      builder: (context, homeModel, model1, profil, _) => Container(
        child: Scaffold(
          appBar: (homeModel.currentIndex == 1 || homeModel.currentIndex == 2)
              ? null
              : AppBar(
                  iconTheme: IconThemeData(
                      color: homeModel.currentIndex == 3
                          ? ColorLibrary.shadow
                          : ColorLibrary.primary),
                  title: Text(
                    "Wilujeung Sumping",
                    style: GoogleFonts.dancingScript(
                        color: homeModel.currentIndex == 3
                            ? ColorLibrary.shadow
                            : ColorLibrary.primary,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                  // actions: [
                  //   Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 15),
                  //     child: Row(
                  //       children: [
                  //         InkWell(
                  //           onTap: () {},
                  //           child: Icon(Icons.info,
                  //               color: homeModel.currentIndex == 3
                  //                   ? ColorLibrary.shadow
                  //                   : ColorLibrary.primary,
                  //               size: 30),
                  //         ),
                  //         const SizedBox(width: 15),
                  //         InkWell(
                  //           onTap: () {},
                  //           child: Icon(Icons.notifications,
                  //               color: homeModel.currentIndex == 3
                  //                   ? ColorLibrary.shadow
                  //                   : ColorLibrary.primary,
                  //               size: 30),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ],
                  backgroundColor: Colors.transparent,
                  flexibleSpace: homeModel.currentIndex == 3
                      ? Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                ColorLibrary.primarySuperDark,
                                ColorLibrary.primaryLow,
                                ColorLibrary.primary,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        )
                      : null,
                ),
          drawer: Drawer(
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
                                  child: CachedNetworkImage(
                                    imageUrl: profil.profil!.photo,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            profil.profil?.name ?? "Nama kosong",
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
                            profil.profil?.phone ?? "No handphone kosong",
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
                            border: Border.all(
                                color: ColorLibrary.primary, width: 2)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.person,
                              size: 18,
                              color: ColorLibrary.primary,
                            ),
                            SizedBox(width: 10),
                            Text(profil.profil?.nik ?? "NIK belum di isi",
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: ColorLibrary.primary,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                      profil.profil!.address != null
                          ? Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(
                                  left: 15, right: 15, top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: ColorLibrary.primary, width: 2)),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.home,
                                    color: ColorLibrary.primary,
                                    size: 18,
                                  ),
                                  SizedBox(width: 10),
                                  Text(profil.profil?.address ?? "Alamat",
                                      style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          color: ColorLibrary.primary,
                                          fontWeight: FontWeight.w700)),
                                ],
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(
                                  left: 15, right: 15, top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: ColorLibrary.primary, width: 2)),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.home,
                                    color: ColorLibrary.primary,
                                    size: 18,
                                  ),
                                  SizedBox(width: 10),
                                  Text("Alamat",
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
                            border: Border.all(
                                color: ColorLibrary.primary, width: 2)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.cake,
                              color: ColorLibrary.primary,
                              size: 18,
                            ),
                            SizedBox(width: 10),
                            Text(profil.formattedBirthdate,
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
                            border: Border.all(
                                color: ColorLibrary.primary, width: 2)),
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
                            border: Border.all(
                                color: ColorLibrary.primary, width: 2)),
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
          body: PageView(
            controller: homeModel.pageController,
            onPageChanged: (index) {
              homeModel.setIndex(index);
            },
            children: [
              HomePage(), // Dashboard
              InfografisPage(), // infografis
              KepengurusanPage(), // kepengurusan
              ProfilPage() // Profil Anda
            ],
          ),
          bottomNavigationBar: Container(
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
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: SalomonBottomBar(
                backgroundColor: Colors.transparent,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                selectedItemColor: ColorLibrary.third,
                unselectedItemColor: ColorLibrary.shadow,
                currentIndex: homeModel.currentIndex,
                onTap: (index) {
                  homeModel.setIndex(index);
                },
                items: [
                  SalomonBottomBarItem(
                    icon: Icon(
                      Icons.home_outlined,
                      size: MediaQuery.of(context).size.width / 100 * 7,
                    ),
                    title: Text(
                      "Dashboard",
                      style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.width / 100 * 4),
                    ),
                  ),
                  SalomonBottomBarItem(
                    icon: Icon(Icons.history_edu,
                        size: MediaQuery.of(context).size.width / 100 * 7),
                    title: Text(
                      "Infografis",
                      style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.width / 100 * 4),
                    ),
                  ),
                  SalomonBottomBarItem(
                    icon: Icon(Icons.account_balance_wallet_outlined,
                        size: MediaQuery.of(context).size.width / 100 * 7),
                    title: Text("Kepengurusan"),
                  ),
                  SalomonBottomBarItem(
                    icon: Icon(Icons.person_2_outlined,
                        size: MediaQuery.of(context).size.width / 100 * 7),
                    title: Text("Profil"),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
