import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paguyuban/media_query/size_config.dart';
import 'package:paguyuban/others/colors.dart';
import 'package:paguyuban/provider/berita_view_model.dart';
import 'package:paguyuban/routes/routes.dart';
import 'package:paguyuban/widget/loading.dart';
import 'package:provider/provider.dart';

class BeritaTerkiniPage extends StatelessWidget {
  const BeritaTerkiniPage({super.key});

  @override
  Widget build(BuildContext context) {
    Query.init(context);
    return Consumer<BeritaViewModel>(builder: (context, model, _) {
      if (model.isLoading) {
        return LoadingWidget();
      }

      return PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, result) {
          model.resetSearch();
          model.dataBerita();
        },
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/backwhite.png"),
                  fit: BoxFit.cover)),
          child: Scaffold(
              backgroundColor: Color.fromARGB(210, 255, 255, 255),
              appBar: AppBar(
                  iconTheme: IconThemeData(color: ColorLibrary.shadow),
                  backgroundColor: Colors.transparent,
                  title: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Berita Terkini ',
                      style: GoogleFonts.dancingScript(
                          color: ColorLibrary.shadow,
                          fontWeight: FontWeight.bold),
                    ),
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
                  bottom: PreferredSize(
                      preferredSize: Size.fromHeight(60),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextField(
                              style: TextStyle(
                                  color: ColorLibrary.shadow,
                                  fontWeight: FontWeight.bold,
                                  fontSize: MediaQuery.of(context).size.width /
                                      100 *
                                      4),
                              controller: model.search,
                              decoration: InputDecoration(
                                hintText: 'Search...',
                                hintStyle: TextStyle(
                                    color: ColorLibrary.shadow,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.search,
                                    color: ColorLibrary.shadow),
                              ),
                              onChanged: (value) {
                                model.dataBerita();
                              },
                            ),
                          ),
                        ],
                      ))),
              body: RefreshIndicator(
                onRefresh: () async {
                  await Provider.of<BeritaViewModel>(context, listen: false)
                      .dataBerita();
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (!model.isSearching)
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
                              items: model.berita
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
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  progressIndicatorBuilder: (context,
                                                          url,
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
                                                          Color.fromARGB(
                                                              0, 0, 0, 0)
                                                        ],
                                                        begin: Alignment
                                                            .bottomCenter,
                                                        end:
                                                            Alignment.topCenter,
                                                      ),
                                                    ),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      vertical: 10.0,
                                                    ),
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        color: const Color
                                                            .fromARGB(
                                                            20, 0, 0, 0),
                                                      ),
                                                      child: AutoSizeText(
                                                          item.judul!,
                                                          maxLines: 2,
                                                          style: GoogleFonts.roboto(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  ColorLibrary
                                                                      .shadow,
                                                              fontSize: 20)),
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
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: model.berita.length,
                          itemBuilder: (c, i) {
                            return InkWell(
                              onTap: () {
                                Provider.of<BeritaViewModel>(context,
                                        listen: false)
                                    .getDetailBerita(model.berita[i]);
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
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              6,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
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
                                              imageUrl:
                                                  model.berita[i].attachment!,
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
                                              model.berita[i].judul!,
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color:
                                                      ColorLibrary.textColor),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 4, bottom: 4),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 4, horizontal: 8),
                                              decoration: BoxDecoration(
                                                color: ColorLibrary.primary,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: AutoSizeText(
                                                  // modelBerita.berita[i].createdAt,
                                                  model.formattedNews(i),
                                                  style: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              100 *
                                                              0.7,
                                                      color:
                                                          ColorLibrary.shadow)),
                                            ),
                                            Text(
                                              model.berita[i].description!,
                                              maxLines: 3,
                                              textAlign: TextAlign.justify,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13,
                                                  color:
                                                      ColorLibrary.textColor),
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
                          }),
                      if (model.lastPage != null && model.lastPage! > 1)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: model.currentPage > 1
                                  ? model.forwardPage
                                  : null,
                              child: Text(
                                'Previous Page',
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    color: ColorLibrary.primary),
                              ),
                            ),
                            SizedBox(width: 20),
                            Text(
                                'Page ${model.currentPage} of ${model.lastPage}'),
                            SizedBox(width: 20),
                            ElevatedButton(
                              onPressed:
                                  model.currentPage < (model.lastPage ?? 1)
                                      ? model.nextPage
                                      : null,
                              child: Text(
                                'Next Page',
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    color: ColorLibrary.primary),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              )),
        ),
      );
    });
  }
}
