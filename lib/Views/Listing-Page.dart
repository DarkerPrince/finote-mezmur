import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:finotemezmur/Views/Lyrics-Show.dart';
import 'package:finotemezmur/Views/Search-Page.dart';
import 'package:finotemezmur/CONSTANT/constant.dart';
import 'package:finotemezmur/Model/mezmur.dart';
import 'package:finotemezmur/Model/Lyrics.dart';
import 'package:finotemezmur/Model/ShortLyrics.dart';
import 'package:finotemezmur/Model/LongLyrics.dart';
import 'package:finotemezmur/Model/subCategory.dart';

class ListPage extends StatefulWidget {
  final List<SubCategory> tabs;
  final String categoryName;
  const ListPage({super.key, required this.tabs,required this.categoryName});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage>
    with SingleTickerProviderStateMixin {
  bool _showSheet = false;
  late Mezmur _selectedMezmur;
  double _sheetSize = 1;
  final DraggableScrollableController _controller =
      DraggableScrollableController();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    loadJson();
    _tabController = TabController(length: widget.tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  DisplayVerse(String Verse) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Wrap(
        children: [
          Text(Verse,
              textAlign: TextAlign.center,
              softWrap: true,
              style: TextStyle(
                fontSize: 24,
              ))
        ],
      ),
    );
  }

  TranslationDisplay(String Verse) {
    return Container(
      color: Colors.blue,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Translation:-",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          Text(Verse,
              textAlign: TextAlign.center,
              softWrap: true,
              style: TextStyle(
                fontSize: 24,
              ))
        ],
      ),
    );
  }

  List<Mezmur> _data = [];

  Future<void> loadJson() async {
    final String response =
        await rootBundle.loadString('assets/Mezmur/kidanmhret.json');
    final Map<String, dynamic> jsonData = json.decode(response);

    List<Mezmur> mezmurList = (jsonData['song'] as List<dynamic>)
        .map((mezmur) => Mezmur.fromJson(mezmur))
        .toList();

    setState(() {
      _data = mezmurList;
    });
  }

  LyricsDisplaySheet() {
    if (_showSheet) {
      return DraggableScrollableSheet(
        initialChildSize: _sheetSize, // Starts small like a mini player
        minChildSize: 0.14,
        controller: _controller, // Minimum size when collapsed
        maxChildSize: 1, // Maximum height when expanded
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                ),
              ],
            ),
            child: ListView(
              controller: scrollController,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text(_selectedMezmur.title ?? ""),
                  subtitle: Text(_selectedMezmur.singer ?? ""),
                  trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          _showSheet = false;
                        });
                      },
                      icon: Icon(Icons.close)),
                ),
                Divider(),
                _selectedMezmur.songLyrics.isShortSong
                    ? ShortMezmur(_selectedMezmur.songLyrics.shortLyrics)
                    : LongMezmur(_selectedMezmur.songLyrics.longLyrics)
                // Add more content as needed
              ],
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }

  ShortMezmur(ShortLyrics shortMezmurLyrics) {
    return Column(
      children: [
        DisplayVerse(shortMezmurLyrics.lyrics ?? ""),
        TranslationDisplay(shortMezmurLyrics.translation ?? "")
      ],
    );
  }

  LongMezmur(LongLyrics longMezmurLyrics) {
    return Container(
        child: Column(
      children: (longMezmurLyrics.verse as List)
          .map((verse) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: DisplayVerse(verse),
              ))
          .toList(),
    ));
  }

  void _handleItemTap(Mezmur mezmur, double size) {
    if (_showSheet && _selectedMezmur.title == mezmur.title) {
      // If same item is tapped again, expand to full size
      _controller.animateTo(
        1.0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      setState(() {
        _selectedMezmur = mezmur;
        _sheetSize = size;
        _showSheet = true;
      });
    }
  }

  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.categoryName),
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: widget.tabs.map(
              (tabName){
                print(tabName);
                return Tab(text: tabName.title ?? 'Untitled');
              },
            ).toList(),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: widget.tabs
              .map((tabName) => Center(
                      child: Stack(
                    children: [
                      ListView.builder(
                        itemCount: _data.length,
                        itemBuilder: (context, index) {
                          final Mezmur item = _data[index];
                          return ListTile(
                            title: Text(item.title ?? ""),
                            leading: Icon(Icons.music_note),
                            subtitle: Text(item.singer ?? ""),
                            trailing: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isFavorite = !_isFavorite;
                                });
                              },
                              icon: Icon(
                                _isFavorite
                                    ? Icons.church
                                    : Icons.church_outlined,
                                color: _isFavorite ? Colors.red : Colors.grey,
                              ),
                            ),
                            onTap: () => _handleItemTap(item, 1),
                          );
                        },
                      ),
                      LyricsDisplaySheet(), // Your bottom sheet widget
                    ],
                  )))
              .toList(),
        ),
      ),
    );
  }
}
