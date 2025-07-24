import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:paguyuban/models/lokasi.dart';
import 'package:paguyuban/models/member.dart';
import 'package:paguyuban/others/colors.dart';
import 'package:paguyuban/services/api.dart';
import 'package:paguyuban/services/map_utils.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;

import 'package:shared_preferences/shared_preferences.dart';

class MapsViewModel extends ChangeNotifier {
  List<Datum> dataMembers = [];
  ResMembers resMembers = ResMembers();
  Member member = Member();
  MapController mapController = MapController();
  bool isLoading = false;
  bool _isBottomSheetOpen = false;
  bool isBottomSheetOpen = false;
  // bool _isBottomSheetOpen = false;

  TileLayer get openStreetMapTileLayer => TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        userAgentPackageName: 'dev.fleaflet.flutter_map.example',
      );
//pemanggilan data untuk maps
  dataMember() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    isLoading = true;
    notifyListeners();
    try {
      http.Response hasil = await http.get(
        Uri.parse("${Api.server}api/member/location"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      );

      dev.log("Status code: ${hasil.statusCode}");
      if (hasil.statusCode == 200) {
        dev.log("Data member berhasil tampil");
        // dev.log(hasil.body);
        resMembers = resMembersFromJson(hasil.body); 

        dataMembers = resMembers.data ?? [];
        if (dataMembers.isNotEmpty) {
          for (var datum in dataMembers) {
            double? lat = datum.lat;
            double? long = datum.long;
            // dev.log("$lat $long");
            for (var iniMember in datum.members ?? []) {
              String? phone = iniMember.phone;
              String? name = iniMember.name;
              String? nik = iniMember.nik;

              // dev.log("Nama Anggota: $name, NIK Anggota: $nik, Nomor telepon: $phone, Lat: $lat, Long: $long");
            }
          }
        } else {
          dev.log("Data member kosong");
        }
      } else {
        dev.log("Gagal mengambil data: Status code ${hasil.statusCode}");
      }
    } catch (e, stackTrace) {
      dev.log("Terjadi error: $e");
      dev.log("Stack trace: $stackTrace");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  String formatPhoneNumber(String? phone) {
    if (phone == null) return 'Nomor tidak tersedia';

    // Menghapus spasi dan tanda minus
    String cleanedPhone = phone.replaceAll(' ', '').replaceAll('-', '');

    // Mengganti awalan
    if (cleanedPhone.startsWith('+62')) {
      cleanedPhone = cleanedPhone.replaceFirst('+62', '62');
    } else if (cleanedPhone.startsWith('0')) {
      cleanedPhone = cleanedPhone.replaceFirst('0', '62');
    }

    return cleanedPhone;
  }

  fetchAddress(double latitude, double longitude) async {
    try {
      final response = await http
          .get(Uri.parse(
              'https://nominatim.openstreetmap.org/reverse?lat=$latitude&lon=$longitude&format=json'))
          .timeout(Duration(seconds: 3));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['display_name'];
      } else {
        print('Failed to load address');
        return null;
      }
    } catch (e) {
      print('Error fetching address: $e');
      return null;
    }
  }

//design tampilan maps
  bottomSheetMaps(BuildContext context, Datum dataMember, String? address) {
    // Cek apakah bottom sheet sudah terbuka
    if (_isBottomSheetOpen) return;

    _isBottomSheetOpen = true; // Set flag menjadi true

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          margin: EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              ColorLibrary.primarySuperDark,
              ColorLibrary.primaryLow,
              ColorLibrary.primary,
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  'Alamat: ${address ?? 'Alamat tidak ditemukan'}',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: ColorLibrary.shadow,
                  ),
                ),
                Container(
                  color: Colors.white,
                  height: 2,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 10),
                ),
                Column(
                  children: [
                    Text(
                      'Kecamatan: ${dataMember.name}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: ColorLibrary.shadow,
                      ),
                    ),
                    Text(
                      'Member: ${dataMembers.first.membersCount}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: ColorLibrary.shadow,
                      ),
                    ),
                  ],
                ),
                Container(
                  color: Colors.white,
                  height: 2,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 10),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_pin,
                        size: 14,
                        color: ColorLibrary.shadow,
                      ),
                      SizedBox(width: 8),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              'Latitude = ${dataMembers.first.lat}',
                              maxLines: 1,
                              maxFontSize: 14,
                              style: TextStyle(color: ColorLibrary.shadow),
                            ),
                            SizedBox(height: 4),
                            AutoSizeText(
                              'Longitude = ${dataMembers.first.long}',
                              maxLines: 1,
                              maxFontSize: 14,
                              style: TextStyle(color: ColorLibrary.shadow),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  height: 2,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 10),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    child: ElevatedButton(
                      onPressed: () {
                        MapUtils.openMap(
                            dataMembers.first.lat!, dataMembers.first.long!);
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            'buka Google Maps',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).whenComplete(() {
      // Reset flag ketika bottom sheet ditutup
      _isBottomSheetOpen = false;
    });
  }
}
