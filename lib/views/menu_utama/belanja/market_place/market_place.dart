import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paguyuban/others/colors.dart';
import 'package:paguyuban/provider/market_place_view_model.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MarketPlacePage extends StatelessWidget {
  const MarketPlacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/backwhite.png"),
              fit: BoxFit.cover)),
      child: Consumer<MarketPlaceViewModel>(
        builder: (context, model, _) => PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) async {
            if (await model.controller.canGoBack()) {
              await model.controller.goBack();
            } else {
              Navigator.pop(context);
            }
          },
          child: Scaffold(
            backgroundColor: const Color.fromARGB(210, 255, 255, 255),
            appBar: AppBar(
              iconTheme: IconThemeData(color: ColorLibrary.shadow),
              title: Text(
                "Pasundan Mart",
                style: GoogleFonts.dancingScript(
                    fontSize: 35,
                    color: ColorLibrary.shadow,
                    fontWeight: FontWeight.bold),
              ),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      ColorLibrary.primarySuperDark,
                      ColorLibrary.primaryLow,
                      ColorLibrary.primary
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
            body: WebViewWidget(controller: model.controller),
          ),
        ),
      ),
    );
  }
}
