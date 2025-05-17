class LongLyrics {
  final String? chorus;
  final List<String> verse;

  LongLyrics({this.chorus, required this.verse});

  factory LongLyrics.fromJson(Map<String, dynamic> json) {
    return LongLyrics(
      chorus: json['chorus'],
      verse: List<String>.from(json['verse'] ?? []),
    );
  }
}