class VerseModel {
  final String verse;

  VerseModel({required this.verse});

  factory VerseModel.fromJson(Map<String, dynamic> json) {
    return VerseModel(
      verse: json['Verse'] ?? '',
    );
  }
}
