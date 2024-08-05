import 'dart:convert';

List<Products> productsFromJson(String str) => List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

String productsToJson(List<Products> data) => json.encode(data.map((x) => x.toJson()).toList());

class Products {
  final int id;
  final String title;
  final double price;
  final String description;
  final bool isFeatured;
  final String clothesType;
  final double ratings;
  final List<String> colors;
  final List<String> imageUrls;
  final List<String> sizes;
  final DateTime createdAt;
  final int category;
  final int brand;

  Products({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.isFeatured,
    required this.clothesType,
    required this.ratings,
    required this.colors,
    required this.imageUrls,
    required this.sizes,
    required this.createdAt,
    required this.category,
    required this.brand,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json["id"],
        title: json["title"],
        price: (json["price"] as num).toDouble(),
        description: json["description"],
        isFeatured: json["is_featured"],
        clothesType: json["clothesType"],
        ratings: (json["ratings"] as num).toDouble(),
        colors: List<String>.from(json["colors"]),
        imageUrls: List<String>.from(json["imageUrls"]),
        sizes: List<String>.from(json["sizes"]),
        createdAt: DateTime.parse(json["created_at"]),
        category: json["category"],
        brand: json["brand"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "is_featured": isFeatured,
        "clothesType": clothesType,
        "ratings": ratings,
        "colors": colors,
        "imageUrls": imageUrls,
        "sizes": sizes,
        "created_at": createdAt.toIso8601String(),
        "category": category,
        "brand": brand,
      };
}
