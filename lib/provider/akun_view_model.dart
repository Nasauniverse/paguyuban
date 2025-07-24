import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:paguyuban/main.dart';
import 'package:paguyuban/models/agama.dart';
import 'package:paguyuban/models/edukasi.dart';
import 'package:paguyuban/models/kecamatan.dart';
import 'package:paguyuban/models/kota.dart';
import 'package:paguyuban/models/login.dart';
import 'package:paguyuban/models/pekerjaan.dart';
import 'package:paguyuban/models/provinsi.dart';
import 'package:paguyuban/provider/bagian_view_model.dart';
import 'package:paguyuban/provider/berita_view_model.dart';
import 'package:paguyuban/provider/infografis_view_model.dart';
import 'package:paguyuban/provider/jenis_usaha_view_model.dart';
import 'package:paguyuban/provider/kepengurusan_view_model.dart';
import 'package:paguyuban/provider/maps_view_model.dart';
import 'package:paguyuban/provider/profil_view_model.dart';
import 'package:paguyuban/provider/unit_paguyuban_view_model.dart';
import 'package:paguyuban/routes/routes.dart';
import 'package:paguyuban/services/api.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as dev;

import '../others/colors.dart';

class AkunViewModel extends ChangeNotifier {
  //sign
  var name = TextEditingController();
  var nik = TextEditingController();
  var birthdate = TextEditingController();
  var addres = TextEditingController();
  var religion = TextEditingController();
  var district = TextEditingController();
  var regency = TextEditingController();
  var province = TextEditingController();
  var phone = TextEditingController();
  var pekerjaan = TextEditingController();
  var edukasi = TextEditingController();
  //login
  var username = TextEditingController();
  var password = TextEditingController();
  var device = TextEditingController();
  var email = TextEditingController();
  LoginMember? dataLogin;
  ResAgama resAgama = ResAgama();
  ResEdukasi resEdukasi = ResEdukasi();
  ResPekerjaan resPekerjaan = ResPekerjaan();
  ResProvinsi resProvinsi = ResProvinsi();
  ResKecamatan resKecamatan = ResKecamatan();
  ResKota resKota = ResKota();
  ResLogin resLogin = ResLogin();
  List<DataKota> listKota = [];
  List<DataProvinsi> listProvinsi = [];
  List<DataKecamatan> listKecamatan = [];
  int numberPage = 0;
  int get indexPage => numberPage;
  String hp = "hp";
  String? selectedAgama;
  String? selectedEdukasi;
  String? selectedPekerjaan;
  String? token;
  DataProvinsi? selectedProvinsi;
  DataKota? selectedKota;
  DataKecamatan? selectedKecamatan;
  bool isObscured = true;
  bool isLoggedIn = false;
  bool isUserImagePicked = false;
  bool isUserPhotoPicked = false;
  XFile? _userPhoto;
  XFile? _ktpPhoto;
  XFile? _userImage;
  XFile? _ktpImage;
  XFile? get userPhoto => _userPhoto;
  XFile? get ktpPhoto => _ktpPhoto;
  XFile? get   userImage => _userImage;
  XFile? get ktpImage => _ktpImage;

//bagian khsusus methode/function

