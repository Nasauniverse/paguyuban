import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paguyuban/media_query/size_config.dart';
import 'package:paguyuban/others/colors.dart';
import 'package:paguyuban/provider/bagian_view_model.dart';
import 'package:paguyuban/provider/kepengurusan_view_model.dart';
import 'package:paguyuban/widget/loading.dart';
import 'package:provider/provider.dart';

class KepengurusanPage extends StatelessWidget {
  const KepengurusanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<KepengurusanViewModel, BagianViewModel>(
        builder: (context, model, modelBagian, _) {
      if (model.isLoading) {
        return LoadingWidget();
      }
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
            title: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Kepengurusan ',
                style: GoogleFonts.dancingScript(
                    color: ColorLibrary.shadow,
                    fontSize: 35,
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
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: model.kepengurusan.length,
                  itemBuilder: (context, index) => Container(
                    decoration: BoxDecoration(
                        color: ColorLibrary.primary,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 3),
                              blurRadius: 10,
                              color: Colors.black38),
                        ],
                        borderRadius: BorderRadius.circular(20)),
                    height: MediaQuery.of(context).size.height / 5,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 2, color: ColorLibrary.secondary),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                color: Colors.white,
                                child: model.kepengurusan[index].image != null
                                    ? CachedNetworkImage(
                                        imageUrl:
                                            model.kepengurusan[index].image!,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          width: 100,
                                          height: 130,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        progressIndicatorBuilder: (context, url,
                                                downloadProgress) =>
                                            CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                            color: Colors.white,
                                            child: Image.asset(
                                              "assets/images/cameraguide.png",
                                              width: 100,
                                              height: 130,
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                              ),
                            )),
                        //data kepengurusan
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: AutoSizeText(
                                  maxLines: 3,
                                  model.kepengurusan[index].nama!,
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w800,
                                      color: ColorLibrary.shadow,
                                      fontSize: 20),
                                ),
                              ),
                              Container(
                                height: 2,
                                width: MediaQuery.of(context).size.width / 2,
                                color: ColorLibrary.shadow,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    model.kepengurusan[index].jabatan!,
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w800,
                                        color: ColorLibrary.shadow,
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  modelBagian.getNamaBagianById(
                                      model.kepengurusan[index].bagian),
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w800,
                                      color: ColorLibrary.shadow,
                                      fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              if (model.lastPage != null && model.lastPage! > 1)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed:
                          model.currentPage > 1 ? model.forwardPage : null,
                      child: Text('Kembali'),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Page${model.currentPage}of ${model.lastPage}"),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        onPressed: model.currentPage < (model.lastPage ?? 1)
                            ? model.nextPage
                            : null,
                        child: Text('Selanjutnya'))
                  ],
                )
            ],
          ),
        ),
      );
    });
  }
}
