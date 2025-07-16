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
      extendBody: true,
      extendBodyBehindAppBar: true,// So nav bar can float
      appBar: AppBar(
        forceMaterialTransparency: true,
        actions: [
          IconButton(
            icon: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.4), // background color you want
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(8), // padding inside the circle
              child: Icon(
                Icons.search,
                color: Colors.white, // icon color
              ),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => SearchMezmurPage()));
            },
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BottomNavigationBar(
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? Color(0xFF212121)
                : Theme.of(context).colorScheme.primary,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            elevation: 16,
            selectedItemColor: Theme.of(context).brightness == Brightness.dark? Theme.of(context).colorScheme.primary:Colors.white,
            currentIndex: _currentIndex,
            unselectedItemColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            selectedIconTheme: IconThemeData(color:Theme.of(context).brightness == Brightness.dark? Theme.of(context).colorScheme.primary:Colors.white),
            showSelectedLabels: true,
            showUnselectedLabels: false,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.music_note_outlined),
                activeIcon: Icon(Icons.music_note),
                label: 'ፍኖት',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                activeIcon: Icon(Icons.settings),
                label: 'ቅንብሮች',
              ),
            ],
          ),
        ),
      ),
    );
  }
}