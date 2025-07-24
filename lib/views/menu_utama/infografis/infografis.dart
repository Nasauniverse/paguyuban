import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paguyuban/others/colors.dart';
import 'package:paguyuban/provider/infografis_view_model.dart';
import 'package:paguyuban/routes/routes.dart';
import 'package:paguyuban/widget/loading.dart';
import 'package:provider/provider.dart';

class InfografisPage extends StatelessWidget {
  const InfografisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InfografisViewModel>(
      builder: (context, model, _) {
        if (model.isLoading) {
          return LoadingWidget();
        }

        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/backwhite.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            backgroundColor: const Color.fromARGB(210, 255, 255, 255),
            appBar: AppBar(
              iconTheme: IconThemeData(color: ColorLibrary.shadow),
              backgroundColor: Colors.transparent,
              title: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Infografis Paguyuban',
                  style: GoogleFonts.dancingScript(
                    color: ColorLibrary.shadow,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              flexibleSpace: Container(
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
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(20)),
                ),
              ),
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                await Provider.of<InfografisViewModel>(context, listen: false)
                    .dataInfografis();
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: model.infografis.length,
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () {
                            Provider.of<InfografisViewModel>(context,
                                    listen: false)
                                .getDetailInfografis(model.infografis[i]);
                            Navigator.pushNamed(context, detailInfografisRoute);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 2,
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
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(15)),
                                      border: Border.all(
                                          width: 2,
                                          color: ColorLibrary.primary),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: model.infografis[i].lampiran!,
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
                                        progressIndicatorBuilder: (context, url,
                                                downloadProgress) =>
                                            CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    decoration: BoxDecoration(
                                      color: ColorLibrary.primaryLow,
                                      borderRadius: BorderRadius.vertical(
                                          bottom: Radius.circular(15)),
                                      border: Border.all(
                                          width: 2,
                                          color: ColorLibrary.primary),
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child: AutoSizeText(
                                      maxLines: 5,
                                      model.infografis[i].nama!,
                                      style: GoogleFonts.roboto(
                                        fontSize: 20,
                                        color: ColorLibrary.shadow,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    // Pagination buttons
                    if (model.lastPage != null && model.lastPage! > 1)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (model.currentPage > 1)
                              IconButton(
                                icon: Icon(Icons.chevron_left),
                                onPressed: model.currentPage > 1
                                    ? model.forwardPage
                                    : null,
                              ),
                            // Pagination numbers
                            for (int i = 1; i <= model.lastPage!; i++)
                              if (i <= 4 ||
                                  i == model.lastPage ||
                                  (i == model.currentPage - 1 ||
                                      i == model.currentPage + 1))
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (i != model.currentPage) {
                                        model.goToPage(
                                            i); // Method to change the page
                                      }
                                    },
                                    child: Text(
                                      i.toString(),
                                      style: TextStyle(
                                        color: i == model.currentPage
                                            ? ColorLibrary.third
                                            : Colors.black,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: i == model.currentPage
                                          ? ColorLibrary.primary
                                          : Colors.grey[200],
                                    ),
                                  ),
                                )
                              else if (i == 5 && model.currentPage > 5)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: Text('...'),
                                ),
                            if (model.currentPage < model.lastPage!)
                              IconButton(
                                icon: Icon(Icons.chevron_right),
                                onPressed:
                                    model.currentPage < (model.lastPage ?? 1)
                                        ? model.nextPage
                                        : null,
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
