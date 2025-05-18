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
import 'package:finotemezmur/Model/category.dart';

class ListPage extends StatefulWidget {
  final Category category;
  const ListPage({super.key,required this.category});

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
    _tabController = TabController(length: widget.category.subCategories.length, vsync: this);
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

  List<Mezmur> _data = [];

  List<Mezmur> filteredMezmur=[];


  filterMezmurList(List<Mezmur> allMezmur){
    List<Mezmur> filteredMezmur;

    switch (widget.category.title) {
    // Special case: Trinity
      case "Kidest Silase":


        filteredMezmur = allMezmur.where((mezmur) =>
        (mezmur.trinitySong["Tir"] == true) || (mezmur.trinitySong["Hamle"] == true) || (mezmur.trinitySong["Mesgana"] == true)
        ).toList();

        setState(() {
          _data = filteredMezmur;
        });
        break;

      case "Kidest Kidanmhret":

        filteredMezmur = allMezmur.where((mezmur) =>
        (mezmur.stMarySong["Yekatit"] == true) || (mezmur.stMarySong["Nehase"] == true) || (mezmur.stMarySong["Mesgana"] == true)
        ).toList();

        print(" ✅ case on trinity ${allMezmur[0].trinitySong['tir']} ");
        setState(() {
          _data = filteredMezmur;
        });
        break;

      case "Kidus Gebriel":

        filteredMezmur = allMezmur.where((mezmur) =>
        (mezmur.kGebrielSong["Tahsas"] == true) || (mezmur.kGebrielSong["Hamle"] == true) || (mezmur.kGebrielSong["Mesgana"] == true)
        ).toList();

        print(" ✅ case on trinity ${allMezmur[0].trinitySong['tir']} ");
        setState(() {
          _data = filteredMezmur;
        });
        break;

      case "Kidusan Meleakt":

        filteredMezmur = allMezmur.where((mezmur) =>
        (mezmur.trinitySong["Tahsas"] == true) || (mezmur.trinitySong["Hamle"] == true) || (mezmur.trinitySong["Mesgana"] == true)
        ).toList();

        print(" ✅ case on trinity ${allMezmur[0].trinitySong['tir']} ");
        setState(() {
          _data = filteredMezmur;
        });
        break;


      case "Bealat Mezmur":

        filteredMezmur = allMezmur.where((mezmur) =>
        ( mezmur.mainHolidays.isNotEmpty ) || (mezmur.minorHolidays.isNotEmpty)
        ).toList();

        print(" ✅ case on trinity ${allMezmur[0].trinitySong['tir']} ");
        setState(() {
          _data = filteredMezmur;
        });
        break;

      case "Nesha Mezmur":

        filteredMezmur = allMezmur.where((mezmur) =>
        ( mezmur.repentanceSong!="")
        ).toList();

        print(" ✅ case on trinity ${allMezmur[0].trinitySong['tir']} ");
        setState(() {
          _data = filteredMezmur;
        });
        break;


      //
      default:
        setState(() {
          _data = allMezmur;
        });
        break;
        
    }
  }

  Future<void> loadJson() async {

    final String response =
        await rootBundle.loadString(widget.category.fileLocation);
    final Map<String, dynamic> jsonData = json.decode(response);

    List<Mezmur> allMezmur = (jsonData['song'] as List<dynamic>)
        .map((mezmur) => Mezmur.fromJson(mezmur))
        .toList();

    setState(() {
      _data = allMezmur;
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

  SingerInfoDisplay(Mezmur item){
    if(item.singer == "ሌላ ዘማሪ" ||item.singer == "ሌላ"){
      return Text(item.singerOther??"");
    }
    return Text(item.singer??"");
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.category.title),
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: widget.category.subCategories.map(
              (tabName){
                print(tabName);
                return Tab(text: tabName.title ?? 'Untitled');
              },
            ).toList(),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: widget.category.subCategories
              .map((tabName) {
             print(tabName.title);
             // tabfiltering(_data,tabName.title);
                return Center(
            child: Stack(
            children: [
            ListView.builder(
            itemCount: _data.length,
            itemBuilder: (context, index) {
              if(_data.isEmpty){
                return Container(
                  child: Text("Empty Mezmur"),
                );
              }
              final Mezmur item = _data[index];
              return ListTile(
                title: Text(item.title ?? ""),
                leading: Icon(Icons.music_note),
                subtitle: SingerInfoDisplay(item),
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
        ));

          })
              .toList(),
        ),
      ),
    );
  }
}
