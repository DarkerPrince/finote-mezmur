
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'Views/Listing-Page.dart';
import 'package:finotemezmur/MainScreen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';


void main() {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finote Mezmur',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        splashColor: Colors.white,
        useMaterial3: true,
      ),
      home: AnimatedSplashScreen(
          duration: 1000,
          splash: 'assets/Image/blueLogo.png',
          nextScreen: MainScreen(),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.white,
      ),
    );
  }
}
