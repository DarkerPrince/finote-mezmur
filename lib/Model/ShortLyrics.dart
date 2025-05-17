class ShortLyrics {
  final String? lyrics;
  final String? translation;

  ShortLyrics({this.lyrics, this.translation});

  factory ShortLyrics.fromJson(Map<String, dynamic> json) {
    return ShortLyrics(
      lyrics: json['lyrics'],
      translation: json['translation'],
    );
  }
}