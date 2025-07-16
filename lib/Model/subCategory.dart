
class SubCategory {
  final String title;
  final String image;
  final String fileLocation;

  SubCategory({
    required this.title,
    required this.image,
    required this.fileLocation,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      title: json['title'],
      image: json['image'],
      fileLocation: json['fileLocation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'image': image,
      'fileLocation': fileLocation,
    };
  }

  @override
  String toString() {
    return 'SubCategory(title: $title, image: $image, fileLocation: $fileLocation)';
  }
}
