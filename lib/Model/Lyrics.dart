import 'package:finotemezmur/Model/ShortLyrics.dart';
import 'package:finotemezmur/Model/LongLyrics.dart';

class SongLyrics {
  final bool isShortSong;
  final ShortLyrics shortLyrics;
  final LongLyrics longLyrics;

  SongLyrics({
    required this.isShortSong,
    required this.shortLyrics,
    required this.longLyrics,
  });

  factory SongLyrics.fromJson(Map<String, dynamic> json) {
    return SongLyrics(
      isShortSong: json['isShortSong'] ?? false,
      shortLyrics: ShortLyrics.fromJson(json['shortLyrics']),
      longLyrics: LongLyrics.fromJson(json['longLyrics']),
    );
  }
}