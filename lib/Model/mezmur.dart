import 'package:finotemezmur/Model/Lyrics.dart';

class Mezmur {
  final String id;
  final String title;
  // final String? major;

  final String? singer;
  final String? singerOther;
  final String? repentanceSong;
  final String? others;
  final List<String> about;
  final List<String> angels;
  final List<String> mainHolidays;
  final List<String> minorHolidays;
  final SongLyrics songLyrics;
  final Map<String, bool> trinitySong;
  final Map<String, bool> stMarySong;
  final Map<String, bool> kGebrielSong;

  Mezmur({
    required this.id,
    required this.title,
    // required this.major,
    required this.repentanceSong,
    required this.singer,
    required this.singerOther,
    required this.others,
    required this.about,
    required this.angels,
    required this.mainHolidays,
    required this.minorHolidays,
    required this.songLyrics,
    required this.trinitySong,
    required this.stMarySong,
    required this.kGebrielSong,
  });

  factory Mezmur.fromJson(Map<String, dynamic> json) {
    return Mezmur(
      id: json['id'],
      title: json['Title']??"",
      // major: json['major'],
      singer: json['singer']??"",
      singerOther: json['singerOther']??"",
      repentanceSong: json['repentanceSong'],
      others: json['others']??"",
      about: List<String>.from(json['about'] ?? []),
      angels: List<String>.from(json['angels'] ?? []),
      mainHolidays: List<String>.from(json['main_holidays'] ?? []),
      minorHolidays: List<String>.from(json['minor_holidays'] ?? []),
      songLyrics: SongLyrics.fromJson(json['songLyrics']),
      trinitySong: Map<String, bool>.from(json['Trinity_Song'] ?? {}),
      stMarySong: Map<String, bool>.from(json['St_Mary_Song'] ?? {}),
      kGebrielSong: Map<String, bool>.from(json['K_Gebriel_Song'] ?? {}),
    );
  }

  @override
  String toString() {
    return 'Mezmur('
        'id: $id, '
        'title: $title, '
        'singer: $singer, '
        'singerOther: $singerOther, '
        'repentanceSong: $repentanceSong, '
        'others: $others, '
        'about: ${about.join(", ")}, '
        'angels: ${angels.join(", ")}, '
        'mainHolidays: ${mainHolidays.join(", ")}, '
        'minorHolidays: ${minorHolidays.join(", ")}, '
        'songLyrics: ${songLyrics.toString()}, '
        'trinitySong: $trinitySong, '
        'stMarySong: $stMarySong, '
        'kGebrielSong: $kGebrielSong'
        ')';
  }


}
