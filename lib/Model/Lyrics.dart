import 'package:finotemezmur/Model/ShortLyrics.dart';
import 'package:finotemezmur/Model/LongLyrics.dart';


class Lyric {
  final List<String> chorus;
  final String id;
  final List<String> translation;
  final List<String> verse;
  final bool isShortSong;

  Lyric({
    required this.chorus,
    required this.id,
    required this.translation,
    required this.verse,
    required this.isShortSong
  });

  factory Lyric.fromJson(Map<String, dynamic> json) {
    return Lyric(
      chorus: (json["chorus"] as List<dynamic>)
          .map((e) => e["Chorus"] as String)
          .toList(),
      id: json["id"],
      isShortSong: json['verse'] == null || (json['verse'] as List).isEmpty,
      translation: (json["translation"] as List<dynamic>)
          .map((e) => e["Translation"] as String)
          .toList(),
      verse: (json["verse"] as List<dynamic>)
          .map((e) => e["Verse"] as String)
          .toList(),
    );
  }
}
