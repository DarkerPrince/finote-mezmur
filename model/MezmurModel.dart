import 'LyricsModel.dart';

class MezmurModel {
  final String id;
  final String title;
  final bool? isShortSong;
  final bool? isRepentanceSong;
  final int mezmurRefNumber;

  final LyricsModel lyric;

  final List<String> angel;
  final List<String> holidays;
  final List<String> kGebrielSong;
  final List<String> stMarySong;
  final List<String> trinitySong;

  final String? audioLink;
  final String? youtubeLink;
  final String? genre;
  final String? singer;
  final String? special;

  MezmurModel({
    required this.id,
    required this.title,
    required this.lyric,
    required this.mezmurRefNumber,
    this.isShortSong,
    this.isRepentanceSong,
    required this.angel,
    required this.holidays,
    required this.kGebrielSong,
    required this.stMarySong,
    required this.trinitySong,
    this.audioLink,
    this.youtubeLink,
    this.genre,
    this.singer,
    this.special,
  });

  factory MezmurModel.fromJson(Map<String, dynamic> json) {
    return MezmurModel(
      id: json['id'],
      title: json['title'],
      mezmurRefNumber: json['mezmur_ref_number'],
      isShortSong: json['isShortSong'],
      isRepentanceSong: json['isRepentanceSong'],
      lyric: LyricsModel.fromJson(json['lyric']),
      angel: List<String>.from(json['Angel'] ?? []),
      holidays: List<String>.from(json['Holidays'] ?? []),
      kGebrielSong: List<String>.from(json['K_Gebriel_Song'] ?? []),
      stMarySong: List<String>.from(json['St_Mary_Song'] ?? []),
      trinitySong: List<String>.from(json['Trinity_Song'] ?? []),
      audioLink: json['audio_link'],
      youtubeLink: json['youtube_link'],
      genre: json['genre'],
      singer: json['singer'],
      special: json['special'],
    );
  }
}
