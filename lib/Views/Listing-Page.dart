import 'dart:convert';
import 'dart:ui';
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
  late DraggableScrollableController _controller;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    loadJson();
    _controller = DraggableScrollableController();
    _tabController = TabController(length: widget.category.subCategories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  DisplayVerse(String Verse) {
    return Container(
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

  // List<Mezmur> filteredMezmur=[];

  Map<String, List<Mezmur>> categorizedMezmur = {};

  void categorizeMezmurMethod(List<Mezmur> allMezmur, String categoryTitle) {
    switch (categoryTitle) {
      case "Kidest Silase":
        print("Category in Kidest Silase");

        categorizedMezmur = {
          "Tir": allMezmur.where((m) => m.trinitySong["Tir"] == true).toList(),
          "Hamle": allMezmur.where((m) => m.trinitySong["Hamle"] == true).toList(),
          "Mesgana": allMezmur.where((m) => m.trinitySong["Mesgana"] == true).toList(),
        };
        break;

      case "Kidest Kidanmhret":
        print("Category in Kidest kidanmhret");
        categorizedMezmur = {
          "Yekatit": allMezmur.where((m) => m.stMarySong["Yekatit"] == true).toList(),
          "Nehase": allMezmur.where((m) => m.stMarySong["Nehase"] == true).toList(),
          "Mesgana": allMezmur.where((m) => m.stMarySong["Mesgana"] == true).toList(),
        };
        break;

      case "Kidus Gebriel":
        print("Category in Kidest Silase");
        categorizedMezmur = {
          "Tahsas": allMezmur.where((m) => m.kGebrielSong["Tahsas"] == true).toList(),
          "Hamle": allMezmur.where((m) => m.kGebrielSong["Hamle"] == true).toList(),
          "Mesgana": allMezmur.where((m) => m.kGebrielSong["Mesgana"] == true).toList(),
        };
        break;

      case "Kidusan Meleakt":
        print("Category in Angels");
        categorizedMezmur = {
          "Tahsas": allMezmur.where((m) => m.trinitySong["Tahsas"] == true).toList(),
          "Hamle": allMezmur.where((m) => m.trinitySong["Hamle"] == true).toList(),
          "Mesgana": allMezmur.where((m) => m.trinitySong["Mesgana"] == true).toList(),
        };
        break;

      case "Bealat Mezmur":
        print("Category in Bealat");
        categorizedMezmur = {
          "Main Holidays": allMezmur.where((m) => m.mainHolidays.isNotEmpty).toList(),
          "Minor Holidays": allMezmur.where((m) => m.minorHolidays.isNotEmpty).toList(),
        };
        break;

      case "Nesha Mezmur":
        print("Category in Nesha Mezmur");
        categorizedMezmur = {
          "Repentance": allMezmur.where((m) => m.repentanceSong?.isNotEmpty ?? false).toList(),
        };
        break;

      case "Kidanesh Ayalkm":
        print("Category in Nesha Mezmur");
        categorizedMezmur = {
          "Kidanesh Ayalkm": allMezmur,
        };
        break;

      default:
        print("Category in Default Switch");
        categorizedMezmur = {
          "All": allMezmur,
        };
    }
    print(categorizedMezmur);

    setState(() {});
  }


  // filterMezmurLists(List<Mezmur> allMezmur){
  //   List<Mezmur> filteredMezmur;
  //
  //   switch (widget.category.title) {
  //   // Special case: Trinity
  //     case "Kidest Silase":
  //
  //
  //       filteredMezmur = allMezmur.where((mezmur) =>
  //       (mezmur.trinitySong["Tir"] == true) || (mezmur.trinitySong["Hamle"] == true) || (mezmur.trinitySong["Mesgana"] == true)
  //       ).toList();
  //
  //       setState(() {
  //         _data = filteredMezmur;
  //       });
  //       break;
  //
  //     case "Kidest Kidanmhret":
  //
  //       filteredMezmur = allMezmur.where((mezmur) =>
  //       (mezmur.stMarySong["Yekatit"] == true) || (mezmur.stMarySong["Nehase"] == true) || (mezmur.stMarySong["Mesgana"] == true)
  //       ).toList();
  //
  //       print(" ✅ case on trinity ${allMezmur[0].trinitySong['tir']} ");
  //       setState(() {
  //         _data = filteredMezmur;
  //       });
  //       break;
  //
  //     case "Kidus Gebriel":
  //
  //       filteredMezmur = allMezmur.where((mezmur) =>
  //       (mezmur.kGebrielSong["Tahsas"] == true) || (mezmur.kGebrielSong["Hamle"] == true) || (mezmur.kGebrielSong["Mesgana"] == true)
  //       ).toList();
  //
  //       print(" ✅ case on trinity ${allMezmur[0].trinitySong['tir']} ");
  //       setState(() {
  //         _data = filteredMezmur;
  //       });
  //       break;
  //
  //     case "Kidusan Meleakt":
  //
  //       filteredMezmur = allMezmur.where((mezmur) =>
  //       (mezmur.trinitySong["Tahsas"] == true) || (mezmur.trinitySong["Hamle"] == true) || (mezmur.trinitySong["Mesgana"] == true)
  //       ).toList();
  //
  //       print(" ✅ case on trinity ${allMezmur[0].trinitySong['tir']} ");
  //       setState(() {
  //         _data = filteredMezmur;
  //       });
  //       break;
  //
  //
  //     case "Bealat Mezmur":
  //
  //       filteredMezmur = allMezmur.where((mezmur) =>
  //       ( mezmur.mainHolidays.isNotEmpty ) || (mezmur.minorHolidays.isNotEmpty)
  //       ).toList();
  //
  //       print(" ✅ case on trinity ${allMezmur[0].trinitySong['tir']} ");
  //       setState(() {
  //         _data = filteredMezmur;
  //       });
  //       break;
  //
  //     case "Nesha Mezmur":
  //
  //       filteredMezmur = allMezmur.where((mezmur) =>
  //       ( mezmur.repentanceSong!="")
  //       ).toList();
  //
  //       print(" ✅ case on trinity ${allMezmur[0].trinitySong['tir']} ");
  //       setState(() {
  //         _data = filteredMezmur;
  //       });
  //       break;
  //
  //
  //     //
  //     default:
  //       setState(() {
  //         _data = allMezmur;
  //       });
  //       break;
  //
  //   }
  // }

  Future<void> loadJson() async {

    final String response =
        await rootBundle.loadString(widget.category.fileLocation);
    final Map<String, dynamic> jsonData = json.decode(response);

    List<Mezmur> allMezmur = (jsonData['song'] as List<dynamic>)
        .map((mezmur) => Mezmur.fromJson(mezmur))
        .toList();

      categorizeMezmurMethod(allMezmur,widget.category.title);

  }



  LyricsDisplaySheet() {
    Color backgroundColor = Theme.of(context).brightness == Brightness.dark
        ? Color(0xFF121212)
        : Colors.white;
    if (_showSheet) {
      return DraggableScrollableSheet(
        initialChildSize: _sheetSize, // Starts small like a mini player
        minChildSize: 0.14,
        controller: _controller, // Minimum size when collapsed
        maxChildSize: 1, // Maximum height when expanded
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(

              boxShadow: [
                BoxShadow(
                  color: backgroundColor,
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
                  title: Text(_selectedMezmur.title ?? "" ,style: TextStyle(color: Theme.of(context).primaryColor),),
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
    return Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.yellow.withOpacity(0.1)
                : Theme.of(context).primaryColor.withOpacity(0.1),
            child: Text(longMezmurLyrics.chorus ??"እዝ",
                textAlign: TextAlign.center,
                softWrap: true,
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.yellow
                      : Theme.of(context).primaryColor,
                  fontSize: 24,
                )),
          ),
          Column(
      children: (longMezmurLyrics.verse as List)
          .map((verse) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  DisplayVerse(verse),
                  verse==""?Container():Container(
                    padding: EdgeInsets.all(12),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.yellow.withOpacity(0.1)
                        : Theme.of(context).primaryColor.withOpacity(0.1),
                    child: Text("እዝ",
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.yellow
                              : Theme.of(context).primaryColor,
                          fontSize: 24,
                        )),
                  )
                ],)

              ))
          .toList(),
    )]);
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
          children: widget.category.subCategories.map((tabName) {
            // final List<Mezmur> _data = tabName.value;
             print("Amount of ${widget.category.title} ${tabName.title} \n");
             // print("This is the categroy Title ${categorizedMezmur[tabName.title]!.length}");
             print("============ \n\n");
            // categorizedMezmur[tabName.title] = categorizedMezmur[tabName.title] ?? [];
                return Center(
            child: Stack(
            children: [
            ListView.builder(
            itemCount: categorizedMezmur[tabName.title]?.length ?? 0,
            itemBuilder: (context, index) {

              if(categorizedMezmur[tabName.title]?.isEmpty ?? true){
                return Container(
                  child: Text("Empty Mezmur"),
                );
              }
              final Mezmur item = categorizedMezmur![tabName.title]![index];
              return ListTile(
                title: Text(item.title ?? ""),
                leading: Icon(Icons.music_note,color: Theme.of(context).colorScheme.primary,),
                subtitle: SingerInfoDisplay(item),
                // trailing: IconButton(
                //   onPressed: () {
                //     setState(() {
                //       _isFavorite = !_isFavorite;
                //     });
                //   },
                //   icon: Icon(
                //     _isFavorite
                //         ? Icons.church
                //         : Icons.church_outlined,
                //     color: _isFavorite ? Colors.red : Colors.grey,
                //   ),
                // ),
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
