import 'ChorusModel.dart';
import 'verseModel.dart';
import 'TranslationModel.dart';

class LyricsModel {
  final String id;
  final List<ChorusModel> chorus;
  final List<VerseModel> verse;
  final List<TranslationModel> translation;

  LyricsModel({
    required this.id,
    required this.chorus,
    required this.verse,
    required this.translation,
  });

  factory LyricsModel.fromJson(Map<String, dynamic> json) {
    return LyricsModel(
      id: json['id'],
      chorus: (json['chorus'] as List)
          .map((e) => ChorusModel.fromJson(e))
          .toList(),
      verse: (json['verse'] as List)
          .map((e) => VerseModel.fromJson(e))
          .toList(),
      translation: (json['translation'] as List)
          .map((e) => TranslationModel.fromJson(e))
          .toList(),
    );
  }
}
