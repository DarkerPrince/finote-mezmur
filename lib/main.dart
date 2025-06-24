
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'Views/Listing-Page.dart';
import 'package:finotemezmur/MainScreen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';


void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  void toggleTheme(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finote Mezmur',
       themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,

      debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'FinotFont',
          brightness: Brightness.light,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.light,
            primary: Colors.blueAccent,
            secondary: Colors.amber,
          ),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          fontFamily: 'FinotFont',
          brightness: Brightness.dark,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.dark,
            primary: Colors.amber,
            secondary: Colors.blue,
          ),
          useMaterial3: true,
        ),
      home: AnimatedSplashScreen(
          duration: 8000,
          splashIconSize: 200,
          splash: 'assets/Image/logoSplash.gif',
          nextScreen: MainScreen(onThemeToggle:toggleTheme,isDarkMode:isDarkMode),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Color(0xFFFCFCFA)
      ),
    );
  }
}
