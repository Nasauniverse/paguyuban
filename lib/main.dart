import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:paguyuban/provider/akun_view_model.dart';
import 'package:paguyuban/provider/bagian_view_model.dart';
import 'package:paguyuban/provider/balanja_view_model.dart';
import 'package:paguyuban/provider/berita_view_model.dart';
import 'package:paguyuban/provider/coffee_view_model.dart';
import 'package:paguyuban/provider/generate_qr_view_model.dart';
import 'package:paguyuban/provider/home_view_model.dart';
import 'package:paguyuban/provider/infografis_view_model.dart';
import 'package:paguyuban/provider/jenis_usaha_view_model.dart';
import 'package:paguyuban/provider/kepengurusan_view_model.dart';
import 'package:paguyuban/provider/maps_view_model.dart';
import 'package:paguyuban/provider/market_place_view_model.dart';
import 'package:paguyuban/provider/perpustakaan_view_model.dart';
import 'package:paguyuban/provider/profil_view_model.dart';
import 'package:paguyuban/provider/splash_screen_view_model.dart';
import 'package:paguyuban/provider/unit_paguyuban_view_model.dart';
import 'package:paguyuban/routes/routes.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('id_ID', null).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeViewModel>(
            create: (context) => HomeViewModel()),
        ChangeNotifierProvider<AkunViewModel>(
            create: (context) => AkunViewModel()),
        ChangeNotifierProvider<SplashScreenViewModel>(
            create: (context) => SplashScreenViewModel()),
        ChangeNotifierProvider<MapsViewModel>(
            create: (context) => MapsViewModel()),
        ChangeNotifierProvider<BeritaViewModel>(
            create: (context) => BeritaViewModel()),
        ChangeNotifierProvider<PerpustakaanViewModel>(
            create: (context) => PerpustakaanViewModel()),
        ChangeNotifierProvider<InfografisViewModel>(
            create: (context) => InfografisViewModel()),
        ChangeNotifierProvider<UnitPaguyubanViewModel>(
            create: (context) => UnitPaguyubanViewModel()),
        ChangeNotifierProvider<BelanjaViewModel>(
            create: (context) => BelanjaViewModel()),
        ChangeNotifierProvider<CoffeeViewModel>(
            create: (context) => CoffeeViewModel()),
        ChangeNotifierProvider<ProfilViewModel>(
            create: (context) => ProfilViewModel()),
        ChangeNotifierProvider<MarketPlaceViewModel>(
            create: (context) => MarketPlaceViewModel()),
        ChangeNotifierProvider<KepengurusanViewModel>(
            create: (context) => KepengurusanViewModel()),
        ChangeNotifierProvider<UnitPaguyubanViewModel>(
            create: (context) => UnitPaguyubanViewModel()),
        ChangeNotifierProvider<GenerateQrViewModel>(
            create: (context) => GenerateQrViewModel()),
        ChangeNotifierProvider<BagianViewModel>(
            create: (context) => BagianViewModel()),
        ChangeNotifierProvider<JenisUsahaViewModel>(
            create: (context) => JenisUsahaViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Paguyuban',
        onGenerateRoute: Routes.generateRoute,
        initialRoute: initRoute,
        builder: EasyLoading.init(),
      ),
    );
  }
}
