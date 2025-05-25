import 'package:flutter/material.dart';
import 'package:finotemezmur/Views/Home-Page.dart';
import 'package:finotemezmur/Views/Fav-Page.dart';
import 'package:finotemezmur/Views/Search-Page.dart';
import 'package:finotemezmur/Views/settings.dart';

class MainScreen extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onThemeToggle;

  const MainScreen({required this.onThemeToggle,required this.isDarkMode, super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  // bool isDarkMode = false;

  // void toggleTheme(bool value) {
  //   setState(() {
  //     isDarkMode = value;
  //   });
  // }

  // List of pages to switch between


  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomePage(isDarkMode: widget.isDarkMode),
      SettingsPage(
        isDarkMode: widget.isDarkMode,
        onThemeToggle: widget.onThemeToggle,
      ), // Create this page or use any placeholder
    ];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
      forceMaterialTransparency: true,
      actions: [IconButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchMezmurPage()));
      }, icon: Icon(Icons.search))],
      ),
      body: _pages[_currentIndex], // Show the selected page
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).colorScheme.primary,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note_outlined),
            activeIcon: Icon(Icons.music_note),
            label: 'Finote',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}