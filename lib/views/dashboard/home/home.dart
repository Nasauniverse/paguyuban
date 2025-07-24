import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paguyuban/others/colors.dart';
import 'package:paguyuban/provider/akun_view_model.dart';
import 'package:paguyuban/provider/berita_view_model.dart';
import 'package:paguyuban/provider/generate_qr_view_model.dart';
import 'package:paguyuban/provider/home_view_model.dart';
import 'package:paguyuban/provider/infografis_view_model.dart';
import 'package:paguyuban/provider/kepengurusan_view_model.dart';
import 'package:paguyuban/provider/maps_view_model.dart';
import 'package:paguyuban/provider/profil_view_model.dart';
import 'package:paguyuban/provider/unit_paguyuban_view_model.dart';
import 'package:paguyuban/routes/routes.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Consumer4<HomeViewModel, AkunViewModel, BeritaViewModel,
        ProfilViewModel>(
      builder: (context, model, modelAkun, modelBerita, modelProfil, _) =>
          Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/backwhite.png"),
                fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: const Color.fromARGB(210, 255, 255, 255),
          body: RefreshIndicator(
            onRefresh: () async {
              await Provider.of<AkunViewModel>(context, listen: false)
                  .fulldata(context);
            },
            child: ListView(
              children: [
                const SizedBox(height: 5),
                const SizedBox(height: 15),
                FadeInDown(
                    child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(50, 10, 50, 0),
                      height: MediaQuery.of(context).size.height / 2,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 3),
                              color: Colors.black26,
                              blurRadius: 10,
                            )
                          ],
                          image: DecorationImage(
                              image: AssetImage("assets/images/card_bg.jpg"),
                              fit: BoxFit.contain)),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height / 5,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              height: MediaQuery.of(context).size.height / 6,
                              width: MediaQuery.of(context).size.width / 3,
                              child: CachedNetworkImage(
                                imageUrl: modelProfil.profil!.photo,
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
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                          //nama
                          Text(
                            modelProfil.profil!.name!,
                            style: GoogleFonts.openSans(
                                color: ColorLibrary.shadow,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.020,
                          ),
                          Text(
                            modelProfil.profil?.jabatan ?? "ANGGOTA",
                            style: GoogleFonts.openSans(
                                color: ColorLibrary.shadow,
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                    ),
                  ],
                )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    FadeInLeft(
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Text("Menu Utama",
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: ColorLibrary.textColor))),
                    ),
                    Container(
                        width: double.infinity,
                        height: 0.5,
                        color: Colors.black12),
                    const SizedBox(height: 15),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(30, 0, 0, 0),
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: FadeInLeft(
                                    animate: true,
                                    child: Column(
                                      children: [
                                        InkWell(
                                          borderRadius:
                                              BorderRadius.circular(70),
                                          onTap: () {
                                            Provider.of<BeritaViewModel>(
                                                    context,
                                                    listen: false)
                                                .dataBerita();
                                            Navigator.pushNamed(
                                                context, beritaTerkiniRoute);
                                          },
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            color: ColorLibrary.third,
                                            elevation: 3,
                                            child: Container(
                                              height: 70,
                                              padding: const EdgeInsets.all(15),
                                              child: const Image(
                                                image: AssetImage(
                                                    "assets/images/berita.png"),
                                                height: 30,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          height: 30,
                                          child: AutoSizeText(
                                            "Berita Terkini",
                                            maxLines: 2,
                                            maxFontSize: 14,
                                            minFontSize: 11,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.bold,
                                                color: ColorLibrary.textColor),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: FadeInDown(
                                    from: 250,
                                    animate: true,
                                    child: Column(
                                      children: [
                                        InkWell(
                                          borderRadius:
                                              BorderRadius.circular(70),
                                          onTap: () {
                                            Provider.of<MapsViewModel>(context,
                                                    listen: false)
                                                .dataMember();
                                            Navigator.pushNamed(
                                                context, mapsRoute);
                                          },
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                            color: ColorLibrary.third,
                                            elevation: 3,
                                            child: Container(
                                              height: 70,
                                              padding: const EdgeInsets.all(15),
                                              child: const Image(
                                                image: AssetImage(
                                                    "assets/images/fasilitas.png"),
                                                height: 30,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          height: 30,
                                          child: AutoSizeText(
                                            "Mitra Paguyuban",
                                            maxLines: 2,
                                            maxFontSize: 14,
                                            minFontSize: 11,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.bold,
                                                color: ColorLibrary.textColor),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: FadeInRight(
                                    child: Column(
                                      children: [
                                        InkWell(
                                          borderRadius:
                                              BorderRadius.circular(70),
                                          onTap: () {
                                            Provider.of<InfografisViewModel>(
                                                    context,
                                                    listen: false)
                                                .dataInfografis();
                                            Navigator.pushNamed(
                                                context, infografisRoute);
                                          },
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                            color: ColorLibrary.third,
                                            elevation: 3,
                                            child: Container(
                                              height: 70,
                                              padding: EdgeInsets.all(15),
                                              child: Image(
                                                image: AssetImage(
                                                    "assets/images/infografis.png"),
                                                height: 30,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          height: 30,
                                          child: AutoSizeText(
                                            "Infografis Singkat",
                                            maxLines: 2,
                                            maxFontSize: 14,
                                            minFontSize: 11,
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.bold,
                                                color: ColorLibrary.textColor),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ]),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: FadeInLeft(
                                  animate: true,
                                  child: Column(
                                    children: [
                                      InkWell(
                                        borderRadius: BorderRadius.circular(70),
                                        onTap: () {
                                          // Provider.of<MapsViewModel>(context,
                                          //         listen: false)
                                          //     .dataMember();
                                          // Navigator.pushNamed(
                                          //     context, generateQrRoute);
                                          // Provider.of<AkunViewModel>(context,
                                          //         listen: false)
                                          //     .cameraUser();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              backgroundColor:
                                                  ColorLibrary.primary,
                                              content: Text(
                                                'Belum tersedia saat ini. Kami akan segera meluncurkannya!',
                                                style: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.bold,
                                                    color: ColorLibrary.shadow),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                100), // Membuat Card berbentuk bulat
                                          ),
                                          color: ColorLibrary.third,
                                          elevation: 3,
                                          child: Stack(
                                            children: [
                                              // Container untuk gambar
                                              Container(
                                                height: 70,
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: const Image(
                                                  image: AssetImage(
                                                      "assets/images/onlineshop.png"),
                                                  height: 30,
                                                ),
                                              ),
                                              Positioned.fill(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey
                                                        .withOpacity(0.4),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                ),
                                              ),
                                              Positioned.fill(
                                                child: Center(
                                                  child: Text(
                                                    'Coming Soon',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                        height: 30,
                                        child: AutoSizeText(
                                          "Belanja",
                                          maxLines: 2,
                                          maxFontSize: 14,
                                          minFontSize: 11,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.bold,
                                              color: ColorLibrary.textColor),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              // Expanded(
                              //   flex: 1,
                              //   child: FadeInLeftBig(
                              //     from: 250,
                              //     animate: true,
                              //     child: Column(
                              //       children: [
                              //         InkWell(
                              //           borderRadius: BorderRadius.circular(70),
                              //           onTap: () {
                              //             Navigator.pushNamed(
                              //                 context, perpustakaanRoute);
                              //           },
                              //           child: Card(
                              //             shape: RoundedRectangleBorder(
                              //                 borderRadius:
                              //                     BorderRadius.circular(100)),
                              //             color: ColorLibrary.third,
                              //             elevation: 3,
                              //             child: Container(
                              //               height: 70,
                              //               padding: EdgeInsets.all(15),
                              //               child: Image(
                              //                 image: AssetImage(
                              //                     "assets/images/perpus.png"),
                              //                 height: 30,
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //         const SizedBox(
                              //           height: 5,
                              //         ),
                              //         SizedBox(
                              //           height: 30,
                              //           child: AutoSizeText(
                              //             "Perpustakaan",
                              //             maxFontSize: 14,
                              //             minFontSize: 11,
                              //             maxLines: 2,
                              //             textAlign: TextAlign.center,
                              //             style: GoogleFonts.roboto(
                              //                 fontWeight: FontWeight.bold,
                              //                 color: ColorLibrary.textColor),
                              //           ),
                              //         )
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              Expanded(
                                flex: 1,
                                child: FadeInDown(
                                  from: 250,
                                  child: Column(
                                    children: [
                                      InkWell(
                                        borderRadius: BorderRadius.circular(70),
                                        onTap: () {
                                          Provider.of<KepengurusanViewModel>(
                                                  context,
                                                  listen: false)
                                              .dataKepengurusan();
                                          Navigator.pushNamed(
                                              context, kepengurusanRoute);
                                        },
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          color: ColorLibrary.third,
                                          elevation: 3,
                                          child: Container(
                                            height: 70,
                                            padding: EdgeInsets.all(15),
                                            child: Image(
                                              image: AssetImage(
                                                  "assets/images/hirarki.png"),
                                              height: 30,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                        height: 30,
                                        child: AutoSizeText(
                                          "Kepengurusan Organisasi",
                                          maxLines: 2,
                                          maxFontSize: 14,
                                          minFontSize: 11,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.bold,
                                              color: ColorLibrary.textColor),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: FadeInRight(
                                  from: 250,
                                  child: Column(
                                    children: [
                                      InkWell(
                                        borderRadius: BorderRadius.circular(70),
                                        onTap: () {
                                          Provider.of<UnitPaguyubanViewModel>(
                                                  context,
                                                  listen: false)
                                              .dataUnit();
                                          Navigator.pushNamed(
                                              context, unitPaguyubanRoute);
                                        },
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          color: ColorLibrary.third,
                                          elevation: 3,
                                          child: Container(
                                            height: 70,
                                            padding: EdgeInsets.all(15),
                                            child: Image(
                                              image: AssetImage(
                                                  "assets/images/sejarah.png"),
                                              height: 30,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                        height: 30,
                                        child: AutoSizeText(
                                          "Unit Paguyuban",
                                          maxLines: 2,
                                          maxFontSize: 14,
                                          minFontSize: 11,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.bold,
                                              color: ColorLibrary.textColor),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 5),
                    Container(
                        width: double.infinity,
                        height: 0.5,
                        color: Colors.black12),
                    const SizedBox(height: 20),
                    FadeInLeft(
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 0),
                          child: Text("Berita Terkini",
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: ColorLibrary.textColor))),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // posisi bayangan
                          ),
                        ],
                      ),
                      child: CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: true,
                            aspectRatio: 2.0,
                            enlargeCenterPage: true,
                            viewportFraction: 1,
                          ),
                          items: modelBerita.berita
                              .map(
                                (item) => InkWell(
                                  onTap: () {
                                    Provider.of<BeritaViewModel>(context,
                                            listen: false)
                                        .getDetailBerita(item);
                                    Navigator.pushNamed(
                                        context, detailberitaRoute);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(5.0),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        child: Stack(
                                          children: <Widget>[
                                            CachedNetworkImage(
                                              imageUrl: item.attachment!,
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                            Positioned(
                                              bottom: 0.0,
                                              left: 0.0,
                                              right: 0.0,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color.fromARGB(
                                                          200, 0, 0, 0),
                                                      Color.fromARGB(0, 0, 0, 0)
                                                    ],
                                                    begin:
                                                        Alignment.bottomCenter,
                                                    end: Alignment.topCenter,
                                                  ),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 10.0,
                                                ),
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        20, 0, 0, 0),
                                                  ),
                                                  child: AutoSizeText(
                                                    item.judul!,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                ),
                              )
                              .toList()),
                    ),
                    const SizedBox(height: 5),
                    Container(
                        width: double.infinity,
                        height: 0.5,
                        color: Colors.black12),
                    FadeInUp(
                      child: ListView.builder(
                        itemCount: modelBerita.berita.length < 3
                            ? modelBerita.berita.length
                            : 3,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (c, i) {
                          return InkWell(
                            onTap: () {
                              Provider.of<BeritaViewModel>(context,
                                      listen: false)
                                  .getDetailBerita(modelBerita.berita[i]);
                              Navigator.pushNamed(context, detailberitaRoute);
                            },
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                6,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                ColorLibrary.primarySuperDark,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: CachedNetworkImage(
                                            imageUrl: modelBerita
                                                .berita[i].attachment!,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                CircularProgressIndicator(
                                                    value: downloadProgress
                                                        .progress),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            modelBerita.berita[i].judul!,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: ColorLibrary.textColor),
                                          ),
                                          const SizedBox(height: 3),
                                          AutoSizeText(
                                            // modelBerita.berita[i].createdAt,
                                            "fadfadf",
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 11,
                                                color: ColorLibrary.textColor),
                                          ),
                                          Text(
                                            modelBerita.berita[i].description!,
                                            maxLines: 3,
                                            textAlign: TextAlign.justify,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13,
                                                color: ColorLibrary.textColor),
                                          ),
                                        ],
                                      ))
                                    ],
                                  ),
                                ),
                                Container(
                                    width: double.infinity,
                                    height: 5,
                                    color: Colors.black12),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      width: double.infinity,
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
                          borderRadius: BorderRadius.circular(10)),
                      child: ElevatedButton.icon(
                          onPressed: () {
                            Provider.of<BeritaViewModel>(context, listen: false)
                                .dataBerita();
                            Navigator.pushNamed(context, beritaTerkiniRoute);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: ColorLibrary.shadow,
                          ),
                          label: Text(
                            "Selengkapnya",
                            style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700)),
                          )),
                    ),
                    // const SizedBox(height: 70),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
