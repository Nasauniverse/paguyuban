import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:paguyuban/provider/splash_screen_view_model.dart';
import 'package:paguyuban/views/akun/login.dart';
import 'package:provider/provider.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<SplashScreenViewModel>(context, listen: false).initSplash(
      context,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/backwhite.png"),
                  fit: BoxFit.cover)),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                color: const Color.fromARGB(170, 0, 0, 0),
              ),
              AnimatedSplashScreen(
                  duration: 3000,
                  backgroundColor: Colors.transparent,
                  splash: Image.asset("assets/images/logo.png"),
                  splashIconSize: 150,
                  nextScreen: LoginPage(),
                  splashTransition: SplashTransition.fadeTransition),
            ],
          ),
        ),
      ),
    );
  }
}
