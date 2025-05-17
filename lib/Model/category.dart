import 'subCategory.dart';

class Category {
  final String title;
  final String image;
  final List<SubCategory> subCategories;

  Category({
    required this.title,
    required this.image,
    required this.subCategories,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      title: json['title'],
      image: json['image'],
      subCategories: (json['sub_categories'] as List)
          .map((item) => SubCategory.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'image': image,
      'sub_categories': subCategories.map((item) => item.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'Category(title: $title, image: $image, subCategories: $subCategories)';
  }
}