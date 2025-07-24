import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paguyuban/others/colors.dart';
import 'package:paguyuban/provider/akun_view_model.dart';
import 'package:paguyuban/provider/profil_view_model.dart';
import 'package:paguyuban/routes/routes.dart';
import 'package:provider/provider.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        textStyle: const TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        backgroundColor: Colors.blue);
    return Consumer2<ProfilViewModel, AkunViewModel>(
        builder: (context, model, modelAkun, _) => Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/backwhite.png"),
                    fit: BoxFit.cover)),
            child: Scaffold(
              backgroundColor: const Color.fromARGB(210, 255, 255, 255),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile Picture
                      Center(
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: ColorLibrary.primary,
                              width: 2,
                            ),
                          ),
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: model.profil!.photo!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress.progress),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      // Name
                      Center(
                        child: Text(
                          model.profil!.name!,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Provider.of<AkunViewModel>(context,
                                        listen: false)
                                    .showConfirmationDialog(context);
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.height / 25,
                                width: MediaQuery.of(context).size.width / 2.5,
                                decoration: BoxDecoration(
                                    color: ColorLibrary.dangers,
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 3),
                                          color: Colors.black26,
                                          blurRadius: 10)
                                    ],
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        width: 2, color: ColorLibrary.shadow)),
                                child: Center(
                                  child: Text(
                                    "Hapus Akun",
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.bold,
                                        color: ColorLibrary.shadow),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, editNamaRoute);
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.height / 25,
                                width: MediaQuery.of(context).size.width / 2.5,
                                decoration: BoxDecoration(
                                    color: ColorLibrary.shadow,
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 3),
                                          color: Colors.black26,
                                          blurRadius: 10)
                                    ],
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        width: 2, color: ColorLibrary.primary)),
                                child: Center(
                                  child: Text(
                                    "Edit Profil",
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.bold,
                                        color: ColorLibrary.primary),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Cetak kartu",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            color: ColorLibrary.primary,
                            fontSize: 15),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      InkWell(
                        onTap: () {
                          Provider.of<ProfilViewModel>(context, listen: false)
                              .cetakKartu(context);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.print,
                              color: ColorLibrary.primary,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: AutoSizeText(
                                "Klik Untuk mencetak kartu",
                                minFontSize: 10,
                                maxFontSize: 14,
                                maxLines: 3,
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: ColorLibrary.primary,
                            )
                          ],
                        ),
                      ),

                      Text(
                        "Qr Whatsapp",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            color: ColorLibrary.primary,
                            fontSize: 15),
                      ),
                      SizedBox(height: 4),
                      // Address
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, qrProfilRoute);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.qr_code,
                                color: ColorLibrary.primary,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: AutoSizeText(
                                  "Klik Untuk membuka qr",
                                  minFontSize: 10,
                                  maxFontSize: 14,
                                  maxLines: 3,
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: ColorLibrary.primary,
                              )
                            ],
                          )),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 4),
                        color: Colors.black26,
                        height: 2,
                        width: double.infinity,
                      ),
                      Text(
                        "Nama",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            color: ColorLibrary.primary,
                            fontSize: 15),
                      ),
                      SizedBox(height: 4),
                      // Address
                      Row(
                        children: [
                          Icon(
                            Icons.account_box,
                            color: ColorLibrary.primary,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: AutoSizeText(
                              model.profil?.name ?? "Nama anda belum di isi",
                              minFontSize: 10,
                              maxFontSize: 14,
                              maxLines: 3,
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 4),
                        color: Colors.black26,
                        height: 2,
                        width: double.infinity,
                      ),
                      Text(
                        "Email",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            color: ColorLibrary.primary,
                            fontSize: 15),
                      ),
                      SizedBox(height: 4),
                      // Address
                      Row(
                        children: [
                          Icon(
                            Icons.email,
                            color: ColorLibrary.primary,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: AutoSizeText(
                              model.profil?.email ?? "Email anda belum di isi",
                              minFontSize: 10,
                              maxFontSize: 14,
                              maxLines: 3,
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 4),
                        color: Colors.black26,
                        height: 2,
                        width: double.infinity,
                      ),
                      Text(
                        "Jabatan",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            color: ColorLibrary.primary,
                            fontSize: 15),
                      ),
                      SizedBox(height: 4),
                      // Address
                      Row(
                        children: [
                          Icon(
                            Icons.business_center,
                            color: ColorLibrary.primary,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: AutoSizeText(
                              model.profil?.jabatan ??
                                  "Jabatan anda belum di isi",
                              minFontSize: 10,
                              maxFontSize: 14,
                              maxLines: 3,
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 4),
                        color: Colors.black26,
                        height: 2,
                        width: double.infinity,
                      ),
                      Text(
                        "Nik",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            color: ColorLibrary.primary,
                            fontSize: 15),
                      ),
                      SizedBox(height: 4),
                      // Address
                      Container(
                          child: Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: ColorLibrary.primary,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: AutoSizeText(
                              model.profil?.nik ?? "NIK belum di isi",
                              minFontSize: 10,
                              maxFontSize: 14,
                              maxLines: 3,
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        ],
                      )),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 4),
                        color: Colors.black26,
                        height: 2,
                        width: double.infinity,
                      ),
                      Text(
                        "No Handphone",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            color: ColorLibrary.primary,
                            fontSize: 15),
                      ),
                      SizedBox(height: 4),
                      // Address
                      Container(
                          child: Row(
                        children: [
                          Icon(
                            Icons.phone,
                            color: ColorLibrary.primary,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: AutoSizeText(
                              model.profil?.phone ?? "No handphone",
                              minFontSize: 10,
                              maxFontSize: 14,
                              maxLines: 3,
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        ],
                      )),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 4),
                        color: Colors.black26,
                        height: 2,
                        width: double.infinity,
                      ),
                      Text(
                        "Alamat",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            color: ColorLibrary.primary,
                            fontSize: 15),
                      ),
                      SizedBox(height: 4),
                      // Address
                      Row(
                        children: [
                          Icon(
                            Icons.home,
                            color: ColorLibrary.primary,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: AutoSizeText(
                              model.profil?.address ?? "Alamat",
                              minFontSize: 10,
                              maxFontSize: 14,
                              maxLines: 3,
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 4),
                        color: Colors.black26,
                        height: 2,
                        width: double.infinity,
                      ),
                      // Date of Birth
                      Text(
                        "Tanggal Lahir",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            color: ColorLibrary.primary,
                            fontSize: 15),
                      ),
                      SizedBox(height: 4),
                      // Address
                      Container(
                          child: Row(
                        children: [
                          Icon(
                            Icons.cake,
                            color: ColorLibrary.primary,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: AutoSizeText(
                              model.formattedBirthdate,
                              minFontSize: 10,
                              maxFontSize: 14,
                              maxLines: 3,
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        ],
                      )),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 4),
                        color: Colors.black26,
                        height: 2,
                        width: double.infinity,
                      ),
                      // Education
                      Text(
                        "Pendidikan",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            color: ColorLibrary.primary,
                            fontSize: 15),
                      ),
                      SizedBox(height: 4),
                      // Address
                      Container(
                          child: Row(
                        children: [
                          Icon(
                            Icons.school,
                            color: ColorLibrary.primary,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: AutoSizeText(
                              model.profil?.education.toString() ??
                                  "Pendidikan",
                              minFontSize: 10,
                              maxFontSize: 14,
                              maxLines: 3,
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        ],
                      )),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 4),
                        color: Colors.black26,
                        height: 2,
                        width: double.infinity,
                      ),
                      // Occupation
                      Text(
                        "Pekerjaan",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            color: ColorLibrary.primary,
                            fontSize: 15),
                      ),
                      SizedBox(height: 4),
                      // Address
                      Container(
                          child: Row(
                        children: [
                          Icon(
                            Icons.work,
                            color: ColorLibrary.primary,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: AutoSizeText(
                              model.profil?.occupation.toString() ??
                                  "Pekerjaan",
                              minFontSize: 10,
                              maxFontSize: 14,
                              maxLines: 3,
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        ],
                      )),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 4),
                        color: Colors.black26,
                        height: 2,
                        width: double.infinity,
                      ),
                      Text(
                        "Provinsi",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            color: ColorLibrary.primary,
                            fontSize: 15),
                      ),
                      SizedBox(height: 4),
                      // Address
                      Container(
                          child: Row(
                        children: [
                          Icon(
                            Icons.map,
                            color: ColorLibrary.primary,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: AutoSizeText(
                              model.profil?.provinsi?.name ?? 'Provinsi',
                              minFontSize: 10,
                              maxFontSize: 14,
                              maxLines: 3,
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        ],
                      )),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 4),
                        color: Colors.black26,
                        height: 2,
                        width: double.infinity,
                      ),
                      Text(
                        "Kab/Kota",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            color: ColorLibrary.primary,
                            fontSize: 15),
                      ),
                      SizedBox(height: 4),
                      // Address
                      Container(
                          child: Row(
                        children: [
                          Icon(
                            Icons.location_city,
                            color: ColorLibrary.primary,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: AutoSizeText(
                              model.profil!.kabkot?.name ?? 'Kab/kot ',
                              minFontSize: 10,
                              maxFontSize: 14,
                              maxLines: 3,
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        ],
                      )),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 4),
                        color: Colors.black26,
                        height: 2,
                        width: double.infinity,
                      ),
                      Text(
                        "Kecamatan",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            color: ColorLibrary.primary,
                            fontSize: 15),
                      ),
                      SizedBox(height: 4),
                      // Address
                      Container(
                          child: Row(
                        children: [
                          Icon(
                            Icons.business,
                            color: ColorLibrary.primary,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: AutoSizeText(
                              model.profil?.kecamatan?.name ?? 'Kecamatan ',
                              minFontSize: 10,
                              maxFontSize: 14,
                              maxLines: 3,
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        ],
                      )),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 4),
                        color: Colors.black26,
                        height: 2,
                        width: double.infinity,
                      ),

                      InkWell(
                        onTap: () {
                          modelAkun.alertLogout(context);
                          // Navigator.pushReplacementNamed(context, loginRoute);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: ColorLibrary.primary,
                              borderRadius: BorderRadius.circular(10)),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 19,
                          child: Center(
                              child: Text(
                            "Logout",
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                color: ColorLibrary.shadow),
                          )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}
