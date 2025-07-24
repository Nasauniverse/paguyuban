// import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paguyuban/media_query/size_config.dart';
import 'package:paguyuban/others/colors.dart';
import 'package:paguyuban/provider/coffee_view_model.dart';
import 'package:paguyuban/routes/routes.dart';
import 'package:provider/provider.dart';

class CoffeeShopPage extends StatelessWidget {
  const CoffeeShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CoffeeViewModel>(
      builder: (context, model, _) => DefaultTabController(
        length: 4,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: AutoSizeText(
                'Coffee Shop',
                style: GoogleFonts.dancingScript(
                    color: ColorLibrary.shadow,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              iconTheme: IconThemeData(color: ColorLibrary.shadow),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      ColorLibrary.primarySuperDark,
                      ColorLibrary.primaryLow,
                      ColorLibrary.primary
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
              ),
              actions: [
                Container(
                    margin: EdgeInsets.only(right: 20),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, keranjangCoffeeRoute);
                        },
                        icon: Icon(Icons.shopping_cart)))
              ],
              bottom: PreferredSize(
                preferredSize:
                    Size.fromHeight(MediaQuery.of(context).size.height / 10),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      width: MediaQuery.of(context).size.width,
                      // height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20)),
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Find your coffee....",
                            hintStyle: TextStyle(
                                fontSize: 16,
                                color: ColorLibrary.primarySuperDark,
                                fontWeight: FontWeight.bold),
                            prefixIcon: Icon(
                              Icons.search,
                              size: 20,
                              color: ColorLibrary.shadow,
                            )),
                      ),
                    ),
                    TabBar(
                      controller: model.tabController,
                      labelColor: ColorLibrary.shadow,
                      unselectedLabelColor: ColorLibrary.primarySuperDark,
                      isScrollable: true,
                      indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(
                          width: 3,
                          color: ColorLibrary.shadow,
                        ),
                      ),
                      labelStyle:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      labelPadding: EdgeInsets.symmetric(horizontal: 20),
                      tabs: [
                        Tab(
                          text: "Hot Coffee",
                        ),
                        Tab(
                          text: "Hot Coffee",
                        ),
                        Tab(
                          text: "Hot Coffee",
                        ),
                        Tab(
                          text: "Hot Coffee",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            body: Stack(
              children: [
                // Align(
                //   alignment: Alignment.topCenter,
                //   child: Container(
                //     decoration: BoxDecoration(
                //       gradient: LinearGradient(colors: [
                //         ColorLibrary.primarySuperDark,
                //         ColorLibrary.primaryLow,
                //         ColorLibrary.primary
                //       ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                //       borderRadius: BorderRadius.only(
                //           bottomLeft: Radius.circular(20),
                //           bottomRight: Radius.circular(20)),
                //     ),
                //     height: MediaQuery.of(context).size.height / 4,
                //   ),
                // ),
                Column(
                  children: [
                    // Container(
                    //   margin: EdgeInsets.only(top: 30),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       IconButton(
                    //         onPressed: () {
                    //           Navigator.pop(context);
                    //         },
                    //         icon: Icon(
                    //           Icons.arrow_back,
                    //           color: ColorLibrary.shadow,
                    //         ),
                    //       ),
                    //       IconButton(
                    //         onPressed: () {

                    // },

                    //       )
                    //     ],
                    //   ),
                    // ),

                    Expanded(
                        child: TabBarView(children: [
                      DataCoffeePage(),
                      DataCoffeePage(),
                      DataCoffeePage(),
                      DataCoffeePage(),
                    ])),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}

class DataCoffeePage extends StatelessWidget {
  const DataCoffeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CoffeeViewModel>(
      builder: (context, model, _) => GridView.builder(
          // shrinkWrap: true,
          // physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            childAspectRatio: 0.8,
            mainAxisSpacing: 5,
          ),  
          itemCount: model.coffees.length,
          itemBuilder: (c, i) {
            return InkWell(
              onTap: () {
                Provider.of<CoffeeViewModel>(context, listen: false)
                    .getDetailCoffee(model.coffees[i]);
                Navigator.pushNamed(
                    context, detailCoffeeRoute); // Menavigasi ke halaman detail
              },
              child: Container(
                margin: EdgeInsets.all(5),
                child: Stack(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          //kotak background
                          Expanded(
                            child: Container(
                              color: Colors.transparent,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(1, 3),
                                        blurRadius: 10)
                                  ]),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                        // Ini adalah area kosong yang akan mendorong teks ke bawah
                                        ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 10,
                                      top: 50,
                                      right: 10,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AutoSizeText(
                                              maxFontSize: 14,
                                              // minFontSize: 1,
                                              model.coffees[i].name,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            AutoSizeText(
                                              model.coffees[i].type,
                                              maxFontSize: 14,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  color:
                                                      ColorLibrary.textColor),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: AutoSizeText(
                                                maxFontSize: 20,
                                                maxLines: 1,
                                                "Rp. ${model.coffees[i].price.toString()}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 10),
                                              alignment: Alignment.bottomRight,
                                              child: Icon(
                                                Icons.add_box_rounded,
                                                size: 30,
                                                color: ColorLibrary.primary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                        top: 0,
                        bottom: 20,
                        right: 10,
                        left: 10,
                        child: Center(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(5, 8),
                                  blurRadius: 10)
                            ], borderRadius: BorderRadius.circular(20)),
                            margin: EdgeInsets.only(bottom: Query.bagiWidth(5)),
                            // height: 150,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                model.coffees[i].imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )),
                    Positioned(
                      top: 0,
                      right: 10,
                      child: Container(
                        height: 40,
                        width: 50,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.black26, Colors.black54],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(12)),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Icon(
                                Icons.star_outlined,
                                size: 20,
                                color: ColorLibrary.thirdDark,
                              ),
                            ),
                            Expanded(
                              child: AutoSizeText(
                                maxFontSize: 14,
                                model.coffees[i].rate.toString(),
                                style: TextStyle(color: ColorLibrary.shadow),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
