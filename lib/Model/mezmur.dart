import 'package:finotemezmur/Model/Lyrics.dart';

class Mezmur {
  final List<String> kGebrielSong;
  final List<String> stMarySong;
  final List<String> trinitySong;

  final String? audioLink;
  final String? genre;
  final String id;
  final bool? isRepentanceSong;
  final bool? isShortSong;
  final int mezmurRefNumber;

  final Lyric lyric;

  final String? singer;
  final String? special;
  final String title;
  final String? youtubeLink;

  Mezmur({
    required this.kGebrielSong,
    required this.stMarySong,
    required this.trinitySong,
    required this.audioLink,
    required this.genre,
    required this.id,
    required this.isRepentanceSong,
    required this.isShortSong,
    required this.mezmurRefNumber,
    required this.lyric,
    required this.singer,
    required this.special,
    required this.title,
    required this.youtubeLink,
  });

  factory Mezmur.fromJson(Map<String, dynamic> json) {
    return Mezmur(
      kGebrielSong: List<String>.from(json["K_Gebriel_Song"] ?? []),
      stMarySong: List<String>.from(json["St_Mary_Song"] ?? []),
      trinitySong: List<String>.from(json["Trinity_Song"] ?? []),
      audioLink: json["audio_link"],
      genre: json["genre"],
      id: json["id"],
      isRepentanceSong: json["isRepentanceSong"],
      isShortSong: json["isShortSong"],
      mezmurRefNumber: json["mezmur_ref_number"],
      lyric: Lyric.fromJson(json["lyric"]),
      singer: json["singer"],
      special: json["special"],
      title: json["title"],
      youtubeLink: json["youtube_link"],
    );
  }
}
