import 'dart:convert';
import 'package:trab_mobile_pos/model/product.dart';

class OrderItem {
  int? id;
  Product? product;
  int? quantity;

  OrderItem(this.id, this.product, this.quantity);
  OrderItem.novo(Product product, int quantity) {
    this.product = product;
    this.quantity = quantity;
  }

  static OrderItem fromMap(Map<String, dynamic> map) {
    var product = Product.fromMap(map['product']);

    return OrderItem(
      map['id'],
      product,
      map['quantity'],
    );
  }

  static toObject(OrderItem orderItem) {
    var product = Product.toObject(orderItem.product!);

    return {
      "id": orderItem.id,
      "product": product,
      "quantity": orderItem.quantity,
    };
  }

  static List<OrderItem> fromMaps(List<dynamic> maps) {
    return List.generate(maps.length, (i) {
      return OrderItem.fromMap(maps[i]);
    });
  }

  static OrderItem fromJson(String j) => OrderItem.fromMap(jsonDecode(j));
  static List<OrderItem> fromJsonList(String j) {
    final parsed = jsonDecode(j).cast<Map<String, dynamic>>();
    return parsed.map<OrderItem>((map) => OrderItem.fromMap(map)).toList();
  }
}
