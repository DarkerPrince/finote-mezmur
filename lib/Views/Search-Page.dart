import 'package:finotemezmur/Views/MezmurTagWidget.dart';
import 'package:flutter/material.dart';
import 'package:finotemezmur/Model/mezmur.dart';
import 'package:finotemezmur/Model/ShortLyrics.dart';
import 'package:finotemezmur/Model/LongLyrics.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

// Wrapper to hold matched result and matched line
class MezmurSearchResult {
  final Mezmur mezmur;
  final String? matchedLine;

  MezmurSearchResult(this.mezmur, this.matchedLine);
}

class SearchMezmurPage extends StatefulWidget {
  const SearchMezmurPage({super.key});

  @override
  State<SearchMezmurPage> createState() => _SearchMezmurPageState();
}

class _SearchMezmurPageState extends State<SearchMezmurPage> {
  List<Mezmur> _allMezmur = [];
  List<MezmurSearchResult> _filteredMezmur = [];
  TextEditingController _searchController = TextEditingController();

  Mezmur? _selectedMezmur;
  bool _showSheet = false;
  double _sheetSize = 1;
  double _sheetExtent = 1;

  final DraggableScrollableController _controller = DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    loadJson();
  }

  Future<void> loadJson() async {
    final List<String> jsonFiles = [
      'assets/Mezmur/kidanmhret.json',
      'assets/Mezmur/angels.json',
      'assets/Mezmur/holidays.json',
      'assets/Mezmur/HolyThrinity.json',
      'assets/Mezmur/kidaneshAyalkm.json',
      'assets/Mezmur/Others.json',
      'assets/Mezmur/Repentance.json',
      'assets/Mezmur/St_Gebriel.json'
    ];

    List<Mezmur> allMezmur = [];

    for (String path in jsonFiles) {
      final String response = await rootBundle.loadString(path);
      final Map<String, dynamic> jsonData = json.decode(response);

      List<Mezmur> mezmurList = (jsonData['song'] as List<dynamic>)
          .map((mezmur) => Mezmur.fromJson(mezmur))
          .toList();

      allMezmur.addAll(mezmurList);
    }

    setState(() {
      _allMezmur = allMezmur;
      _filteredMezmur = allMezmur.map((e) => MezmurSearchResult(e, null)).toList();
    });
  }

  void _performSearch(String query) {
    final lowerQuery = query.toLowerCase();
    final results = <MezmurSearchResult>[];

    for (final mezmur in _allMezmur) {
      final title = mezmur.title?.toLowerCase() ?? '';
      final singer = mezmur.singer?.toLowerCase() ?? '';
      final shortLyrics = mezmur.songLyrics.shortLyrics.lyrics?.toLowerCase() ?? '';
      final chorus = mezmur.songLyrics.longLyrics.chorus?.toLowerCase() ?? '';
      final verses = mezmur.songLyrics.longLyrics.verse ?? [];
      final otherSinger = mezmur.singerOther?.toLowerCase() ?? '';

      String? matchedLine;

      if (title.contains(lowerQuery)) matchedLine = mezmur.title;
      else if (singer.contains(lowerQuery)) matchedLine = mezmur.singer;
      else if (shortLyrics.contains(lowerQuery)) matchedLine = mezmur.songLyrics.shortLyrics.lyrics;
      else if (chorus.contains(lowerQuery)) matchedLine = mezmur.songLyrics.longLyrics.chorus;
      else if (otherSinger.contains(lowerQuery)) matchedLine = mezmur.singerOther;
      else {
        for (final line in verses) {
          if (line.toLowerCase().contains(lowerQuery)) {
            matchedLine = line;
            break;
          }
        }
      }

      if (matchedLine != null) {
        results.add(MezmurSearchResult(mezmur, matchedLine));
      }
    }

    setState(() {
      _filteredMezmur = results;
    });
  }

  TextSpan highlightMatch(
      String source,
      String query,
      BuildContext context,
        int surrounding ,
      ) {
    if (query.isEmpty) return TextSpan(text: source);

    final lowerSource = source.toLowerCase();
    final lowerQuery = query.toLowerCase();
    final startIndex = lowerSource.indexOf(lowerQuery);

    if (startIndex == -1) return TextSpan(text: source);

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final highlightColor = Theme.of(context).colorScheme.primary;
    final textColor = isDark ? Colors.black : Colors.white;

    // Make sure indices are always valid
    final snippetStart = (startIndex - surrounding).clamp(0, source.length);
    final snippetEnd =
    (startIndex + query.length + surrounding).clamp(0, source.length);

    final before = source.substring(snippetStart, startIndex);
    final match = source.substring(startIndex, startIndex + query.length);
    final after = source.substring(startIndex + query.length, snippetEnd);

    return TextSpan(
      children: [
        if (snippetStart > 0) const TextSpan(text: "…"),
        if (before.isNotEmpty) TextSpan(text: before),
        TextSpan(
          text: match,
          style: TextStyle(
            backgroundColor: highlightColor,
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (after.isNotEmpty) TextSpan(text: after),
        if (snippetEnd < source.length) const TextSpan(text: "…"),
      ],
      style: TextStyle(
        color: Theme.of(context).textTheme.bodyMedium?.color,
        fontSize: 14,
      ),
    );
  }


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

  void _handleItemTap(Mezmur mezmur, double size) {
    if (_showSheet && _selectedMezmur?.title == mezmur.title) {
      _controller.animateTo(1.0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      setState(() {
        _selectedMezmur = mezmur;
        _sheetSize = size;
        _showSheet = true;
      });
    }
  }

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
                    _selectedMezmur!.title ?? "",
                    style: TextStyle(fontSize: 20,  color: Theme.of(context).colorScheme.primary,fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(_selectedMezmur!.singer ?? ""),
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
                _selectedMezmur!.songLyrics.isShortSong
                    ? ShortMezmur(_selectedMezmur!.songLyrics.shortLyrics)
                    : LongMezmur(_selectedMezmur!.songLyrics.longLyrics),
              ],
            ),
          );
        },
      ),
    );
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
              fontWeight: FontWeight.bold,
              color: Colors.black87, // Use Theme.of(context).primaryColor for dynamic color
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 4,),
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('መዝሙር ፍለጋ')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              onChanged: _performSearch,
              decoration: InputDecoration(
                hintText: 'የመዝሙሩን ርዕስ ፣ ዘማሪ ወይም በዓል ይፈልጉ...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.05),
                contentPadding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.blue, width: 1.5),
                ),
              ),
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: _filteredMezmur.isEmpty
                ? const Center(child: Text('መዝሙር አልተገኘም'))
                : Stack(
              children: [
                ListView.builder(
                  itemCount: _filteredMezmur.length,
                  itemBuilder: (context, index) {
                    final result = _filteredMezmur[index];
                    final mezmur = result.mezmur;
                    final matchedLine = result.matchedLine ?? '';

                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.shade300, // border color
                            width: 1, // border thickness
                          ),
                        ),
                      ),
                      child: ListTile(
                        title: Text(mezmur.title ?? "", style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _searchController.text == ""? Container ():RichText(text: highlightMatch(matchedLine, _searchController.text, context , 10)),
                            SizedBox(height: 4,),
                            MezmurTagWidget(mezmur: mezmur)
                          ],
                        ),
                        leading: Icon(Icons.queue_music, color: Theme.of(context).colorScheme.primary),
                        trailing: Icon(Icons.keyboard_arrow_right_rounded),
                        onTap: () => _handleItemTap(mezmur, 1),
                      ),
                    );
                  },
                ),
                LyricsDisplaySheet(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
