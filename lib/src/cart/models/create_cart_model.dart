import 'dart:convert';

CreateCartModel createCartModelFromJson(String str) => CreateCartModel.fromJson(json.decode(str));

String createCartModelToJson(CreateCartModel data) => json.encode(data.toJson());

class CreateCartModel {
  final int product;
  final String color;
  final int quantity;
  final int size;

  CreateCartModel({
    required this.product,
    required this.color,
    required this.quantity,
    required this.size,
  });

  factory CreateCartModel.fromJson(Map<String, dynamic> json) => CreateCartModel(
        product: json["product"],
        color: json["color"],
        quantity: json["quantity"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "product": product,
        "color": color,
        "quantity": quantity,
        "size": size,
      };
}
