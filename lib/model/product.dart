import 'dart:convert';

class Product {
  int? id;
  String? description;

  Product(this.id, this.description);
  Product.novo(String description) {
    this.description = description;
  }

  static Product fromMap(Map<String, dynamic> map) {
    return Product(
      map["id"],
      map['description'],
    );
  }

  static String toJson(Product product) {
    return jsonEncode(toObject(product));
  }

  static toObject(Product product) {
    return {
      "id": product.id,
      "description": product.description,
    };
  }

  static List<Product> fromMaps(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      return Product.fromMap(maps[i]);
    });
  }

  static Product fromJson(String j) => Product.fromMap(jsonDecode(j));
  static List<Product> fromJsonList(String j) {
    final parsed = jsonDecode(j).cast<Map<String, dynamic>>();
    return parsed.map<Product>((map) => Product.fromMap(map)).toList();
  }
}
