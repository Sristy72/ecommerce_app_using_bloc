class AddCartResponseModel {
  final String? id;
  final String? user;
  final List<CartItem>? items;
  final num? total;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  AddCartResponseModel({
    this.id,
    this.user,
    this.items,
    this.total,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory AddCartResponseModel.fromJson(Map<String, dynamic> json) {
    return AddCartResponseModel(
      id: json['_id'],
      user: json['user'],
      items: json['items'] != null
          ? List<CartItem>.from(json['items'].map((x) => CartItem.fromJson(x)))
          : [],
      total: json['total'],
      createdAt:
      json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
      json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': user,
      'items': items?.map((x) => x.toJson()).toList(),
      'total': total,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': v,
    };
  }
}

class CartItem {
  final String? item;
  final int? quantity;
  final String? id;

  CartItem({
    this.item,
    this.quantity,
    this.id,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    String? itemId;
    if (json['item'] is Map) {
      itemId = json['item']['_id']?.toString() ?? json['item']['id']?.toString();
    } else if (json['item'] != null) {
      itemId = json['item'].toString();
    }

    return CartItem(
      item: itemId,
      quantity: (json['quantity'] as num?)?.toInt(),
      id: json['_id']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item': item,
      'quantity': quantity,
      '_id': id,
    };
  }
}
