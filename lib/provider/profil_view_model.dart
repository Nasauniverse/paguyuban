import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:paguyuban/models/cetak_kartu.dart';
import 'package:paguyuban/models/profil.dart';
import 'package:paguyuban/others/colors.dart';
import 'package:paguyuban/services/api.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:developer' as dev;
import 'package:http_parser/http_parser.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilViewModel extends ChangeNotifier {
  ScreenshotController screenshotController = ScreenshotController();
  ResProfil resProfil = ResProfil();
  ResCetakKartu resCetakKartu = ResCetakKartu();
  bool isUserImagePicked = false;
  bool isUserPhotoPicked = false;

  Member? profil;
  var nameUpdate = TextEditingController();
  var alamatUpdate = TextEditingController();
  var emailUpdate = TextEditingController();
  XFile? userCameraUpdate;
  XFile? userImageUpdate;

  dataProfil() async {
    // String token = await TokenShared.getToken();
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    notifyListeners();
    try {
      http.Response hasil = await http.get(
        Uri.parse("${Api.server}api/member/profile"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      if (hasil.statusCode == 200) {
        resProfil = resProfilFromJson(hasil.body);
        profil = resProfil.data!.member;

        // dev.log(hasil.body);
        dev.log("data profil berhasil tampil");
        dev.log(profil!.photo.toString());
        notifyListeners();
      }
    } catch (e) {
      dev.log("error $e");
    }
  }

  dataCetakKartu() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    notifyListeners();
    try {
      http.Response hasil = await http
          .get(Uri.parse("${Api.server}api/member/print-card"), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      });
      if (hasil.statusCode == 200) {
        resCetakKartu = resCetakKartuFromJson(hasil.body);
        notifyListeners();
      }
      dev.log(hasil.body);
    } catch (e) {
      dev.log("error $e");
    }
  }

  cetakKartu(context) async {
    if (resCetakKartu.data?.url == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "pdf tidak tersedia",
        style: GoogleFonts.roboto(
            fontWeight: FontWeight.bold, color: ColorLibrary.dangers),
      )));
      dev.log('URL tidak tersedia');
      return;
    }

    await launchUrl(
      Uri.parse(resCetakKartu.data!.url.toString()),
      webViewConfiguration: WebViewConfiguration(enableJavaScript: true),
      browserConfiguration: BrowserConfiguration(showTitle: true),
    );
  }

  String get formattedBirthdate {
    if (profil != null && profil!.birthdate != null) {
      return DateFormat('yyyy MMMM dd', 'id_ID').format(profil!.birthdate!);
    }
    return 'Tanggal lahir tidak tersedia';
  }

  String formatPhoneNumber(String? phone) {
    if (phone == null) return 'Nomor tidak tersedia';

    String cleanedPhone = phone.replaceAll(' ', '').replaceAll('-', '');

    if (cleanedPhone.startsWith('+62')) {
      cleanedPhone = cleanedPhone.replaceFirst('+62', '62');
    } else if (cleanedPhone.startsWith('0')) {
      cleanedPhone = cleanedPhone.replaceFirst('0', '62');
    }

    return cleanedPhone;
  }

  ceptureImage() {
    screenshotController.capture().then((Uint8List? image) async {
      if (image != null) {
        final directory = await getTemporaryDirectory();
        final imagePath = await File('${directory.path}/image.png').create();
        await imagePath.writeAsBytes(image);

        await Share.shareXFiles([XFile(imagePath.path)]);
        dev.log(" ss qr${imagePath.path}");
      }
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<void> updateProfil(context) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("${Api.server}api/member/update"),
      );

      request.headers.addAll({
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      });

      if (nameUpdate.text.isNotEmpty) {
        request.fields['name'] = nameUpdate.text;
      }
      if (alamatUpdate.text.isNotEmpty) {
        request.fields['address'] = alamatUpdate.text;
      }
      if (emailUpdate.text.isNotEmpty) {
        request.fields['email'] = emailUpdate.text;
      }

      if (userCameraUpdate != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'photo',
          userCameraUpdate!.path,
          contentType: MediaType('image', 'jpeg'),
        ));
      } else if (userImageUpdate != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'photo',
          userImageUpdate!.path,
          contentType: MediaType('image', 'jpeg'),
        ));
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        nameUpdate.clear();
        alamatUpdate.clear();
        userCameraUpdate = null;
        userImageUpdate = null;
        dataProfil();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Profil berhasil diperbaharui',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold, color: ColorLibrary.shadow),
            ),
          ),
        );
        dev.log("Profil berhasil diperbarui");
      } else {
        nameUpdate.clear();
        alamatUpdate.clear();
        userCameraUpdate = null;
        userImageUpdate = null;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: ColorLibrary.primary,
            content: Text(
              'Gagal memperbarui profil',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold, color: ColorLibrary.shadow),
            ),
          ),
        );
        dev.log("Gagal memperbarui profil: ${response.statusCode}");
      }
    } catch (e) {
      dev.log("error update profil $e");
    }
  }

  deleteUpdate() {
    nameUpdate.clear();
    alamatUpdate.clear();
    userCameraUpdate = null;
    userImageUpdate = null;
  }

  cameraUpdate() async {
    final photoUser = await ImagePicker().pickImage(source: ImageSource.camera);
    if (photoUser != null) {
      final croppedPhoto = await ImageCropper().cropImage(
        sourcePath: photoUser.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Foto anda',
            toolbarColor: ColorLibrary.primary,
            toolbarWidgetColor: Colors.white,
            activeControlsWidgetColor: ColorLibrary.primarySuperDark,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ],
          ),
          IOSUiSettings(aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
          ])
        ],
      );
      if (croppedPhoto != null) {
        // Compress the cropped image
        final compressedPhoto = await compressImage(XFile(croppedPhoto.path));
        if (compressedPhoto != null) {
          userCameraUpdate = XFile(compressedPhoto.path);
          isUserPhotoPicked = true;
          notifyListeners();
        } else {
          dev.log("Failed to compress cropped image");
        }
      }
    }
  }

  imageUpdate() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final croppedImage = await ImageCropper().cropImage(
        sourcePath: image.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Foto KTP',
            toolbarColor: ColorLibrary.primary,
            toolbarWidgetColor: Colors.white,
            activeControlsWidgetColor: ColorLibrary.primarySuperDark,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ],
          ),
          IOSUiSettings(aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
          ])
        ],
      );
      if (croppedImage != null) {
        final compressedPhoto = await compressImage(XFile(croppedImage.path));
        if (compressedPhoto != null) {
          userImageUpdate = XFile(compressedPhoto.path);
          notifyListeners();
        } else {
          dev.log("Gagal mengompress gambar image user ");
        }
      }
    }
  }

  Future<XFile?> compressImage(XFile file) async {
    try {
      final dir = await Directory.systemTemp.createTemp();
      final targetPath = "${dir.path}/${file.name}_compressed.jpg";
      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        file.path,
        targetPath,
        quality: 70, // Sesuaikan kualitas sesuai kebutuhan
      );

      return compressedFile;
    } catch (e) {
      dev.log("gagal mengcompress gambar $e");
      return null;
    }
  }

  alertCameraAndImageUser(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Pilih media",
              style: GoogleFonts.robotoCondensed(
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      cameraUpdate();
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      height: MediaQuery.of(context).size.height / 20,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: ColorLibrary.primary,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 3),
                                color: Colors.black26,
                                blurRadius: 10)
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt,
                            color: ColorLibrary.shadow,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Camera",
                            style: GoogleFonts.robotoCondensed(
                                fontWeight: FontWeight.bold,
                                color: ColorLibrary.shadow),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      imageUpdate();
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      height: MediaQuery.of(context).size.height / 20,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: ColorLibrary.thirdDark,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 3),
                                color: Colors.black26,
                                blurRadius: 10)
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image_outlined,
                              color: ColorLibrary.shadow),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Galeri",
                              style: GoogleFonts.robotoCondensed(
                                  fontWeight: FontWeight.bold,
                                  color: ColorLibrary.shadow))
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          );
        });
  }
}
