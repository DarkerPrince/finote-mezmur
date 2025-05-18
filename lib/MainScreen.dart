import 'package:flutter/material.dart';
import 'package:finotemezmur/Views/Home-Page.dart';
import 'package:finotemezmur/Views/Fav-Page.dart';
import 'package:finotemezmur/Views/Search-Page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // List of pages to switch between
  final List<Widget> _pages = [
    HomePage(),
    Container(), // Create this page or use any placeholder
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: Text("ፍኖተ ጽድቅ መዝሙር",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 32),),
      forceMaterialTransparency: true,
      actions: [IconButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchMezmurPage()));
      }, icon: Icon(Icons.search))],
      ),
      body: _pages[_currentIndex], // Show the selected page
      bottomNavigationBar: BottomNavigationBar(
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