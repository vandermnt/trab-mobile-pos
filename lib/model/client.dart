import 'dart:convert';

class Client {
  int? id;
  String? cpf;
  String? name;
  String? lastName;

  Client(this.id, this.name, this.lastName, this.cpf);
  Client.novo(String name, String lastName, String cpf) {
    this.name = name;
    this.lastName = lastName;
    this.cpf = cpf;
  }

  static Client fromMap(Map<String, dynamic> map) {
    return Client(
      map['id'],
      map['name'],
      map['lastName'],
      map['cpf'],
    );
  }

  static toJson(Client client) {
    return jsonEncode(
        {"name": client.name, "lastName": client.lastName, "cpf": client.cpf});
  }

  static List<Client> fromMaps(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      return Client.fromMap(maps[i]);
    });
  }

  static Client fromJson(String j) => Client.fromMap(jsonDecode(j));
  static List<Client> fromJsonList(String j) {
    final parsed = jsonDecode(j).cast<Map<String, dynamic>>();
    return parsed.map<Client>((map) => Client.fromMap(map)).toList();
  }
}
