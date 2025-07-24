import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paguyuban/others/colors.dart';
import 'package:paguyuban/provider/akun_view_model.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    return Consumer<AkunViewModel>(
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          // shadowColor: ColorLibrary.shadow,
          elevation: 0,
          leading: InkWell(
              onTap: () {
                // alertKeluar().show();
                model.clearData();
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back, color: ColorLibrary.primary)),
          title: Text("Daftar Keanggotaan",
              style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: ColorLibrary.shadow)),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  ColorLibrary.primarySuperDark,
                  ColorLibrary.primaryLow,
                  ColorLibrary.primary
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(25))),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        top: 20, right: 20, left: 20, bottom: 20),
                    child: Row(
                      children: [
                        Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                color: ColorLibrary.thirdDark,
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(
                              child: Text("1",
                                  style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: 23,
                                      fontWeight: FontWeight.w500)),
                            )),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: 3,
                            decoration: BoxDecoration(
                                color: model.numberPage >= 0
                                    ? ColorLibrary.thirdDark
                                    : ColorLibrary.grey,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                color: model.numberPage >= 1
                                    ? ColorLibrary.thirdDark
                                    : ColorLibrary.grey,
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(
                              child: Text("2",
                                  style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: 23,
                                      fontWeight: FontWeight.w500)),
                            )),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: 3,
                            decoration: BoxDecoration(
                                color: model.numberPage >= 2
                                    ? ColorLibrary.thirdDark
                                    : ColorLibrary.grey,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                color: model.numberPage >= 2
                                    ? ColorLibrary.thirdDark
                                    : ColorLibrary.grey,
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(
                              child: Text("3",
                                  style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: 23,
                                      fontWeight: FontWeight.w500)),
                            )),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: 3,
                            decoration: BoxDecoration(
                                color: model.numberPage >= 3
                                    ? ColorLibrary.thirdDark
                                    : ColorLibrary.grey,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                color: model.numberPage >= 3
                                    ? ColorLibrary.thirdDark
                                    : ColorLibrary.grey,
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(
                              child: Text("4",
                                  style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: 23,
                                      fontWeight: FontWeight.w500)),
                            )),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: 3,
                            decoration: BoxDecoration(
                                color: model.numberPage >= 4
                                    ? ColorLibrary.thirdDark
                                    : ColorLibrary.grey,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                color: model.numberPage >= 4
                                    ? ColorLibrary.thirdDark
                                    : ColorLibrary.grey,
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(
                              child: Text("5",
                                  style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: 23,
                                      fontWeight: FontWeight.w500)),
                            )),
                      ],
                    ),
                  ),
                ]),
          ),
        ),
        body: Column(children: [
          Container(width: double.infinity, height: 1, color: Colors.black12),
          Expanded(
            child: model.numberPage == 0
                ? model.form1(context)
                : model.numberPage == 1
                    ? model.form2(context)
                    : model.numberPage == 2
                        ? model.form3(context)
                        : model.numberPage == 3
                            ? model.form4(context)
                            : model.form5(context),
          ),
        ]),
      ),
    );
  }
}