  Future<void> deleteAccount() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    try {
      http.Response hasil = await http.post(
        Uri.parse("${Api.server}api/member/delete-account"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      );

      if (hasil.statusCode == 200) {
        dev.log("Berhasil menghapus akun dan mereset data");
        dev.log("${hasil.statusCode}");
        // Hapus semua data dari SharedPreferences
        await prefs.clear();

        // Reset variabel global jika ada
        isLoggedIn = false;
        username.text = "";
        password.text = "";

        // if (context.mounted) {
        //   dev.log("berhasil navigasi");
        //   WidgetsBinding.instance.addPostFrameCallback((_) {
        //     Navigator.of(context).pushNamedAndRemoveUntil(
        //       loginRoute,
        //       (Route<dynamic> route) => false,
        //     );
        //   });
        // } else {
        //   dev.log("gagal navigasi ke halaman login");
        // }
      } else {
        dev.log("Gagal menghapus akun: ${hasil.statusCode}");
      }
    } catch (e) {
      dev.log("Error hapus akun: $e");
    }
  }

  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus Akun'),
          content: Text(
              'Apakah Anda yakin ingin menghapus akun Anda? Semua data akan dihapus dan tidak dapat dikembalikan.'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      height: 35,
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                          color: ColorLibrary.dangers,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Tidak",
                          style: GoogleFonts.roboto(
                            color: ColorLibrary.shadow,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    // Tampilkan dialog konfirmasi kedua
                    showFinalConfirmationDialog(context);
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    height: 35,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                        color: ColorLibrary.primary,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "Lanjutkan",
                        style: GoogleFonts.roboto(color: ColorLibrary.shadow),
                      ),
                    ),
                  ),
                ))
              ],
            )
          ],
        );
      },
    );
  }

  void showFinalConfirmationDialog(BuildContext parentContext) async {
    TextEditingController controller = TextEditingController();
    final prefs = await SharedPreferences.getInstance();
    final savedPassword = prefs.getString('password');

    showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Terakhir'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Masukkan password Anda untuk mengonfirmasi bahwa Anda ingin menghapus akun ini secara permanen.',
              ),
              TextField(
                controller: controller,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context); // Menutup dialog
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      height: 35,
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                          color: ColorLibrary.dangers,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Tidak",
                          style: GoogleFonts.roboto(
                            color: ColorLibrary.shadow,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      if (controller.text == savedPassword) {
                        dev.log("berhasil passwordnyaa");
                        await deleteAccount();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          loginRoute,
                          (Route<dynamic> route) => false,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Password salah, penghapusan dibatalkan.',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  color: ColorLibrary.dangers),
                            ),
                          ),
                        );
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      height: 35,
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                          color: ColorLibrary.primary,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Hapus Akun",
                          style: GoogleFonts.roboto(color: ColorLibrary.shadow),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }

  List<String> validateForm() {
    List<String> emptyFields = [];

    if (name.text.isEmpty) emptyFields.add("Nama");
    if (nik.text.isEmpty) emptyFields.add("NIK");
    if (birthdate.text.isEmpty) emptyFields.add("Tanggal Lahir");
    if (addres.text.isEmpty) emptyFields.add("Alamat");
    if (religion.text.isEmpty) emptyFields.add("Agama");
    if (district.text.isEmpty) emptyFields.add("Kecamatan");
    if (regency.text.isEmpty) emptyFields.add("Kabupaten");
    if (province.text.isEmpty) emptyFields.add("Provinsi");
    if (phone.text.isEmpty) emptyFields.add("Telepon");
    if (pekerjaan.text.isEmpty) emptyFields.add("Pekerjaan");
    if (edukasi.text.isEmpty) emptyFields.add("Pendidikan");
    if (email.text.isEmpty) emptyFields.add("email");

    // Pastikan salah satu gambar diupload
    if (userImage == null && userPhoto == null)
      emptyFields.add("Foto Pengguna");
    if (ktpImage == null && ktpPhoto == null) emptyFields.add("Foto KTP");

    return emptyFields;
  }

  void onRegisterButtonPressed(context) async {
    List<String> emptyFields = validateForm();
    if (emptyFields.isEmpty) {
      moveToNextPage(0);
    } else {
      String fields = emptyFields.join(", ");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Peringatan"),
            content: Text("Field berikut belum terisi: $fields."),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: Center(
                  child: Container(
                    height: 35,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                        color: ColorLibrary.primary,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "Iya",
                          style: GoogleFonts.roboto(color: ColorLibrary.shadow),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
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

  cameraUser() async {
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
          _userPhoto = XFile(compressedPhoto.path);
          isUserPhotoPicked = true;
          notifyListeners();
        } else {
          dev.log("Failed to compress cropped image");
        }
      }
    }
  }

  cameraKtp() async {
    final photo = await ImagePicker().pickImage(source: ImageSource.camera);
    if (photo != null) {
      final croppedPhoto = await ImageCropper().cropImage(
        sourcePath: photo.path,
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
      if (croppedPhoto != null) {
        final compressedPhoto = await compressImage(XFile(croppedPhoto.path));
        if (compressedPhoto != null) {
          _ktpPhoto = XFile(compressedPhoto.path);
          isUserImagePicked = true;
          notifyListeners();
        } else {
          dev.log('Gagal mengompresi gambar ktp');
        }
      }
    }
  }

  imageUser() async {
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
              // CropAspectRatioPreset.ratio3x2,
              // CropAspectRatioPreset.original,
              // CropAspectRatioPreset.ratio4x3,
              // CropAspectRatioPreset.ratio16x9
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
          _userImage = XFile(compressedPhoto.path);
          notifyListeners();
        } else {
          dev.log("Gagal mengompress gambar image user ");
        }
      }
    }
  }

  imagektp() async {
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
              // CropAspectRatioPreset.ratio3x2,
              // CropAspectRatioPreset.original,
              // CropAspectRatioPreset.ratio4x3,
              // CropAspectRatioPreset.ratio16x9
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
          _ktpImage = XFile(compressedPhoto.path);
          notifyListeners();
        } else {
          dev.log("Gaga mengompress image ktp");
        }
      }
    }
  }

  void clearData() {
    // Mengatur ulang TextEditingController
    name.clear();
    nik.clear();
    birthdate.clear();
    addres.clear();
    religion.clear();
    district.clear();
    regency.clear();
    province.clear();
    phone.clear();
    pekerjaan.clear();
    edukasi.clear();

    // Mengatur ulang gambar
    _userImage = null;
    _ktpImage = null;
    _userPhoto = null;
    _ktpPhoto = null;

    // Memperbarui tampilan (jika diperlukan)
    notifyListeners();
  }

  registerUser(context) async {
    dev.log("Tanggal Lahir ${birthdate.text}");
    List<String> errors = validateForm();
    if (errors.isNotEmpty) {
      print('Field kosong: ${errors.join(", ")}');
      return;
    }

    try {
      var uri = Uri.parse("${Api.server}api/member/register");
      var request = http.MultipartRequest("POST", uri)
        ..headers["Accept"] = "application/json";
      request.fields["name"] = name.text;
      request.fields["nik"] = nik.text;
      request.fields["birthdate"] = birthdate.text;
      request.fields["address"] = addres.text;
      request.fields["religion"] = religion.text;
      request.fields["district_id"] = district.text;
      request.fields["regency_id"] = regency.text;
      request.fields["province_id"] = province.text;
      request.fields["phone"] = phone.text;
      request.fields["occupation"] = pekerjaan.text;
      request.fields["education"] = edukasi.text;
      request.fields['email'] = email.text;
      request.fields['jabatan'] = 'ANGGOTA';

      if (userPhoto != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'photo',
          userPhoto!.path,
          contentType: MediaType('image', 'jpeg'),
        ));
      } else if (userImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'photo',
          userImage!.path,
          contentType: MediaType('image', 'jpeg'),
        ));
      }
      if (ktpPhoto != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'photo_idcard',
          ktpPhoto!.path,
          contentType: MediaType('image', 'jpeg'),
        ));
      } else if (ktpImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'photo_idcard',
          ktpImage!.path,
          contentType: MediaType('image', 'jpeg'),
        ));
      }
      var response = await request.send();
      if (response.statusCode == 201) {
        clearData();
        dev.log('Registrasi berhasil!');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registrasi berhasil! Silakan login.'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );

        Future.delayed(Duration(milliseconds: 500), () {
          Navigator.pushReplacementNamed(context, loginRoute);
        });
      } else {
        final responseData = await http.Response.fromStream(response);
        dev.log('Gagal mendaftar: ${responseData.body}');
        if (response.statusCode == 422) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Pemberitahuan!"),
                content: Text("Gagal melakukan register: ${responseData.body}"),
                actions: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    child: Center(
                      child: Container(
                        height: 35,
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                            color: ColorLibrary.primary,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "Iya",
                              style: GoogleFonts.roboto(
                                  color: ColorLibrary.shadow),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        } else if (response.statusCode == 400) {
          // Menangani status code 400 (Bad Request)
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Kesalahan!"),
                content: Text("Nik sudah terdafdar"),
                actions: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    child: Center(
                      child: Container(
                        height: 35,
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                          color: ColorLibrary.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "Oke",
                              style: GoogleFonts.roboto(
                                  color: ColorLibrary.shadow),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }

        dev.log('Gagal mendaftar: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  toggleObscured() {
    isObscured = !isObscured;
    notifyListeners();
  }

  moveToNextPage(int type) {
    if (type == 0) {
      if (numberPage < 4) {
        numberPage++;
      }
    } else if (type == 1) {
      if (numberPage > 0) {
        numberPage--;
      }
    }
    notifyListeners();
  }

  logout(context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    isLoggedIn = false;
    username.text = "";
    password.text = "";
    notifyListeners();
  }

  resetForm() {
    username.text = "";
    password.text = "";
    notifyListeners();
  }

//bagian khusus untuk memanggil api
  datumShared() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final savedUsername = prefs.getString('username');
    final savedPassword = prefs.getString('password');
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    dev.log('Token: $token');
    dev.log('Username: $savedUsername');
    dev.log('Password: $savedPassword');
    dev.log('Is Logged In: $isLoggedIn');
  }

  fulldata(context) async {
    try {
      await Future.wait<void>([
        Provider.of<JenisUsahaViewModel>(context, listen: false)
            .dataJenisUsaha(),
        Provider.of<BagianViewModel>(context, listen: false).dataBagian(),
        Provider.of<ProfilViewModel>(context, listen: false).dataProfil(),
        Provider.of<BeritaViewModel>(context, listen: false).dataBerita(),
        Provider.of<InfografisViewModel>(context, listen: false)
            .dataInfografis(),
        Provider.of<KepengurusanViewModel>(context, listen: false)
            .dataKepengurusan(),
        Provider.of<MapsViewModel>(context, listen: false).dataMember(),
        Provider.of<UnitPaguyubanViewModel>(context, listen: false).dataUnit(),
        Provider.of<ProfilViewModel>(context, listen: false).dataCetakKartu(),
      ]);
    } catch (e) {
      dev.log("Error: $e");
    }
  }

  loginPaguyuban(BuildContext context) async {
    if (username.text.isEmpty || password.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Pemberitahuan!"),
            content: Text("No keanggotaan dan Kata sandi wajib di isi!"),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: Center(
                  child: Container(
                    height: 35,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                        color: ColorLibrary.primary,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "Iya",
                          style: GoogleFonts.roboto(color: ColorLibrary.shadow),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    } else {
      try {
        var body = {
          "username": username.text,
          "password": password.text,
          "device_name": "hp"
        };

        // Tampilkan indikator pemuatan
        showDialog(
          context: context,
          barrierDismissible:
              false, // Mencegah dialog ditutup saat diklik di luar
          builder: (BuildContext context) {
            return AlertDialog(
                backgroundColor: Colors.transparent,
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 10,
                      // height: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/logo.png"),
                              fit: BoxFit.fitHeight)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 3),
                      child: LinearProgressIndicator(
                        color: ColorLibrary.primary,
                        borderRadius: BorderRadius.circular(5),
                        backgroundColor: ColorLibrary.third,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Memuat ulang halaman...",
                        style: GoogleFonts.robotoCondensed(
                            fontWeight: FontWeight.w700,
                            color: ColorLibrary.shadow),
                      ),
                    )
                  ],
                ));
          },
        );

        http.Response hasil = await http.post(
          Uri.parse("${Api.server}api/member/login"),
          headers: {"Accept": "application/json"},
          body: body,
        );

        dev.log("data login berhasil tampil");

        if (hasil.statusCode == 200) {
          final resLogin = ResLogin.fromJson(json.decode(hasil.body));
          if (resLogin.success == true && resLogin.data != null) {
            dataLogin = resLogin.data!.member;
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('token', resLogin.data!.token ?? "");
            await prefs.setString('username', username.text);
            await prefs.setString('password', password.text);
            await prefs.setBool('isLoggedIn', true);
            resetForm();

            await fulldata(context);

            Navigator.of(context).pop();

            Navigator.pushReplacementNamed(context, dashboardRoute);
            dev.log(hasil.statusCode.toString());
          } else {
            dev.log("status code bukan 200");
            final resError = jsonDecode(hasil.body);
            String errorMessage = 'login ditolak, data tidak sesuai.';

            Navigator.of(context).pop();

            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(
                    errorMessage,
                    style: GoogleFonts.robotoCondensed(
                        fontWeight: FontWeight.w700),
                  ),
                  content: Text(
                    "Periksa NO keanggotaan atau kata sandi anda",
                    style: GoogleFonts.robotoCondensed(
                        fontWeight: FontWeight.bold),
                  ),
                  actions: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      child: Center(
                        child: Container(
                          height: 35,
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                              color: ColorLibrary.primary,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "Iya",
                                style: GoogleFonts.roboto(
                                    color: ColorLibrary.shadow),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }

          notifyListeners();
        } else {
          // Tutup dialog indikator pemuatan jika status kode bukan 200
          Navigator.of(context).pop();
        }
      } catch (e) {
        dev.log('error $e');
        // Tutup dialog indikator pemuatan jika terjadi kesalahan
        Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                "Error",
                style: GoogleFonts.robotoCondensed(fontWeight: FontWeight.w700),
              ),
              content: Text(
                "Terjadi kesalahan saat melakukan login, silahkan coba kembali!",
                style: GoogleFonts.robotoCondensed(fontWeight: FontWeight.bold),
              ),
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 35,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                        color: ColorLibrary.primary,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          "Iya",
                          style: GoogleFonts.roboto(color: ColorLibrary.shadow),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }
    }
  }

  dataAgama(context) async {
    try {
      http.Response hasil = await http.get(
        Uri.parse("${Api.server}api/religion/list"),
        headers: {"Accept": "application/json"},
      );
      if (hasil.statusCode == 200) {
        resAgama = resAgamaFromJson(hasil.body);
        dev.log('Fetched Data agama: ${hasil.body}');
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      dev.log('error data agama : $e');
    }
  }

  dataEdukasi(context) async {
    try {
      http.Response hasil = await http.get(
        Uri.parse("${Api.server}api/education/list"),
        headers: {"Accept": "application/json"},
      );
      if (hasil.statusCode == 200) {
        resEdukasi = resEdukasiFromJson(hasil.body);
        dev.log("fetched Data edukasi: ${hasil.body}");
        notifyListeners();
      }
    } catch (e) {
      dev.log('error data edukasi. $e');
    }
  }

  dataPekerjaan(context) async {
    try {
      http.Response hasil = await http.get(
        Uri.parse("${Api.server}api/occupation/list"),
        headers: {"accept": "application/jsoh"},
      );
      if (hasil.statusCode == 200) {
        resPekerjaan = resPekerjaanFromJson(hasil.body);
        dev.log("fatched Data pekerjaan: ${hasil.body}");
        notifyListeners();
      }
    } catch (e) {
      dev.log("error data pekerjaan. $e");
    }
  }

  dataProvinsi(context) async {
    try {
      http.Response hasil = await http.get(
        Uri.parse("${Api.server}api/listprovince"),
        headers: {"accept": "application/json"},
      );
      if (hasil.statusCode == 200) {
        resProvinsi = resProvinsiFromJson(hasil.body);
        listProvinsi = (resProvinsi.data ?? []).toSet().toList();
        dev.log("Fetched Data provinsi tampil");
        notifyListeners();
      } else {
        dev.log('failed to load');
      }
    } catch (e) {
      dev.log("error data provinsi. $e");
    }
  }

  dataKota(context) async {
    if (selectedProvinsi?.id == null || selectedProvinsi!.id!.isEmpty) return;
    try {
      http.Response hasil = await http.get(
          Uri.parse("${Api.server}api/listregency/${selectedProvinsi!.id}"),
          headers: {"accept": "application/json"});
      if (hasil.statusCode == 200) {
        resKota = resKotaFromJson(hasil.body);
        listKota = resKota.data ?? [];
        dev.log('retched Data Kota tampil');
        notifyListeners();
      } else {
        dev.log('failed to load');
      }
    } catch (e) {
      dev.log('error data kota $e');
    }
  }

  dataKecamatan(context) async {
    if (selectedKota?.id == null || selectedKota!.id!.isEmpty) return;
    try {
      http.Response hasil = await http.get(
          Uri.parse("${Api.server}api/listdistrict/${selectedKota!.id}"),
          headers: {"accept": "application/json"});
      if (hasil.statusCode == 200) {
        resKecamatan = resKecamatanFromJson(hasil.body);
        listKecamatan = (resKecamatan.data ?? []).toSet().toList();
        dev.log(
            "List Kecamatan: ${listKecamatan.map((kec) => kec.name).toList()}");

        dev.log('fetched Data Kecamatan tampil');
        notifyListeners();
      } else {
        dev.log('failed to load kecamatan');
      }
    } catch (e) {
      dev.log('error data kecamatan $e');
    }
  }

//bagian khusus tampilan

//untuk tanggal
  @override
  void dispose() {
    birthdate.dispose();
    province.dispose();
    regency.dispose();
    district.dispose();
    super.dispose();
  }

  void setBirthDate(DateTime date) {
    birthdate.text = DateFormat('yyyy-MM-dd').format(date);
    notifyListeners();
  }

  Future<void> selectDate(context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setBirthDate(pickedDate);
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
                      cameraUser();
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
                      imageUser();
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

  alertCameraAndImageKtp(context) async {
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
                      cameraKtp();
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
                      imagektp();
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

  dropdownProvinsi(context) {
    if (listProvinsi.isEmpty) {
      return CircularProgressIndicator();
    }
    return DropdownButton<DataProvinsi>(
      value: selectedProvinsi,
      hint: Text('Pilih Provinsi'),
      items: listProvinsi.map((DataProvinsi provinsi) {
        return DropdownMenuItem<DataProvinsi>(
          value: provinsi,
          child: Text(provinsi.name ?? ''),
        );
      }).toList(),
      onChanged: (DataProvinsi? newValue) {
        if (newValue != null) {
          selectedProvinsi = newValue;
          province.text = newValue.id ?? '';
          selectedKota = null;
          dataKota(context);
          selectedKecamatan = null;
          dataKecamatan(context);
          notifyListeners();
          dataKota(context);
        }
      },
      isExpanded: true,
    );
  }

  dropdownAgama() {
    if (resAgama.data!.isEmpty) {
      return CircularProgressIndicator();
    }
    return DropdownButton<String>(
      value: selectedAgama,
      hint: Text('Pilih Agama'),
      items: resAgama.data!.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        selectedAgama = newValue;
        religion.text = newValue ?? '';
        notifyListeners();
      },
      isExpanded: true,
    );
  }

  dropdownKota(context) {
    if (listKota.isEmpty) {
      return Text(
        "Pilih Provinsi terlebih dahulu",
        style: GoogleFonts.robotoCondensed(
          fontWeight: FontWeight.w700,
          color: Colors.black26,
        ),
      );
    }
    return DropdownButton<DataKota>(
      value: selectedKota,
      hint: Text('Pilih Kota'),
      items: listKota.map((DataKota kota) {
        return DropdownMenuItem<DataKota>(
          value: kota,
          child: Text(kota.name ?? ''),
        );
      }).toList(),
      onChanged: (DataKota? newValue) {
        if (newValue != null) {
          selectedKota = newValue;
          regency.text = newValue.id ?? '';
          selectedKecamatan = null;
          dataKecamatan(context);
          dataKecamatan(context);
          notifyListeners();
        }
      },
      isExpanded: true,
    );
  }

  dropdownKecamatan(context) {
    if (listKecamatan.isEmpty) {
      return Text(
        "Pilih Kab/Kota terlebih dahulu",
        style: GoogleFonts.robotoCondensed(
          fontWeight: FontWeight.w700,
          color: Colors.black26,
        ),
      );
    }

    // Debugging: Cek nilai sebelum dropdown
    print("Selected Kecamatan: $selectedKecamatan");
    print("List Kecamatan: ${listKecamatan.map((kec) => kec.name).toList()}");

    return DropdownButton<DataKecamatan>(
      value: selectedKecamatan,
      hint: Text('Pilih Kecamatan'),
      items: listKecamatan.map((DataKecamatan kecamatan) {
        return DropdownMenuItem<DataKecamatan>(
          value: kecamatan,
          child: Text(kecamatan.name ?? ''),
        );
      }).toList(),
      onChanged: (DataKecamatan? newValue) {
        if (newValue != null) {
          selectedKecamatan = newValue;
          district.text = newValue.id ?? '';
          notifyListeners(); // Pemberitahuan untuk pembaruan UI
        }
      },
      isExpanded: true,
    );
  }

  dropdownPekerjaan() {
    if (resPekerjaan.data!.isEmpty) {
      return CircularProgressIndicator();
    }
    return DropdownButton<String>(
      value: selectedPekerjaan,
      hint: Text('Pilih Pekerjaan'),
      items: resPekerjaan.data!.map((String value) {
        return DropdownMenuItem(value: value, child: Text(value));
      }).toList(),
      onChanged: (newValue) {
        selectedPekerjaan = newValue;
        pekerjaan.text = newValue ?? '';
        notifyListeners();
      },
      isExpanded: true,
    );
  }

  dropdownEdukasi() {
    if (resEdukasi.data!.isEmpty) {
      return CircularProgressIndicator();
    }
    return DropdownButton<String>(
      value: selectedEdukasi,
      hint: Text('Pilih Edukasi'),
      items: resEdukasi.data!.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        selectedEdukasi = newValue;
        edukasi.text = newValue ?? '';
        notifyListeners();
      },
      isExpanded: true,
    );
  }

  alertLogout(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Pemberitahuan!',
              style: GoogleFonts.robotoCondensed(
                  fontWeight: FontWeight.w800, color: ColorLibrary.primary),
            ),
            content: Text(
              "Apakah anda yakin akan melakukan logout?",
              style: GoogleFonts.robotoCondensed(fontWeight: FontWeight.w700),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        height: 35,
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                            color: ColorLibrary.dangers,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            "Tidak",
                            style: GoogleFonts.roboto(
                              color: ColorLibrary.shadow,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      logout(context);
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        loginRoute,
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      height: 35,
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                          color: ColorLibrary.primary,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Setuju",
                          style: GoogleFonts.roboto(color: ColorLibrary.shadow),
                        ),
                      ),
                    ),
                  ))
                ],
              )
            ],
          );
        });
  }

  alertSign(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Pemberitahuan!"),
          content: Text("Apakah anda yakin akan kembali kehalaman sebelumnya?"),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      height: 35,
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                          color: ColorLibrary.dangers,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Tidak",
                          style: GoogleFonts.roboto(
                            color: ColorLibrary.shadow,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      moveToNextPage(1);
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      height: 35,
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                          color: ColorLibrary.primary,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Iya",
                          style: GoogleFonts.roboto(
                            color: ColorLibrary.shadow,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  form1(context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Nama Lengkap",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.roboto(
                              color: ColorLibrary.textColor,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.none,
                              fontSize: 16)),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border:
                                Border.all(width: 1, color: Colors.black12)),
                        child: Material(
                          color: const Color.fromARGB(35, 248, 248, 248),
                          borderRadius: BorderRadius.circular(10.0),
                          child: TextField(
                            controller: name,
                            showCursor: true,
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontSize: 14,
                                    color: ColorLibrary.textColor)),
                            textInputAction: TextInputAction.next,
                            cursorColor: Colors.black12,
                            cursorWidth: 1,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 196, 196, 196)),
                              hintText: "Masukkan nama lengkap anda disini",
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text("Email",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.roboto(
                              color: ColorLibrary.textColor,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.none,
                              fontSize: 16)),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border:
                                Border.all(width: 1, color: Colors.black12)),
                        child: Material(
                          color: const Color.fromARGB(35, 248, 248, 248),
                          borderRadius: BorderRadius.circular(10.0),
                          child: TextField(
                            controller: email,
                            keyboardType: TextInputType.emailAddress,
                            showCursor: true,
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontSize: 14,
                                    color: ColorLibrary.textColor)),
                            textInputAction: TextInputAction.next,
                            cursorColor: Colors.black12,
                            cursorWidth: 1,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 196, 196, 196)),
                              hintText: "Masukkan email lengkap anda disini",
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text("Nomor Induk Kependudukan",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.roboto(
                              color: ColorLibrary.textColor,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.none,
                              fontSize: 16)),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border:
                                Border.all(width: 1, color: Colors.black12)),
                        child: Material(
                          color: const Color.fromARGB(35, 248, 248, 248),
                          borderRadius: BorderRadius.circular(10.0),
                          child: TextField(
                            controller: nik,
                            showCursor: true,
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontSize: 14,
                                    color: ColorLibrary.textColor)),
                            textInputAction: TextInputAction.next,
                            cursorColor: Colors.black12,
                            cursorWidth: 1,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 196, 196, 196)),
                              hintText:
                                  "Masukkan Nomor Induk Kependudukan anda disini",
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(
                                  16), // Batasi hingga 16 karakter
                            ],
                          ),
                        ),
                      ),
                      // const SizedBox(height: 20),
                      // Text("Tempat Lahir",
                      //     textAlign: TextAlign.left,
                      //     style: GoogleFonts.roboto(
                      //         color: ColorLibrary.textColor,
                      //         fontWeight: FontWeight.w700,
                      //         decoration: TextDecoration.none,
                      //         fontSize: 16)),
                      // const SizedBox(height: 10),
                      // Container(
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(10.0),
                      //       border:
                      //           Border.all(width: 1, color: Colors.black12)),
                      //   child: Material(
                      //     color: const Color.fromARGB(35, 248, 248, 248),
                      //     borderRadius: BorderRadius.circular(10.0),
                      //     child: TextField(
                      //       controller: ,
                      //       showCursor: true,
                      //       style: GoogleFonts.roboto(
                      //           textStyle: TextStyle(
                      //               fontSize: 14,
                      //               color: ColorLibrary.textColor)),
                      //       textInputAction: TextInputAction.next,
                      //       cursorColor: Colors.black12,
                      //       cursorWidth: 1,
                      //       decoration: const InputDecoration(
                      //         contentPadding: EdgeInsets.symmetric(
                      //             vertical: 5, horizontal: 15),
                      //         border: OutlineInputBorder(
                      //           borderRadius:
                      //               BorderRadius.all(Radius.circular(10.0)),
                      //           borderSide: BorderSide(
                      //             width: 0,
                      //             style: BorderStyle.none,
                      //           ),
                      //         ),
                      //         hintStyle: TextStyle(
                      //             color: Color.fromARGB(255, 196, 196, 196)),
                      //         hintText: "Masukkan tempat lahir anda disini",
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 20),
                      Text("Tanggal Lahir",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.roboto(
                              color: ColorLibrary.textColor,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.none,
                              fontSize: 16)),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () async {
                          selectDate(context);
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 13, horizontal: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                    width: 1, color: Colors.black12)),
                            child: TextField(
                              controller: birthdate,
                              decoration: InputDecoration(
                                labelText: 'Tanggal Lahir',
                                suffixIcon: Icon(Icons.calendar_today),
                              ),
                              readOnly: true,
                              onTap: () {
                                selectDate(context);
                              },
                            )),
                      ),
                      const SizedBox(height: 20),
                      Text("Agama",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.roboto(
                              color: ColorLibrary.textColor,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.none,
                              fontSize: 16)),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border:
                                Border.all(width: 1, color: Colors.black12)),
                        child: dropdownAgama(),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ))),
          Container(width: double.infinity, height: 1, color: Colors.black12),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                      onPressed: () {
                        moveToNextPage(0);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorLibrary.primary,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      // icon: const Icon(FontAwesomeIcons.angleRight),
                      label: Text(
                        "Selanjutnya",
                        style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w700)),
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  form2(context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
          body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Pendidikan Terakhir",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.roboto(
                            color: ColorLibrary.textColor,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.none,
                            fontSize: 16)),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        // pilihPendidikan();
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border:
                                  Border.all(width: 1, color: Colors.black12)),
                          child: dropdownEdukasi()),
                    ),
                    const SizedBox(height: 20),
                    Text("Pekerjaan",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.roboto(
                            color: ColorLibrary.textColor,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.none,
                            fontSize: 16)),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        // pilihPendidikan();
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border:
                                  Border.all(width: 1, color: Colors.black12)),
                          child: dropdownPekerjaan()),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(width: 1, color: Colors.black12)),
                      child: Material(
                        color: const Color.fromARGB(35, 248, 248, 248),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text("No. Telp/Seluler",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.roboto(
                            color: ColorLibrary.textColor,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.none,
                            fontSize: 16)),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(width: 1, color: Colors.black12)),
                      child: Material(
                        color: const Color.fromARGB(35, 248, 248, 248),
                        borderRadius: BorderRadius.circular(10.0),
                        child: TextField(
                          controller: phone,
                          showCursor: true,
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  fontSize: 14, color: ColorLibrary.textColor)),
                          textInputAction: TextInputAction.next,
                          cursorColor: ColorLibrary.grey,
                          cursorWidth: 1,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            // FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          ],
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 196, 196, 196)),
                            hintText: "Masukkan nomor telp/seluler anda disini",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ]),
            ),
          ),
          Container(width: double.infinity, height: 1, color: Colors.black12),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                      onPressed: () {
                        alertSign(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorLibrary.grey,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      // icon: const Icon(FontAwesomeIcons.angleLeft),
                      label: Text(
                        "Sebelumnya",
                        style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w700)),
                      )),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton.icon(
                      onPressed: () {
                        moveToNextPage(0);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorLibrary.primary,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      // icon: const Icon(FontAwesomeIcons.angleRight),
                      label: Text(
                        "Selanjutnya",
                        style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w700)),
                      )),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }

  form3(context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
          body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Alamat",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.roboto(
                            color: ColorLibrary.textColor,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.none,
                            fontSize: 16)),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 110,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                              topLeft: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0)),
                          border: Border.all(width: 1, color: Colors.black12)),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        physics: const ClampingScrollPhysics(),
                        child: TextField(
                          controller: addres,
                          showCursor: true,
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  fontSize: 14, color: ColorLibrary.textColor)),
                          textInputAction: TextInputAction.newline,
                          cursorColor: ColorLibrary.grey,
                          maxLines: 100,
                          cursorWidth: 1,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 196, 196, 196)),
                            hintText: "Masukkan alamat anda disini",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text("Provinsi",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.roboto(
                            color: ColorLibrary.textColor,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.none,
                            fontSize: 16)),
                    const SizedBox(height: 10),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 13, horizontal: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border:
                                Border.all(width: 1, color: Colors.black12)),
                        child: dropdownProvinsi(context)),
                    const SizedBox(height: 20),
                    Text("Kab/Kota",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.roboto(
                            color: ColorLibrary.textColor,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.none,
                            fontSize: 16)),
                    const SizedBox(height: 10),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 13, horizontal: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border:
                                Border.all(width: 1, color: Colors.black12)),
                        child: dropdownKota(context)),
                    const SizedBox(height: 20),
                    Text("Kecamatan",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.roboto(
                            color: ColorLibrary.textColor,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.none,
                            fontSize: 16)),
                    const SizedBox(height: 10),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 13, horizontal: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border:
                                Border.all(width: 1, color: Colors.black12)),
                        child: dropdownKecamatan(context)),
                    const SizedBox(height: 20),
                  ]),
            ),
          ),
          Container(width: double.infinity, height: 1, color: Colors.black12),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                      onPressed: () {
                        alertSign(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorLibrary.grey,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      // icon: const Icon(FontAwesomeIcons.angleLeft),
                      label: Text(
                        "Sebelumnya",
                        style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w700)),
                      )),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton.icon(
                      onPressed: () {
                        moveToNextPage(0);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorLibrary.primary,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      // icon: const Icon(FontAwesomeIcons.angleRight),
                      label: Text(
                        "Selanjutnya",
                        style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w700)),
                      )),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }

  form4(context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      alertCameraAndImageUser(context);
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height / 5,
                      width: MediaQuery.of(context).size.width / 2.5,
                      decoration: BoxDecoration(
                        color: ColorLibrary.primary,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Ambil Foto User",
                            style: GoogleFonts.robotoCondensed(
                                fontWeight: FontWeight.bold,
                                color: ColorLibrary.shadow),
                          ),
                          Icon(
                            Icons.camera_alt,
                            color: ColorLibrary.shadow,
                            size: MediaQuery.of(context).size.height / 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      alertCameraAndImageKtp(context);
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height / 5,
                      width: MediaQuery.of(context).size.width / 2.5,
                      decoration: BoxDecoration(
                        color: ColorLibrary.primary,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Ambil Foto ktp",
                            style: GoogleFonts.robotoCondensed(
                                fontWeight: FontWeight.bold,
                                color: ColorLibrary.shadow),
                          ),
                          Icon(
                            Icons.credit_card,
                            color: ColorLibrary.shadow,
                            size: MediaQuery.of(context).size.height / 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      height: 190,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: Colors.black12)),
                      child: Column(
                        children: [
                          Text("Foto Anda",
                              style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: ColorLibrary.textColor)),
                          const SizedBox(height: 10),
                          Expanded(
                              child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    width: 0.5, color: Colors.black12)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: userImage != null
                                  ? Image.file(
                                      File(userImage!.path),
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    )
                                  : userPhoto != null
                                      ? Image.file(
                                          File(userPhoto!.path),
                                          width: 200,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        )
                                      : Center(
                                          child: Text("Belum ada gambar"),
                                        ),
                            ),
                          ))
                        ],
                      ),
                    )),
                    const SizedBox(width: 10),
                    Expanded(
                        child: Container(
                      height: 190,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: Colors.black12)),
                      child: Column(
                        children: [
                          Text("Foto KTP",
                              style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: ColorLibrary.textColor)),
                          const SizedBox(height: 10),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      width: 0.5, color: Colors.black12)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: ktpImage != null
                                    ? Image.file(
                                        File(ktpImage!.path),
                                        width: 200,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      )
                                    : ktpPhoto != null
                                        ? Image.file(
                                            File(ktpPhoto!.path),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          )
                                        : Center(
                                            child: Text("Belum ada gambar"),
                                          ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ))
                  ],
                ),
              ),
              Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                          onPressed: () {
                            alertSign(context);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ColorLibrary.grey,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          // icon: const Icon(FontAwesomeIcons.angleLeft),
                          label: Text(
                            "Sebelumnya",
                            style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700)),
                          )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ElevatedButton.icon(
                          onPressed: () {
                            onRegisterButtonPressed(context);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ColorLibrary.primary,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          // icon: const Icon(FontAwesomeIcons.angleRight),
                          label: Text(
                            "Selanjutnya",
                            style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700)),
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  form5(context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
          body: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 15),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text("Informasi Pribadi",
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 20,
                                      color: ColorLibrary.primary)),
                            ),
                            const SizedBox(height: 15),
                            Container(
                                width: double.infinity,
                                height: 1,
                                color: Colors.black12),
                            const SizedBox(height: 15),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Nama Lengkap",
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 17,
                                          color: ColorLibrary.textColor)),
                                  const SizedBox(height: 8),
                                  name.text.isNotEmpty
                                      ? Text(name.text,
                                          style: GoogleFonts.roboto(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300,
                                              color: ColorLibrary.textColor))
                                      : Text("Nama anda wajib di isi..",
                                          style: GoogleFonts.roboto(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300,
                                              color: ColorLibrary.textColor)),
                                  const SizedBox(height: 20),
                                  Text("Nomor Induk Kependudukan",
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w700,
                                          color: ColorLibrary.textColor)),
                                  const SizedBox(height: 8),
                                  nik.text.isNotEmpty
                                      ? Text(nik.text,
                                          style: GoogleFonts.roboto(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300,
                                              color: ColorLibrary.textColor))
                                      : Text("NIK anda wajib di isi..",
                                          style: GoogleFonts.roboto(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300,
                                              color: ColorLibrary.textColor)),
                                  const SizedBox(height: 20),
                                  Text("Tanggal Lahir",
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w700,
                                          color: ColorLibrary.textColor)),
                                  const SizedBox(height: 8),
                                  birthdate.text.isNotEmpty
                                      ? Text(birthdate.text,
                                          style: GoogleFonts.roboto(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300,
                                              color: ColorLibrary.textColor))
                                      : Text(
                                          "Tanggal lahir anda wajib di isi..",
                                          style: GoogleFonts.roboto(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300,
                                              color: ColorLibrary.textColor)),
                                  const SizedBox(height: 20),
                                  Text("Agama",
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w700,
                                          color: ColorLibrary.textColor)),
                                  const SizedBox(height: 8),
                                  religion.text.isNotEmpty
                                      ? Text(religion.text,
                                          style: GoogleFonts.roboto(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300,
                                              color: ColorLibrary.textColor))
                                      : Text("Agama anda wajib di isi..",
                                          style: GoogleFonts.roboto(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300,
                                              color: ColorLibrary.textColor)),
                                  const SizedBox(height: 15),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      //---------------------------------------------------------------------------------------------
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.white,
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              const SizedBox(height: 15),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text("Pendidikan, dan Pekerjaan ",
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 20,
                                        color: ColorLibrary.primary)),
                              ),
                              const SizedBox(height: 15),
                              Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: Colors.black12),
                              const SizedBox(height: 15),
                              Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Pendidikan Terakhir",
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w700,
                                              color: ColorLibrary.textColor)),
                                      const SizedBox(height: 8),
                                      edukasi.text.isNotEmpty
                                          ? Text(edukasi.text,
                                              style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w300,
                                                  color:
                                                      ColorLibrary.textColor))
                                          : Text(
                                              "Pendidikan terakhir anda wajib di isi..",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w300,
                                                  color:
                                                      ColorLibrary.textColor)),
                                      const SizedBox(height: 20),
                                      Text("Pekerjaan",
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w700,
                                              color: ColorLibrary.textColor)),
                                      const SizedBox(height: 8),
                                      pekerjaan.text.isNotEmpty
                                          ? Text(pekerjaan.text,
                                              style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w300,
                                                  color:
                                                      ColorLibrary.textColor))
                                          : Text(
                                              "Pekerjaan anda wajib di isi..",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w300,
                                                  color:
                                                      ColorLibrary.textColor)),
                                      const SizedBox(height: 20),
                                      Text("No. Telp/Seluler",
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w700,
                                              color: ColorLibrary.textColor)),
                                      const SizedBox(height: 8),
                                      phone.text.isNotEmpty
                                          ? Text(phone.text,
                                              style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w300,
                                                  color:
                                                      ColorLibrary.textColor))
                                          : Text(
                                              "No telp/Seluler anda wajib di isi..",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w300,
                                                  color:
                                                      ColorLibrary.textColor)),
                                      const SizedBox(height: 15),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      //---------------------------------------------------------------------------------------------
                      Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Colors.white,
                          child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  const SizedBox(height: 15),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text("Wilayah, dan Alamat",
                                        style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 20,
                                            color: ColorLibrary.primary)),
                                  ),
                                  const SizedBox(height: 15),
                                  Container(
                                      width: double.infinity,
                                      height: 1,
                                      color: Colors.black12),
                                  const SizedBox(height: 15),
                                  Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Alamat",
                                              style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                      ColorLibrary.textColor)),
                                          const SizedBox(height: 8),
                                          addres.text.isNotEmpty
                                              ? Text(addres.text,
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: ColorLibrary
                                                          .textColor))
                                              : Text(
                                                  "Alamat anda wajib di isi..",
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: ColorLibrary
                                                          .textColor)),
                                          const SizedBox(height: 20),
                                          Text("Provinsi",
                                              style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                      ColorLibrary.textColor)),
                                          const SizedBox(height: 8),
                                          province.text.isNotEmpty
                                              ? Text(province.text,
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: ColorLibrary
                                                          .textColor))
                                              : Text("Povinsi wajib di isi..",
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: ColorLibrary
                                                          .textColor)),
                                          const SizedBox(height: 20),
                                          Text("Kab/Kota",
                                              style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                      ColorLibrary.textColor)),
                                          const SizedBox(height: 8),
                                          district.text.isNotEmpty
                                              ? Text(district.text,
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: ColorLibrary
                                                          .textColor))
                                              : Text("Kab/Kota wajib di isi..",
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: ColorLibrary
                                                          .textColor)),
                                          const SizedBox(height: 20),
                                          Text("Kecamatan",
                                              style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                      ColorLibrary.textColor)),
                                          const SizedBox(height: 8),
                                          regency.text.isNotEmpty
                                              ? Text(regency.text,
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: ColorLibrary
                                                          .textColor))
                                              : Text("Kecamatan wajib di isi..",
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: ColorLibrary
                                                          .textColor)),
                                          const SizedBox(height: 15),
                                        ],
                                      ))
                                ],
                              ))),

                      //---------------------------------------------------------------------------------------------
                      const SizedBox(height: 20),
                      Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Colors.white,
                          child: SizedBox(
                              width: double.infinity,
                              child: Column(children: [
                                const SizedBox(height: 15),
                                Text("Berkas dan Keterangan",
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 20,
                                        color: ColorLibrary.primary)),
                                const SizedBox(height: 15),
                                Container(
                                    width: double.infinity,
                                    height: 1,
                                    color: Colors.black12),
                                const SizedBox(height: 15),
                                Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: Container(
                                                height: 190,
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Colors.black12)),
                                                child: Column(
                                                  children: [
                                                    Text("Foto Anda",
                                                        style: GoogleFonts.roboto(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: ColorLibrary
                                                                .textColor)),
                                                    const SizedBox(height: 10),
                                                    Expanded(
                                                        child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          border: Border.all(
                                                              width: 0.5,
                                                              color: Colors
                                                                  .black12)),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        child: userImage != null
                                                            ? Image.file(
                                                                File(userImage!
                                                                    .path),
                                                                width: 200,
                                                                height: 200,
                                                                fit: BoxFit
                                                                    .cover,
                                                              )
                                                            : userPhoto != null
                                                                ? Image.file(
                                                                    File(userPhoto!
                                                                        .path),
                                                                    width: 200,
                                                                    height: 200,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  )
                                                                : Center(
                                                                    child: Text(
                                                                        "Belum ada gambar"),
                                                                  ),
                                                      ),
                                                    ))
                                                  ],
                                                ),
                                              )),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                  child: Container(
                                                height: 190,
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Colors.black12)),
                                                child: Column(
                                                  children: [
                                                    Text("Foto KTP",
                                                        style: GoogleFonts.roboto(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: ColorLibrary
                                                                .textColor)),
                                                    const SizedBox(height: 10),
                                                    Expanded(
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            border: Border.all(
                                                                width: 0.5,
                                                                color: Colors
                                                                    .black12)),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          child: ktpImage !=
                                                                  null
                                                              ? Image.file(
                                                                  File(ktpImage!
                                                                      .path),
                                                                  width: 200,
                                                                  height: 200,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                )
                                                              : userPhoto !=
                                                                      null
                                                                  ? Image.file(
                                                                      File(ktpPhoto!
                                                                          .path),
                                                                      width:
                                                                          200,
                                                                      height:
                                                                          200,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    )
                                                                  : Center(
                                                                      child: Text(
                                                                          "Belum ada gambar"),
                                                                    ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ))
                                            ],
                                          ),
                                          const SizedBox(height: 20),
                                          Text("Keterangan",
                                              style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                      ColorLibrary.textColor)),
                                          const SizedBox(height: 10),
                                          Text("Saya anggota baru",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w300,
                                                  color:
                                                      ColorLibrary.textColor)),
                                          const SizedBox(height: 15),
                                        ]))
                              ]))),
                    ]),
              ),
            ),
          ),
          Container(width: double.infinity, height: 1, color: Colors.black12),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                      onPressed: () {
                        alertSign(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorLibrary.grey,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      // icon: const Icon(FontAwesomeIcons.angleLeft),
                      label: Text(
                        "Sebelumnya",
                        style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w700)),
                      )),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton.icon(
                      onPressed: () {
                        registerUser(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorLibrary.primary,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      // icon: const Icon(FontAwesomeIcons.angleRight),
                      label: Text(
                        "Selanjutnya",
                        style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w700)),
                      )),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
