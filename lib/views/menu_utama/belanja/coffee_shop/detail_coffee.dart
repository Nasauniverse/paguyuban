import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paguyuban/media_query/size_config.dart';
import 'package:paguyuban/others/colors.dart';
import 'package:paguyuban/provider/coffee_view_model.dart';
import 'package:provider/provider.dart';

class DetailCoffeePage extends StatelessWidget {
  const DetailCoffeePage({super.key});

  @override
  Widget build(BuildContext context) {
    final coffee = Provider.of<CoffeeViewModel>(context).detailCoffee;
    Query.init(context);
    return Consumer<CoffeeViewModel>(
      builder: (context, model, _) => Scaffold(
          body: Stack(
        children: [
          // Gambar di bagian atas
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: Query.kaliHeight(0.72),
            child: Container(
              child: ClipRRect(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
                child: Image.asset(
                  coffee!.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Konten scrollable di bawah gambar
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.62),
              height: MediaQuery.of(context).size.height * 0.52,
              padding: EdgeInsets.only(top: 10, left: 20, right: 20),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    ColorLibrary.primarySuperDark,
                    ColorLibrary.primaryLow,
                    ColorLibrary.primary,
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 3,
                      width: 50,
                      decoration: BoxDecoration(
                          color: ColorLibrary.shadow,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  //nama produk
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(coffee.name,
                                style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: ColorLibrary.shadow,
                                )),
                            Text(coffee.type,
                                style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  color: ColorLibrary.shadow,
                                )),
                            //ratting
                          ],
                        ),
                        Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.star_outlined,
                                size: 20,
                                color: ColorLibrary.thirdDark,
                              ),
                              AutoSizeText(
                                maxFontSize: 14,
                                coffee.rate.toString(),
                                style: TextStyle(
                                    color: ColorLibrary.shadow,
                                    fontWeight: FontWeight.bold),
                              ),
                              AutoSizeText(
                                maxFontSize: 14,
                                "(${coffee.review})",
                                style: TextStyle(
                                    color: ColorLibrary.shadow,
                                    fontWeight: FontWeight.w200),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  //deskripsi
                  AutoSizeText(
                    "Deskripsi",
                    style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ColorLibrary.shadow),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    coffee.description,
                    style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: ColorLibrary.shadow),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  //deskripsi
                  AutoSizeText(
                    "Size",
                    style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ColorLibrary.shadow),
                  ),
                  SizedBox(
                    height: 10 ,
                  ),
                  //size
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: model.sizeCoffee(),
                  ),
                  //prixe dan button buy
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          AutoSizeText(
                            "Harga",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: ColorLibrary.shadow),
                          ),
                          AutoSizeText(
                            coffee.price.toString(),
                            style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: ColorLibrary.shadow),
                          )
                        ],
                      ),
                      Container(
                        height: 60,
                        width: 150,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2, color: ColorLibrary.shadow),
                            borderRadius: BorderRadius.circular(20),
                            color: ColorLibrary.thirdDark),
                        child: Center(
                          child: AutoSizeText(
                            " Beli",
                            textAlign: TextAlign.center,
                            maxFontSize: 14,
                            style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: ColorLibrary.shadow),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          //icon untuk back
          Positioned(
            top: 30,
            left: 10,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
        ],
      )),
    );
  }
}
