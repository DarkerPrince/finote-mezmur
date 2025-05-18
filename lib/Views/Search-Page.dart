import 'package:flutter/material.dart';
import 'package:finotemezmur/Model/mezmur.dart';
import 'package:finotemezmur/Model/ShortLyrics.dart';
import 'package:finotemezmur/Model/LongLyrics.dart';
import 'package:finotemezmur/Views/Listing-Page.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:finotemezmur/Model/category.dart';


class SearchMezmurPage extends StatefulWidget {
  const SearchMezmurPage({super.key});

  @override
  State<SearchMezmurPage> createState() => _SearchMezmurPageState();
}

class _SearchMezmurPageState extends State<SearchMezmurPage> {

  List<Mezmur> _allMezmur = [];      // Full list loaded from JSON
  List<Mezmur> _filteredMezmur = []; // Filtered based on search
  TextEditingController _searchController = TextEditingController();


  void _performSearch(String query) {
    setState(() {
      _filteredMezmur = searchMezmur(_allMezmur, query);
    });
  }

  List<Mezmur> searchMezmur(List<Mezmur> allMezmur, String query) {
    final lowerQuery = query.toLowerCase();

    return allMezmur.where((mezmur) {
      final title = mezmur.title?.toLowerCase() ?? '';
      final singer = mezmur.singer?.toLowerCase() ?? '';

      final shortLyrics = mezmur.songLyrics.shortLyrics.lyrics?.toLowerCase() ?? '';
      final chorus = mezmur.songLyrics.longLyrics.chorus?.toLowerCase() ?? '';
      final verses = mezmur.songLyrics.longLyrics.verse
          ?.map((line) => line.toLowerCase())
          .join(',') ?? '';

      final about = mezmur.about?.map((e) => e.toLowerCase()).join(',') ?? '';
      final minorHolidays = mezmur.minorHolidays?.map((e) => e.toLowerCase()).join(',') ?? '';
      final mainHolidays = mezmur.mainHolidays?.map((e) => e.toLowerCase()).join(',') ?? '';
      final angels = mezmur.angels?.map((e) => e.toLowerCase()).join(',') ?? '';

      return title.contains(lowerQuery) ||
          singer.contains(lowerQuery) ||
          shortLyrics.contains(lowerQuery) ||
          chorus.contains(lowerQuery) ||
          verses.contains(lowerQuery) ||
          about.contains(lowerQuery) ||
          minorHolidays.contains(lowerQuery) ||
          mainHolidays.contains(lowerQuery) ||
          angels.contains(lowerQuery);
    }).toList();
  }



  bool _showSheet = false;
  late Mezmur _selectedMezmur;
  double _sheetSize = 1;
  final DraggableScrollableController _controller =
  DraggableScrollableController();


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

  TranslationDisplay(String Verse) {
    return Verse==""?Container():Container(
      color: Colors.blue,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "ትርጉም:-",
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



  Future<void> loadJson() async {

    final String response =
    await rootBundle.loadString('assets/Mezmur/kidanmhret.json');
    final Map<String, dynamic> jsonData = json.decode(response);

    List<Mezmur> allMezmur = (jsonData['song'] as List<dynamic>)
        .map((mezmur) => Mezmur.fromJson(mezmur))
        .toList();

    setState(() {
      _allMezmur = allMezmur;
      _filteredMezmur = allMezmur;
    });
  }



  @override
  void initState() {
    super.initState();
    loadJson(); // load your _allMezmur here
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  SingerInfoDisplay(Mezmur item){
    if(item.singer == "ሌላ ዘማሪ" ||item.singer == "ሌላ"){
      return Text(item.singerOther??"");
    }
    return Text(item.singer??"");
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('መዝሙር ፍለጋ')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _performSearch,
              decoration: InputDecoration(
                hintText: 'የመዝሙሩን ርዕስ ፣ ዘማሪ ወይም በዓል ይፈልጉ...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          Expanded(
            child: _filteredMezmur.isEmpty
                ? Center(child: Text('መዝሙር አልተገኘም'))
                : Center(child:
                  Stack(children: [
                ListView.builder(
                  itemCount: _filteredMezmur.length,
                  itemBuilder: (context, index) {
                    final mezmur = _filteredMezmur[index];
                    return ListTile(
                      title: Text(mezmur.title),
                      leading: Icon(Icons.music_note),
                      subtitle: SingerInfoDisplay(mezmur),
                      onTap: () => _handleItemTap(mezmur, 1),
                    );
                  },
                ),
                    LyricsDisplaySheet(),
              ],)
              ,)
          ),
        ],
      ),
    );
  }

}
