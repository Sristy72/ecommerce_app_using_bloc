import 'get_popular_items_response_model.dart';

class GetItemByCategoryIdResponseModel {
  final int total;
  final int page;
  final int pages;
  final List<FoodItem> items;

  GetItemByCategoryIdResponseModel({
    required this.total,
    required this.page,
    required this.pages,
    required this.items,
  });

  factory GetItemByCategoryIdResponseModel.fromJson(Map<String, dynamic> json) {
    // Handle outer envelope { "success": true, "data": { "total": ..., "data": [...] } }
    final Map<String, dynamic> payload =
        (json["data"] is Map<String, dynamic>)
            ? (json["data"] as Map<String, dynamic>)
            : json;

    final rawList = (payload["data"] ?? payload["items"]) as List? ?? [];

    return GetItemByCategoryIdResponseModel(
      total: payload["total"] ?? 0,
      page: payload["page"] ?? 1,
      pages: payload["pages"] ?? 1,
      items: rawList
          .map((x) => FoodItem.fromJson(x as Map<String, dynamic>))
          .toList(),
    );
  }
}

class FoodItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String image;
  final Category category;
  final List<ItemIngredient> ingredients;
  final double rating;
  final int reviewsCount;

  FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
    required this.ingredients,
    required this.rating,
    required this.reviewsCount,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json["_id"] ?? '',
      name: json["name"] ?? '',
      description: json["description"] ?? '',
      price: (json["price"] as num?)?.toDouble() ?? 0.0,
      image: json["image"] ?? '',
      category: Category.fromJson(
        (json["category"] is Map<String, dynamic>)
            ? (json["category"] as Map<String, dynamic>)
            : {},
      ),
      ingredients: (json["ingredients"] as List<dynamic>? ?? [])
          .map((x) => ItemIngredient.fromJson(x as Map<String, dynamic>))
          .toList(),
      rating: (json["rating"] as num?)?.toDouble() ?? 0.0,
      reviewsCount: (json["reviewsCount"] as num?)?.toInt() ?? 0,
    );
  }
}

class Category {
  final String id;
  final String name;
  final String image;

  Category({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["_id"] ?? '',
      name: json["name"] ?? '',
      image: json["image"] ?? '',
    );
  }
}

