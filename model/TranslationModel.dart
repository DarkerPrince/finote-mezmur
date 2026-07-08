class TranslationModel {
  final String translation;

  TranslationModel({required this.translation});

  factory TranslationModel.fromJson(Map<String, dynamic> json) {
    return TranslationModel(
      translation: json['Translation'],
    );
  }
}
