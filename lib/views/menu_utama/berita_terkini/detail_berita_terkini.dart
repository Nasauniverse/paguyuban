import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paguyuban/others/colors.dart';
import 'package:paguyuban/provider/berita_view_model.dart';
import 'package:provider/provider.dart';

class DetailBeritaTerkiniPage extends StatelessWidget {
  const DetailBeritaTerkiniPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<BeritaViewModel>(
        builder: (context, model, _) => Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: ColorLibrary.shadow),
              title: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Berita Terkini ',
                  style: GoogleFonts.dancingScript(
                      fontWeight: FontWeight.bold, color: ColorLibrary.shadow),
                ),
              ),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    ColorLibrary.primarySuperDark,
                    ColorLibrary.primaryLow,
                    ColorLibrary.primary
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(20),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      ColorLibrary.primarySuperDark,
                      ColorLibrary.primaryLow,
                      ColorLibrary.primary
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  ),
                ),
              ),
            ),
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ColorLibrary.primarySuperDark,
                        ColorLibrary.primaryLow,
                        ColorLibrary.primary
                      ],
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.45,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: model.detailBerita.attachment!,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
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
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.4),
                    padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                    decoration: BoxDecoration(
                        color: ColorLibrary.shadow,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    child: Column(
                      children: [
                        Icon(Icons.arrow_drop_up),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ListView(
                            children: [
                              Text(
                                model.detailBerita.judul!,
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 20),
                                height: 2,
                                width: double.infinity,
                                color: ColorLibrary.textColor,
                              ),
                              Text(
                                model.detailBerita.description!,
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}
