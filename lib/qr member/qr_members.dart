import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paguyuban/others/colors.dart';
import 'package:paguyuban/provider/generate_qr_view_model.dart';
import 'package:paguyuban/provider/maps_view_model.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:provider/provider.dart';

class QrMembers extends StatelessWidget {
  const QrMembers({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MapsViewModel>(
      builder: (context, modelMembers, _) => Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: ColorLibrary.shadow),
          backgroundColor: Colors.transparent,
          title: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Member Paguyuban',
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
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
          ),
        ),
        body: modelMembers.dataMembers.isEmpty
            ? Center(child: Text('Data anggota tidak tersedia'))
            : ListView.builder(
                itemCount: 10,
                itemBuilder: (context, i) {
                  final datum = modelMembers.dataMembers[i];

                  return Container(
                    margin: EdgeInsets.all(15),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 2,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: ColorLibrary.primary),
                      color: ColorLibrary.shadow,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(datum.lat.toString()),
                          Text(datum.members!.first.name ??
                              'Nama tidak tersedia'),
                          Text(
                            datum.members?.isNotEmpty == true
                                ? modelMembers.formatPhoneNumber(datum
                                    .members!
                                    .first
                                    .phone) // Memanggil fungsi untuk memformat nomor telepon
                                : 'Nomor tidak tersedia',
                          ),
                          PrettyQrView.data(
                            data: datum.members?.isNotEmpty == true
                                ? 'https://wa.me/${modelMembers.formatPhoneNumber(datum.members!.first.phone)}'
                                : 'https://wa.me/',
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
