import 'package:flutter/material.dart';
import 'package:paguyuban/qr%20member/qr_members.dart';
import 'package:paguyuban/views/akun/login.dart';
import 'package:paguyuban/views/akun/sign_up.dart';
import 'package:paguyuban/views/dashboard/profil_anda/edit_nama.dart';
import 'package:paguyuban/views/dashboard/profil_anda/qr_profil.dart';
import 'package:paguyuban/views/menu_utama/belanja/asosiatif.dart';
import 'package:paguyuban/views/menu_utama/belanja/belanja.dart';
import 'package:paguyuban/views/dashboard/dashboard.dart';
import 'package:paguyuban/views/dashboard/home/home.dart';
import 'package:paguyuban/views/dashboard/profil_anda/profil.dart';
import 'package:paguyuban/views/menu_utama/belanja/coffee_shop/coffee_shop.dart';
import 'package:paguyuban/views/menu_utama/belanja/coffee_shop/detail_coffee.dart';
import 'package:paguyuban/views/menu_utama/belanja/coffee_shop/keranjang_coffee.dart';
import 'package:paguyuban/views/menu_utama/belanja/market_place/market_place.dart';
import 'package:paguyuban/views/menu_utama/berita_terkini/berita_terkini.dart';
import 'package:paguyuban/views/menu_utama/berita_terkini/detail_berita_terkini.dart';
import 'package:paguyuban/views/menu_utama/fasilitas_terdekat/fasillitas.dart';
import 'package:paguyuban/views/menu_utama/fasilitas_terdekat/maps.dart';
import 'package:paguyuban/views/menu_utama/infografis/detail_infografis.dart';
import 'package:paguyuban/views/menu_utama/infografis/infografis.dart';
import 'package:paguyuban/views/menu_utama/kepengurusan/kepengurusan.dart';
import 'package:paguyuban/views/menu_utama/perpustakaan/perpustakaan.dart';
import 'package:paguyuban/views/menu_utama/unit_paguyuban/unit_paguyuban.dart';

import '../views/splash_screen/splash_screen.dart';

const String initRoute = "/";
const String loginRoute = "/Login";
const String signUpRoute = "/signUp";
const String homeRoute = "/home";
const String dashboardRoute = "/dashboard";
const String beritaTerkiniRoute = "/beritaTerkini";
const String perpustakaanRoute = "/perpustakaan";
const String mapsRoute = "/maps";
const String fasilitasRoute = "/fasilitas";
const String profilRoute = "/profil";
const String detailberitaRoute = "/listBerita";
const String kepengurusanRoute = "/kepengurusan";
const String infografisRoute = "/infografis";
const String unitPaguyubanRoute = "/unitPaguyuban";
const String belanjaRoute = "/belanja";
const String asosiatifRoute = "/asosiatif";
const String marketPlaceRoute = "/marketPlace";
const String coffeeShopRoute = "/coffeShop";
const String keranjangCoffeeRoute = "/keranjangCoffee";
const String detailCoffeeRoute = "/detailCoffee";
const String qrProfilRoute = "/qrProfil";
const String detailInfografisRoute = "/detailInfografis";
const String generateQrRoute = "generateQr";
const String editNamaRoute = "editNama";

class Routes {
  static Route<dynamic> generateRoute(RouteSettings sett) {
    // untuk menangkap argument yang dikirim
    // final dynamic arguments = sett.arguments;

    switch (sett.name) {
      case initRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreenPage());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case signUpRoute:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case dashboardRoute:
        return MaterialPageRoute(builder: (_) => const DashboardPage());
      case beritaTerkiniRoute:
        return MaterialPageRoute(builder: (_) => const BeritaTerkiniPage());
      case perpustakaanRoute:
        return MaterialPageRoute(builder: (_) => const PerpustakaanPage());
      case mapsRoute:
        return MaterialPageRoute(builder: (_) => const MapsPage());
      case fasilitasRoute:
        return MaterialPageRoute(builder: (_) => const FasilitasPage());
      case profilRoute:
        return MaterialPageRoute(builder: (_) => const ProfilPage());
      case detailberitaRoute:
        return MaterialPageRoute(
            builder: (_) => const DetailBeritaTerkiniPage());
      case kepengurusanRoute:
        return MaterialPageRoute(builder: (_) => KepengurusanPage());
      case infografisRoute:
        return MaterialPageRoute(builder: (_) => const InfografisPage());
      case unitPaguyubanRoute:
        return MaterialPageRoute(builder: (_) => const UnitPaguyubanPage());
      case belanjaRoute:
        return MaterialPageRoute(builder: (_) => const BelanjaPage());
      case asosiatifRoute:
        return MaterialPageRoute(builder: (_) => const AsosiatifPage());
      case marketPlaceRoute:
        return MaterialPageRoute(builder: (_) => const MarketPlacePage());
      case coffeeShopRoute:
        return MaterialPageRoute(builder: (_) => const CoffeeShopPage());
      case keranjangCoffeeRoute:
        return MaterialPageRoute(builder: (_) => const KeranjangCoffeePage());
      case detailCoffeeRoute:
        return MaterialPageRoute(builder: (_) => const DetailCoffeePage());
      case qrProfilRoute:
        return MaterialPageRoute(builder: (_) => const QrProfilpage());
      case detailCoffeeRoute:
        return MaterialPageRoute(builder: (_) => const DetailInfografisPage());
      case detailInfografisRoute:
        return MaterialPageRoute(builder: (_) => const DetailInfografisPage());
      case generateQrRoute:
        return MaterialPageRoute(builder: (_) => const QrMembers());
      case editNamaRoute:
        return MaterialPageRoute(builder: (_) => const EditNama());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                '404 Not Found !! \n${sett.name}',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
    }
  }
}
