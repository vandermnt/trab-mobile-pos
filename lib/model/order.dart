import 'dart:convert';

class Order {
  int? id;
  String? cpf;
  String? name;
  String? lastName;

  Order(this.id, this.cpf, this.name, this.lastName);
  Order.novo(String name, String lastName, String cpf) {
    this.name = name;
    this.lastName = lastName;
    this.cpf = cpf;
  }

  static Order fromMap(Map<String, dynamic> map) {
    return Order(
      map[1],
      map['name'],
      map['lastName'],
      map['cpf'],
    );
  }

  static toJson(Order client) {
    return jsonEncode(
        {"name": client.name, "lastName": client.lastName, "cpf": client.cpf});
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
