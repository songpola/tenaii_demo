class Categories {
  Categories({required this.data, required this.success});

  final List<CategoriesData> data;
  final bool success;

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        data: List<CategoriesData>.from(
            json["data"].map((x) => CategoriesData.fromJson(x))),
        success: json["success"],
      );
}

class CategoriesData {
  CategoriesData({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.icon,
    required this.thumbnail,
    required this.subCategories,
  });

  final String id;
  final String name;
  final CategoriesDataImageUrl imageUrl;
  final String icon;
  final String thumbnail;
  final List<SubCategory> subCategories;

  factory CategoriesData.fromJson(Map<String, dynamic> json) => CategoriesData(
        id: json["id"],
        name: json["name"],
        imageUrl: CategoriesDataImageUrl.fromJson(json["imageUrl"]),
        icon: json["icon"],
        thumbnail: json["thumbnail"],
        subCategories: List<SubCategory>.from(
            json["subCategories"].map((x) => SubCategory.fromJson(x))),
      );
}

class CategoriesDataImageUrl {
  CategoriesDataImageUrl({
    required this.imageUrlDefault,
    required this.thumbnail,
  });

  final String imageUrlDefault;
  final String thumbnail;

  factory CategoriesDataImageUrl.fromJson(Map<String, dynamic> json) =>
      CategoriesDataImageUrl(
        imageUrlDefault: json["default"],
        thumbnail: json["thumbnail"],
      );
}

class SubCategory {
  SubCategory({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json["id"],
        name: json["name"],
      );
}
