
import 'package:flutter/material.dart';
import 'package:finotemezmur/Model/Lyrics.dart';
import 'package:finotemezmur/Model/mezmur.dart';

class MezmurTagWidget extends StatelessWidget {
  final Mezmur mezmur;

  const MezmurTagWidget({super.key, required this.mezmur});

  // case "የ":
  // print("Category in Kidest Silase");
  //
  // categorizedMezmur = {
  // "ጥር": allMezmur.where((m) => m.trinitySong["Tir"] == true).toList(),
  // "ሐምሌ":
  // allMezmur.where((m) => m.trinitySong["Hamle"] == true).toList(),
  // "ምሥጋና":
  // allMezmur.where((m) => m.trinitySong["Mesgana"] == true).toList(),
  // };
  // break;
  //
  // case "የ":
  // print("Category in Kidest kidanmhret");
  // categorizedMezmur = {
  // "የካቲት":
  // allMezmur.where((m) => m.stMarySong["Yekatit"] == true).toList(),
  // "ነሐሴ":
  // allMezmur.where((m) => m.stMarySong["Nehase"] == true).toList(),
  // "ምሥጋና":
  // allMezmur.where((m) => m.stMarySong["Mesgana"] == true).toList(),
  // };
  // break;
  //
  // case "የ":
  // print("Category in Kidest Silase");
  // categorizedMezmur = {
  // "ታኅሣሥ":
  // allMezmur.where((m) => m.kGebrielSong["Tahsas"] == true).toList(),
  // "ሐምሌ":
  // allMezmur.where((m) => m.kGebrielSong["Hamle"] == true).toList(),
  // "ምሥጋና": allMezmur
  //     .where((m) => m.kGebrielSong["Mesgana"] == true)
  //     .toList(),
  // };
  // break;


  // Collect all valid strings into one list
  List<String> _collectTexts() {
    List<String> results = [];

    // Add array fields
    results.addAll(mezmur.about);
    results.addAll(mezmur.minorHolidays);
    results.addAll(mezmur.mainHolidays);
    results.addAll(
        mezmur.angels.where((angel) => angel != "ቅዱስ ገብርኤል")
    );

    // Handle boolean sections with labels
    final sectionLabels = {
      mezmur.trinitySong: "ቅ/ሥላሴ",
      mezmur.stMarySong: "ቅ/ኪዳነምሕረት",
      mezmur.kGebrielSong: "ቅ/ገብርኤል",
    };
    final amharicMap = {
      "Tahsas": "ታኅሣሥ",
      "Hamle": "ሐምሌ",
      "Mesgana": "ምሥጋና",
      "Tir": "ጥር",
      "Yekatit": "የካቲት",
      "Nehase": "ነሐሴ",
      // add other mappings as needed
    };

    sectionLabels.forEach((map, label) {
      final trueFields = map.entries
          .where((e) => e.value)
          .map((e) => amharicMap[e.key] ?? e.key) // convert key to Amharic
          .toList();

      if (trueFields.isNotEmpty) {
        results.add("$label: ${trueFields.join(", ")}");
      }
    });


    return results;
  }

  // Chip-style widget
  Widget _buildChip(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 1,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 10,
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final collected = _collectTexts();
    final songLyrics = mezmur.songLyrics;

      if (collected.isNotEmpty){
       return Wrap(
         children:
         collected.map((text) => _buildChip(context, text)).toList(),
       );
     }

      return Container();
  }
}
