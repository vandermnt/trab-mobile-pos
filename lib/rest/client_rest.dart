import 'package:trab_mobile_pos/model/client.dart';
import 'package:http/http.dart' as http;
import 'package:trab_mobile_pos/shared/config.dart';

class ClientRest {
  Future<List<Client>> getAll() async {
    var url = Uri.parse('${Config.baseUrl}/clients');
    http.Response? response;

    try {
      response = await http.get(url);
      return Client.fromJsonList(response.body);
    } catch (error) {
      throw error;
    }
  }

  Future<Client> getByCpf(String cpf) async {
    var url = Uri.parse('${Config.baseUrl}/clients/cpf/$cpf');
    http.Response? response;

    try {
      response = await http.get(url);
      return Client.fromJson(response.body);
    } catch (error) {
      throw error;
    }
  }

  Future<Client> create(Client client) async {
    var url = Uri.parse('${Config.baseUrl}/clients');
    http.Response? response;

    try {
      response = await http.post(url,
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          },
          body: Client.toJson(client));

      if (response.statusCode == 201) {
        return Client.fromJson(response.body);
      }

      throw Exception("Error create client!");
    } catch (error) {
      throw error;
    }
  }

  Future<void> delete(int clientId) async {
    var url = Uri.parse('${Config.baseUrl}/clients/$clientId');
    http.Response? response;

    try {
      response = await http.delete(
        url,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      if (response.statusCode == 200) {
        return;
      }

      throw Exception("Error delete client!");
    } catch (error) {
      throw error;
    }
  }

  Future<void> update(Client client) async {
    var url = Uri.parse('${Config.baseUrl}/clients/${client.id}');
    http.Response? response;

    try {
      response = await http.put(url,
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          },
          body: Client.toJson(client));

      if (response.statusCode == 200) {
        return;
      }

      throw Exception("Error update client!");
    } catch (error) {
      throw error;
    }
  }
}
