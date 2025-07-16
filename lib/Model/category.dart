import 'subCategory.dart';

class Category {
  final String title;
  final String image;
  final List<SubCategory> subCategories;
  final String fileLocation;

  Category({
    required this.title,
    required this.image,
    required this.subCategories,
    required this.fileLocation
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      title: json['title'],
      image: json['image'],
      fileLocation: json['fileLocation'],
      subCategories: (json['sub_categories'] as List)
          .map((item) => SubCategory.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'image': image,
      'fileLocation': fileLocation,
      'sub_categories': subCategories.map((item) => item.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'Category(title: $title, image: $image, fileLocation: $fileLocation , subCategories: $subCategories)';
  }
}