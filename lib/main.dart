import 'package:finotemezmur/Views/Home-Page.dart';
import 'package:flutter/material.dart';

import 'Views/Listing-Page.dart';

void main() {
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
        useMaterial3: true,
      ),
      home: HomePage()
    );
  }
}
