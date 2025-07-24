import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paguyuban/others/colors.dart';
import 'package:paguyuban/provider/perpustakaan_view_model.dart';
import 'package:provider/provider.dart';

class PerpustakaanPage extends StatelessWidget {
  const PerpustakaanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PerpustakaanViewModel>(
      builder: (context, model, _) => Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/backwhite.png"),
                fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Color.fromARGB(210, 255, 255, 255),
          appBar: AppBar(
            iconTheme: IconThemeData(color: ColorLibrary.shadow),
            backgroundColor: Colors.transparent,
            title: Text(
              'Perpustakaan ',
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
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 1.18,
                        enlargeCenterPage: true,
                        viewportFraction: 0.5,
                      ),
                      items: model.books
                          .map(
                            (item) => Container(
                              width: 200,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(boxShadow: [
                                      BoxShadow(
                                          color: Colors.black38,
                                          offset: Offset(0, 2),
                                          blurRadius: 20)
                                    ]),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      // child: CachedNetworkImage(
                                      //   imageUrl: item.imageUrl,
                                      //   imageBuilder:
                                      //       (context, imageProvider) => Image(
                                      //     image: imageProvider,
                                      //     fit: BoxFit.cover,
                                      //     height: MediaQuery.of(context)
                                      //             .size
                                      //             .width *
                                      //         0.6,
                                      //     width: double.infinity,
                                      //   ),
                                      //   progressIndicatorBuilder: (context, url,
                                      //           downloadProgress) =>
                                      //       CircularProgressIndicator(
                                      //           value:
                                      //               downloadProgress.progress),
                                      //   errorWidget: (context, url, error) =>
                                      //       Icon(Icons.error),
                                      // ),
                                      child: Image.asset(
                                        item.imageUrl,
                                        fit: BoxFit.cover,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: AutoSizeText(
                                      item.name,
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: ColorLibrary.textColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList()),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.all(20),
                  child: Text(
                    "Perpustakaan",
                    maxLines: 2,
                    style: GoogleFonts.roboto(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: ColorLibrary.textColor),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.8,
                      crossAxisCount: 2,
                      crossAxisSpacing: 25,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: model.books.length,
                    itemBuilder: (c, i) {
                      return Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: ColorLibrary.primary,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black38,
                                  offset: Offset(0, 2),
                                  blurRadius: 20)
                            ]),
                        child: Column(
                          children: [
                            AutoSizeText(
                              model.books[i].name,
                              maxFontSize: 22,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                      color: Colors.black38,
                                      offset: Offset(0, 2),
                                      blurRadius: 20)
                                ]),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  // child: CachedNetworkImage(
                                  //   imageUrl: model.books[i].imageUrl,
                                  //   imageBuilder: (context, imageProvider) =>
                                  //       Image(
                                  //           image: imageProvider,
                                  //           fit: BoxFit.cover,
                                  //           height: MediaQuery.of(context)
                                  //                   .size
                                  //                   .height *
                                  //               0.17,
                                  //           width: MediaQuery.of(context)
                                  //                   .size
                                  //                   .width *
                                  //               0.26),
                                  //   progressIndicatorBuilder:
                                  //       (context, url, downloadProgress) =>
                                  //           CircularProgressIndicator(
                                  //               value: downloadProgress.progress),
                                  //   errorWidget: (context, url, error) =>
                                  //       Icon(Icons.error),
                                  // ),
                                  child: Image.asset(
                                    model.books[i].imageUrl,
                                    fit: BoxFit.cover,
                                    height: MediaQuery.of(context).size.height *
                                        0.17,
                                    width: MediaQuery.of(context).size.width *
                                        0.26,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
