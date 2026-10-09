class GetCategoryResponseModel {
  final int total;
  final int page;
  final int pages;
  final List<CategoryItem> data;

  GetCategoryResponseModel({
    required this.total,
    required this.page,
    required this.pages,
    required this.data,
  });

  factory GetCategoryResponseModel.fromJson(Map<String, dynamic> json) {
    // Handle outer envelope { "success": true, "data": { "total": ..., "data": [...] } }
    final Map<String, dynamic> payload =
        (json["data"] is Map<String, dynamic>)
            ? (json["data"] as Map<String, dynamic>)
            : json;

    final rawList = payload["data"] as List? ?? [];

    return GetCategoryResponseModel(
      total: payload["total"] ?? 0,
      page: payload["page"] ?? 1,
      pages: payload["pages"] ?? 1,
      data: rawList
          .map((e) => CategoryItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class CategoryItem {
  final String id;
  final String name;
  final String image;
  final int bgColor;
  final String createdAt;
  final String updatedAt;

  CategoryItem({
    required this.id,
    required this.name,
    required this.image,
    required this.bgColor,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    int parseBgColor(dynamic value) {
      if (value == null) return 0xFFFFFFFF; // fallback white

      String colorStr = value.toString().trim();

      // Remove # if present
      if (colorStr.startsWith('#')) {
        colorStr = colorStr.substring(1);
      }

      // If color string is 6 characters (e.g. "ffffff"), add full alpha "FF" prefix
      if (colorStr.length == 6) {
        colorStr = 'FF$colorStr';
      }

      // Add 0x prefix if not present
      if (!colorStr.startsWith('0x') && !colorStr.startsWith('0X')) {
        colorStr = '0x$colorStr';
      }

      return int.tryParse(colorStr) ?? 0xFFFFFFFF;
    }

    return CategoryItem(
      id: json["_id"] ?? '',
      name: json["name"] ?? '',
      image: json["image"] ?? '',
      bgColor: parseBgColor(json["bgColor"]),
      createdAt: json["createdAt"] ?? '',
      updatedAt: json["updatedAt"] ?? '',
    );
  }
}

