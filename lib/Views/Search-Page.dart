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
  TextSpan highlightMatch(String source, String query) {
    final lowerSource = source.toLowerCase();
    final lowerQuery = query.toLowerCase();
    final startIndex = lowerSource.indexOf(lowerQuery);

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final highlightColor = Theme.of(context).colorScheme.primary;
    final textColor = isDark ? Colors.black : Colors.white;

    if (startIndex == -1 || query.isEmpty) {
      return TextSpan(text: source);
    }

    return TextSpan(
      children: [
        TextSpan(text: source.substring(0, startIndex)),
        TextSpan(
          text: source.substring(startIndex, startIndex + query.length),
          style: TextStyle(
            backgroundColor: highlightColor,
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(text: source.substring(startIndex + query.length)),
      ],
      style: TextStyle(
        color: Theme.of(context).textTheme.bodyMedium?.color,
        fontSize: 14,
      ),
    );
  }


  Widget SingerInfoDisplay(Mezmur item) {
    if (item.singer == "ሌላ ዘማሪ" || item.singer == "ሌላ") {
      return Text(item.singerOther ?? "");
    }
    return Text(item.singer ?? "");
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
    if (!_showSheet || _selectedMezmur == null) return Container();

    return DraggableScrollableSheet(
      initialChildSize: _sheetSize,
      minChildSize: 0.14,
      controller: _controller,
      maxChildSize: 1,
      builder: (context, scrollController) {
        return Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: ListView(
            controller: scrollController,
            children: [
              const SizedBox(height: 10),
              Center(
                child: Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              ListTile(
                title: Text(_selectedMezmur!.title ?? "", style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                subtitle: Text(_selectedMezmur!.singer ?? ""),
                trailing: IconButton(
                    onPressed: () => setState(() => _showSheet = false),
                    icon: const Icon(Icons.close)),
              ),
              const Divider(),
              _selectedMezmur!.songLyrics.isShortSong
                  ? DisplayShortLyrics(_selectedMezmur!.songLyrics.shortLyrics)
                  : DisplayLongLyrics(_selectedMezmur!.songLyrics.longLyrics)
            ],
          ),
        );
      },
    );
  }

  Widget DisplayShortLyrics(ShortLyrics shortLyrics) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(shortLyrics.lyrics ?? "", textAlign: TextAlign.center, style: const TextStyle(fontSize: 24)),
        ),
        if (shortLyrics.translation?.isNotEmpty == true)
          Container(
            color: Colors.blue.withOpacity(0.1),
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const Text("ትርጉም:-", style: TextStyle(fontSize: 20)),
                Text(shortLyrics.translation!, style: const TextStyle(fontSize: 20))
              ],
            ),
          )
      ],
    );
  }

  Widget DisplayLongLyrics(LongLyrics longLyrics) {
    return Column(
      children: [
        if (longLyrics.chorus?.isNotEmpty == true)
          Container(
            padding: const EdgeInsets.all(12),
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Text(longLyrics.chorus!, textAlign: TextAlign.center, style: const TextStyle(fontSize: 24)),
          ),
        ...?longLyrics.verse?.map((verse) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(verse, style: const TextStyle(fontSize: 20)),
        ))
      ],
    );
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

                    return ListTile(
                      title: Text(mezmur.title ?? "", style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: RichText(text: highlightMatch(matchedLine, _searchController.text)),
                      leading: Icon(Icons.queue_music, color: Theme.of(context).colorScheme.primary),
                      onTap: () => _handleItemTap(mezmur, 1),
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
