class GetCartResponseModel {
  final String id;
  final String user;
  final List<CartItem> items;
  final double total;
  final String createdAt;
  final String updatedAt;

  GetCartResponseModel({
    required this.id,
    required this.user,
    required this.items,
    required this.total,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GetCartResponseModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> payload =
        (json["data"] is Map<String, dynamic>)
            ? (json["data"] as Map<String, dynamic>)
            : json;

    var itemsList = payload['items'] as List<dynamic>? ?? [];
    return GetCartResponseModel(
      id: payload['_id']?.toString() ?? '',
      user: payload['user']?.toString() ?? '',
      items: itemsList
          .whereType<Map<String, dynamic>>()
          .map((e) => CartItem.fromJson(e))
          .where((cartItem) => cartItem.item != null)
          .toList(),
      total: (payload['total'] as num?)?.toDouble() ?? 0.0,
      createdAt: payload['createdAt']?.toString() ?? '',
      updatedAt: payload['updatedAt']?.toString() ?? '',
    );
  }
}

class CartItem {
  final String id;
  final ItemDetails? item;
  int quantity;

  CartItem({
    required this.id,
    this.item,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    final itemJson = json['item'];
    return CartItem(
      id: json['_id']?.toString() ?? '',
      item: itemJson == null || itemJson is! Map<String, dynamic>
          ? null
          : ItemDetails.fromJson(itemJson),
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
    );
  }
}

class ItemDetails {
  final String id;
  final String name;
  final double price;
  final String description;
  final String image;

  ItemDetails({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  factory ItemDetails.fromJson(Map<String, dynamic> json) {
    return ItemDetails(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json["description"]?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      image: json['image']?.toString() ?? '',
    );
  }
}