import 'package:finotemezmur/Views/onBoardingScreen.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Views/Listing-Page.dart';
import 'package:finotemezmur/MainScreen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  final prefs = await SharedPreferences.getInstance();
  final bool? seenOnboard = prefs.getBool('seenOnboard');

  runApp(MyApp(
    showOnboarding: seenOnboard != true,
  ));
}

class MyApp extends StatefulWidget {
  final bool showOnboarding;

  const MyApp({super.key, required this.showOnboarding});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;
  bool showSplash = false; // Only show once

  void toggleTheme(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  @override
  void initState() {
    super.initState();

    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    isDarkMode = brightness == Brightness.dark;
    showSplash = widget.showOnboarding;
    FlutterNativeSplash.remove();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finote Mezmur App',
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // fontFamily: 'NokiaPureHeadline',
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
        // fontFamily: 'NokiaPureHeadline',
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
          primary: Colors.amber,
          secondary: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: Builder(
        builder: (context) {
          if (widget.showOnboarding) {
            return OnboardingScreen(
              onFinish: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('seenOnboard', true);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MainScreen(
                      onThemeToggle: toggleTheme,
                      isDarkMode: isDarkMode,
                    ),
                  ),
                );
              },
            );
          } else {
            return MainScreen(
              onThemeToggle: toggleTheme,
              isDarkMode: isDarkMode,
            );
          }
        },
      ),
    );
  }
}
