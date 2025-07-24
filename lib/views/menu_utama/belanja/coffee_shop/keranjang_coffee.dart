import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paguyuban/media_query/size_config.dart';
import 'package:paguyuban/others/colors.dart';
import 'package:paguyuban/provider/coffee_view_model.dart';
import 'package:provider/provider.dart';

class KeranjangCoffeePage extends StatelessWidget {
  const KeranjangCoffeePage({super.key});

  @override
  Widget build(BuildContext context) {
    Query.init(context);
    return  Consumer<CoffeeViewModel>(
      builder: (context, model, _) =>
       Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/backwhite.png'),
                fit: BoxFit.cover)),
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: ColorLibrary.shadow),
            title: Text('Keranjang',
                style: GoogleFonts.dancingScript(
                  fontSize: 35,
                  color: ColorLibrary.shadow,
                  fontWeight: FontWeight.bold,
                )),
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
          backgroundColor: Color.fromARGB(210, 255, 255, 255),
          body: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) => Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              margin: EdgeInsets.all(10),
              height: Query.bagiHeight(9),
              width: double.infinity,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black26, offset: Offset(0, 3), blurRadius: 20)
              ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  Expanded(flex: 1,
                      child: model.checkbox()),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(20)),
                      width: Query.bagiHeight(9),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(color: Colors.blue),
                      )),
                  Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(color: Colors.amber),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
