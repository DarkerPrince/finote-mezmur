class ChorusModel {
  final String chorus;

  ChorusModel({required this.chorus});

  factory ChorusModel.fromJson(Map<String, dynamic> json) {
    return ChorusModel(
      chorus: json['Chorus'],
    );
  }
}
