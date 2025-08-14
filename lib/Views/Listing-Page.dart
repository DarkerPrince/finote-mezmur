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
  double _sheetSize = 0;
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

  Map<String, List<Mezmur>> categorizedMezmur = {};

  void categorizeMezmurMethod(List<Mezmur> allMezmur, String categoryTitle) {
    switch (categoryTitle) {
      case "የቅድስት ሥላሴ":
        print("Category in Kidest Silase");

        categorizedMezmur = {
          "ጥር": allMezmur.where((m) => m.trinitySong["Tir"] == true).toList(),
          "ሐምሌ": allMezmur.where((m) => m.trinitySong["Hamle"] == true).toList(),
          "ምሥጋና": allMezmur.where((m) => m.trinitySong["Mesgana"] == true).toList(),
        };
        break;

      case "የቅድስት ኪዳነምሕረት":
        print("Category in Kidest kidanmhret");
        categorizedMezmur = {
          "የካቲት": allMezmur.where((m) => m.stMarySong["Yekatit"] == true).toList(),
          "ነሐሴ": allMezmur.where((m) => m.stMarySong["Nehase"] == true).toList(),
          "ምሥጋና": allMezmur.where((m) => m.stMarySong["Mesgana"] == true).toList(),
        };
        break;

      case "የቅዱስ ገብርኤል":
        print("Category in Kidest Silase");
        categorizedMezmur = {
          "ታኅሣሥ": allMezmur.where((m) => m.kGebrielSong["Tahsas"] == true).toList(),
          "ሐምሌ": allMezmur.where((m) => m.kGebrielSong["Hamle"] == true).toList(),
          "ምሥጋና": allMezmur.where((m) => m.kGebrielSong["Mesgana"] == true).toList(),
        };
        break;

      case "የመላእክት":
        print("Category in Angels");
        categorizedMezmur = {
          "ቅዱስ ሚካኤል": allMezmur.where((m) => m.angels.contains("ቅዱስ ሚካኤል")).toList(),
          "ቅዱስ ሩፋኤል": allMezmur.where((m) => m.angels.contains("ቅዱስ ሩፋኤል")).toList(),
          "ቅዱስ ኡራኤል": allMezmur.where((m) => m.angels.contains("ቅዱስ ኡራኤል")).toList(),
          "ሁሉም": allMezmur.where((m) => m.angels.contains("ሁሉም")).toList(),
        };
        break;

      case "በዓላት":
        print("Category in Bealat");
        // Define known keywords
        final knownAbouts = ["የአዲስ ዓመት", "የዘመነ ጽጌ"];
        final knownMainHolidays = ["መስቀል", "ብሥራት", "ሆሳዕና", "ልደት", "ጥምቀት", "ትንሳኤ"];

        categorizedMezmur = {
          "የአዲስ ዓመት": allMezmur.where((m) => m.about.contains("የአዲስ ዓመት")).toList(),
          "የዘመነ ጽጌ": allMezmur.where((m) => m.about.contains("የዘመነ ጽጌ")).toList(),
          "መስቀል": allMezmur.where((m) => m.mainHolidays.contains("መስቀል")).toList(),
          "ብሥራት": allMezmur.where((m) => m.mainHolidays.contains("ብሥራት")).toList(),
          "ሆሳዕና": allMezmur.where((m) => m.mainHolidays.contains("ሆሳዕና")).toList(),
          "ልደት": allMezmur.where((m) => m.mainHolidays.contains("ልደት")).toList(),
          "ጥምቀት": allMezmur.where((m) => m.mainHolidays.contains("ጥምቀት")).toList(),
          "ትንሳኤ": allMezmur.where((m) => m.mainHolidays.contains("ትንሳኤ")).toList(),
          "ሌላ": allMezmur.where((m) {
            // Check if not in any of the above categories
            bool isKnownAbout = knownAbouts.any((about) => m.about.contains(about));
            bool isKnownHoliday = knownMainHolidays.any((holiday) => m.mainHolidays.contains(holiday));
            return !isKnownAbout && !isKnownHoliday;
          }).toList()
        };
        break;

      case "የንስሐ":
        print("Category in Nesha Mezmur");
        categorizedMezmur = {
          "የንስሐ": allMezmur,
        };
        break;

      case "ኪዳንሽ አያልቅም":
        print("Category in Nesha Mezmur");
        categorizedMezmur = {
          "ኪዳንሽ አያልቅም 1": allMezmur,
        };
        break;

      case "የቅዱሳን ጻድቃንና ሰማዕታት":
        print("Category in Nesha Mezmur");
        categorizedMezmur = {
          "የቅዱሳን ጻድቃንና ሰማዕታት": allMezmur,
        };
        break;

      case "ልዩ ልዩ":
        print("Category in Nesha Mezmur");
        categorizedMezmur = {
          "የሐዘን": allMezmur.where((m) => m.others=="የሐዘን").toList(),
          "የሕፃናት": allMezmur.where((m) => m.others=="የሕፃናት").toList(),
          "የጳጳሳት መቀበያ": allMezmur.where((m) => m.others=="የጳጳሳት መቀበያ").toList(),
          "የሰርግ": allMezmur.where((m) => m.about.contains("የሠርግ")).toList(),
          "የቤተ ክርስቲያን": allMezmur.where((m) => m.about.contains("የቤተ ክርስቲያን")).toList(),
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

  Future<void> loadJson() async {

    final String response =
        await rootBundle.loadString(widget.category.fileLocation);
    final Map<String, dynamic> jsonData = json.decode(response);

    List<Mezmur> allMezmur = (jsonData['song'] as List<dynamic>)
        .map((mezmur) => Mezmur.fromJson(mezmur))
        .toList();

      categorizeMezmurMethod(allMezmur,widget.category.title);

  }

  double _sheetExtent = 1; // Default initial value

  Widget LyricsDisplaySheet() {
    if (!_showSheet) return SizedBox.shrink();

    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (notification) {
        setState(() {
          _sheetExtent = notification.extent;
        });
        return true;
      },
      child: DraggableScrollableSheet(
        controller: _controller,
        initialChildSize: _sheetSize,
        minChildSize: 0.14,
        maxChildSize: 1.0,
        builder: (context, scrollController) {



          final Color minColor = Theme.of(context).colorScheme.secondary;
          final Color maxColor = Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF121212)
              : Colors.white;

          print("The SheetSize initial is ${_sheetSize}");
          print("The SheetExtent initial is ${_sheetExtent}");

          final double factor = ((_sheetExtent - 0.14) / (1.0 - 0.14)).clamp(0.0, 1.0);
          final double flippedFactor = 1.0 - factor;
          final Color animatedColor = Color.lerp(minColor, maxColor, factor)!;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: animatedColor,
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
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
                  title: Text(
                    _selectedMezmur.title ?? "",
                    style: TextStyle(fontSize: 20,  color: Theme.of(context).colorScheme.primary,fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(_selectedMezmur.singer ?? ""),
                  trailing: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        _showSheet = false;
                        _sheetExtent = 1;
                      });
                    },
                  ),
                ),
                Divider(),
                _selectedMezmur.songLyrics.isShortSong
                    ? ShortMezmur(_selectedMezmur.songLyrics.shortLyrics)
                    : LongMezmur(_selectedMezmur.songLyrics.longLyrics),
              ],
            ),
          );
        },
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
    return Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.yellow.withOpacity(0.1)
                : Theme.of(context).primaryColor.withOpacity(0.1),
            child: Text(longMezmurLyrics.chorus ??"አዝ",
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
                    child: Text("አዝ",
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

  SingerInfoDisplay(Mezmur item) {
    String singerText = item.singer == "ሌላ"
        ? (item.singerOther ?? "-")
        : (item.singer ?? "--");

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: singerText,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey
            ),
          ),
          item.songLyrics.isShortSong ? WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0.5),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 1,
                  ),
                ),
                child: Text(
                   "አጭር",
                  style: TextStyle(
                    fontSize: 8,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ):WidgetSpan(child: Text("")),
        ],
      ),
      softWrap: true,
    );
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
                return Tab(text: tabName.title ?? '');
              },
            ).toList(),
          ),
        ),
        body: Stack(
          children: [
            TabBarView(
              controller: _tabController,
              children: widget.category.subCategories.map((tabName) {
                // final List<Mezmur> _data = tabName.value;
                print("Amount of ${widget.category.title} ${tabName.title} \n");
                // print("This is the categroy Title ${categorizedMezmur[tabName.title]!.length}");
                print("============ Length \n\n ${categorizedMezmur[tabName.title]?.length}");
                // categorizedMezmur[tabName.title] = categorizedMezmur[tabName.title] ?? [];
                return ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => SizedBox(height: 4),
                  itemCount: categorizedMezmur[tabName.title]?.length ?? 0,
                  itemBuilder: (context, index) {

                    if(categorizedMezmur[tabName.title]?.isEmpty ?? true){
                      return Center(
                        child: Text("ባዶ መዝሙር"),
                      );
                    }
                    final Mezmur item = categorizedMezmur![tabName.title]![index];
                    return ListTile(
                      tileColor: Theme.of(context).colorScheme.primary.withOpacity(0.05),
                      title: Text(item.title ?? "ርዕስ አልባ",style: TextStyle(fontWeight: FontWeight.bold),),
                      leading: Icon(Icons.music_note,color: Theme.of(context).colorScheme.primary,),
                      subtitle: SingerInfoDisplay(item),
                      trailing: Icon(Icons.keyboard_arrow_right_rounded),
                      onTap: () => _handleItemTap(item, 1),
                    );
                  },
                );

              })
                  .toList(),
            ),
            LyricsDisplaySheet()
          ],
        ),
      ),
    );
  }
}
