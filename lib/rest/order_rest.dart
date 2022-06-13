import 'dart:convert';

import 'package:trab_mobile_pos/model/order.dart';
import 'package:http/http.dart' as http;
import 'package:trab_mobile_pos/shared/config.dart';

class OrderRest {
  Future<List<Order>> getAll() async {
    var url = Uri.parse('${Config.baseUrl}/orders');
    http.Response? response;

    try {
      response = await http.get(url);
      return Order.fromJsonList(response.body);
    } catch (error) {
      throw error;
    }
  }

  Future<Order> create(Order order) async {
    var url = Uri.parse('${Config.baseUrl}/orders');
    http.Response? response;

    try {
      response = await http.post(url,
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          },
          body: Order.toJson(order));

      if (response.statusCode == 201) {
        return Order.fromJson(response.body);
      }

      throw Exception("Error create order!");
    } catch (error) {
      throw error;
    }
  }

  Future<void> delete(int orderId) async {
    var url = Uri.parse('${Config.baseUrl}/orders/$orderId');
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

      throw Exception("Error delete order!");
    } catch (error) {
      throw error;
    }
  }
}
