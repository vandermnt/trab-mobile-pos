import 'dart:convert';
import 'package:trab_mobile_pos/model/client.dart';
import 'package:trab_mobile_pos/model/order_item.dart';

class Order {
  int? id;
  DateTime? date;
  Client? client;
  List<OrderItem>? items;

  Order(this.id, this.date, this.client, this.items);
  Order.novo(DateTime date, Client client, List<OrderItem> items) {
    this.date = date;
    this.client = client;
    this.items = items;
  }

  static Order fromMap(Map<String, dynamic> map) {
    var client = Client.fromMap(map['client']);
    var items = OrderItem.fromMaps(map['items']);

    return Order(
      map['id'],
      DateTime.parse(map['date']),
      client,
      items,
    );
  }

  static toJson(Order order) {
    var client = Client.toObject(order.client!);
    var items = order.items!.map((item) => OrderItem.toObject(item)).toList();

    return jsonEncode({
      "id": order.id,
      "date": order.date?.toIso8601String(),
      "client": client,
      "items": items
    });
  }

  static List<Order> fromMaps(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      return Order.fromMap(maps[i]);
    });
  }

  static Order fromJson(String j) => Order.fromMap(jsonDecode(j));
  static List<Order> fromJsonList(String j) {
    final parsed = jsonDecode(j).cast<Map<String, dynamic>>();
    return parsed.map<Order>((map) => Order.fromMap(map)).toList();
  }
}
