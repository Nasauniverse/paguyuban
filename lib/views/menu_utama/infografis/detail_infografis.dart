import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paguyuban/others/colors.dart';
import 'package:paguyuban/provider/infografis_view_model.dart';
import 'package:provider/provider.dart';

class DetailInfografisPage extends StatelessWidget {
  const DetailInfografisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InfografisViewModel>(
        builder: (context, model, _) => Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(color: ColorLibrary.shadow),
                title: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(' Infografis Paguyuban ',
                      style: GoogleFonts.dancingScript(
                          fontWeight: FontWeight.bold,
                          color: ColorLibrary.shadow)),
                ),
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      ColorLibrary.primarySuperDark,
                      ColorLibrary.primaryLow,
                      ColorLibrary.primary
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(20)),
                  ),
                ),
              ),
              body: Center(
                child: InteractiveViewer(
                  minScale: 1.0,
                  maxScale: 4.0,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: CachedNetworkImage(
                        imageUrl: model.detailInfografis.lampiran!,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fitWidth,
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
                ),
              ),
            ));
  }
}
